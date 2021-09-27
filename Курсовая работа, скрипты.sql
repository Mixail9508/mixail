-- скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы);

-- Вывожу товар с его категорией в алфовитном порядке с ценой и валютой
SELECT cp.name AS cat_name, p2.name, p.price_tag, p.currency 
FROM price p 
JOIN
	products p2
	ON p2.id = p.number_prod
JOIN 
	categories_prod cp 
	ON cp.id = p2.cat_prod_id 
ORDER BY cp.name;

-- вывожу должность работника с фамилией и именем и какую категорию товара выставляет в зале
SELECT p.name_pos, w.last_name, w.first_name, cp.name AS product_placement_1, cp2.name AS product_placement_2 
FROM workers w
JOIN
	positions p
	ON p.id_workers = w.id 
JOIN
	categories_prod cp
	ON w.product_placement_1 = cp.id
JOIN 
	categories_prod cp2
	ON w.product_placement_2 = cp2.id
GROUP BY cp.name;

-- вложеные таблицы с применением JOIN объеденения и группировку по категории товара основго или дополнительного

-- вывожу самого молодого работника с его должностью и какие категории товаров он выставляет
SELECT p.name_pos , w.last_name, w.first_name, cp.name AS product_placement_1, cp2.name AS product_placement_2, p2.name AS product_1, p3.name AS product_2
FROM workers w 
JOIN
	categories_prod cp
	ON w.product_placement_1 = cp.id 
JOIN
	categories_prod cp2
	ON w.product_placement_2 = cp2.id
JOIN 
	positions p
	ON p.id_workers = w.id 
JOIN 
	products p2 
	ON p2.cat_prod_id = cp.id 
JOIN 
	products p3
	ON p3.cat_prod_id = cp2.id 
	WHERE birthday = (SELECT MAX(birthday) FROM workers)
	GROUP BY cp.name OR cp2.name;


-- ● представления (минимум 2);

-- первое представление соотносит продукты к их категориям
CREATE VIEW prod_and_categories_prod AS 
SELECT cp.name AS categories, p.name AS prodeucts
FROM products p 
JOIN
	categories_prod cp
	ON p.cat_prod_id = cp.id;

-- добавил группировку категорий товаров чтобы былы по одному товару на категорию
SELECT * FROM prod_and_categories_prod GROUP BY categories;

-- второе представление выводит должность, фамилию, имя и возвраст работников
CREATE VIEW  age_works AS 
SELECT p.name_pos, w.last_name, w.first_name, (YEAR(CURRENT_DATE) - YEAR(birthday))
  AS age 
FROM workers w
JOIN 
	positions p 
	ON p.id_workers = w.id
	GROUP BY w.first_name
	ORDER BY age DESC;

SELECT * FROM age_works;

-- ● хранимые процедуры / триггеры;

-- создал процедуру которая ищет по нужному нам id, фамилию, имя, и категорию товаров которую он выставляет, в случае если у него нет сектора тоаров пишет NULL
DROP PROCEDURE IF EXISTS quick_search;

DELIMITER //

CREATE PROCEDURE quick_search(IN search_id BIGINT UNSIGNED)
BEGIN
	SELECT p2.name_pos, w.last_name, w.first_name, 
	cp.name product_placement_1, cp2.name product_placement_2,
	p.name prod_1, p3.name prod_2
	FROM positions p2 
	JOIN workers w ON p2.id_workers = w.id
	LEFT JOIN categories_prod cp ON w.product_placement_1 = cp.id
	LEFT JOIN categories_prod cp2 ON w.product_placement_2 = cp2.id
	LEFT JOIN products p ON cp.id = p.cat_prod_id
	LEFT JOIN products p3 ON cp2.id = p3.cat_prod_id 
	WHERE p2.id=search_id
	GROUP BY cp.name;
END //

DELIMITER ;

CALL quick_search(7);



-- триггер

-- триггер который не допускает ввода года рождения больше нынышнего и не позволяет сатвить год ниже 70 лет
DROP TRIGGER IF EXISTS the_right_birthday;

DELIMITER //

CREATE TRIGGER the_right_birthday BEFORE INSERT ON workers
FOR EACH ROW
BEGIN 
	IF NEW.birthday >= current_date() THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'the date of birth exceeds the current year!';
	END IF;
	IF NEW.birthday < DATE_SUB(CURDATE(), INTERVAL 70 YEAR) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The date of birth cannot be less than 1951!';
	END IF;
END//

DELIMITER ;

-- работает правильно
INSERT INTO workers (last_name, first_name, email, phone, password_hash, passport, address, gender, product_placement_1, product_placement_2, birthday) VALUES
('Клименко', 'Маруся', 'maruska@gmail.com', '89042273159', '568990', '9616547888', 'ул. Ленина д.1 кв. 20', 'f', DEFAULT, DEFAULT, '1985-08-12');

-- выскакивает ошибка о большом возрасте работника
INSERT INTO workers (last_name, first_name, email, phone, password_hash, passport, address, gender, product_placement_1, product_placement_2, birthday) VALUES
('Милонян', 'Андрей', 'andrey23@gmail.com', '89042273555', DEFAULT, '5134951763', 'ул. Ленина д.14 кв. 335', 'm', DEFAULT, DEFAULT, '1901-08-12');

-- выскакивает ошибка о превышении нынешнего года
INSERT INTO workers (last_name, first_name, email, phone, password_hash, passport, address, gender, product_placement_1, product_placement_2, birthday) VALUES
('Тарзан', 'Илья', 'ilya34@gmail.com', '89992258962', DEFAULT, '5134584236', 'ул. Пушкина д.1 кв. 46', 'm', DEFAULT, DEFAULT, '2024-08-12');


