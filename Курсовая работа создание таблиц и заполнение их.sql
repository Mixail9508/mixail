

Таблицы(Продуктовый магазин Пятерочка):
	1. Продукты 
	2. Категории продуктов 
	3. работники(личные данные) 
	4. Акции 
	5. Остаток продуктов
	6. Заказ продуктов 
	7. Продажи 
	8. Списание 
	9. цена 
	10. Должности 
	11. Касса 
	
-- база данных под мою курсовую
CREATE DATABASE x5;
USE x5;

-- 1. Продукты
CREATE TABLE categories_prod(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	INDEX (name)
);

-- заполнил сам
INSERT INTO categories_prod (name) VALUES
('рыбные'),
('мясные'),
('кондитерские'),
('молочные'),
('ФРОВ'), -- фрукты и овощи
('прикасса'),
('химия'),
('напитки безалкогольные'),
('алкогольные напитки'),
('хлебобулочные изделия');

-- 2. Категории продуктов 
CREATE TABLE products(
	id SERIAL,
	name VARCHAR(100) NOT NULL,
	cat_prod_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME NOT NULL DEFAULT NOW(),
	updated_at DATETIME DEFAULT  CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX (name),
	FOREIGN KEY(cat_prod_id) REFERENCES categories_prod(id)
);	

-- заполнил сам
INSERT INTO products (name, cat_prod_id) VALUES
('голень куринная', '2'), ('колбоса', '2'),
('хлеб', '10'), ('стиральный порошок', '7'),
('вода', '8'), ('минтай', '1'),
('коньяк', '9'), ('шоколад сникерс', '6'),
('сало', '2'), ('торт', '3'),
('молоко', '4'), ('COLA', '8'),
('пельмени', '2'), ('сгущенка', '4'),
('яблоки', '5'), ('картофель', '5'),
('кефир', '4'), ('сосиски', '2'),
('йогурт', '4'), ('сок Добрый', '8'),
('арбуз', '5'), ('селедка', '1');

-- 3. работники(личные данные) 
CREATE TABLE workers(
	id SERIAL PRIMARY KEY,
	last_name VARCHAR(100) NOT NULL,
	first_name VARCHAR(100) NOT NULL,
	email VARCHAR(150) NOT NULL UNIQUE,
	phone CHAR(11) NOT NULL,
	password_hash CHAR(65) DEFAULT NULL,
	passport CHAR(39) NOT NULL,
	address VARCHAR(200) DEFAULT NULL,
	gender ENUM('f', 'm') NOT NULL,
	product_placement_1 BIGINT UNSIGNED DEFAULT NULL,
	product_placement_2 BIGINT UNSIGNED DEFAULT NULL, 
	birthday DATE NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	KEY (product_placement_1),
	KEY (product_placement_2),
	INDEX search_last (last_name),
	INDEX search_first (first_name),
	FOREIGN KEY(product_placement_1) REFERENCES categories_prod(id),
	FOREIGN KEY(product_placement_2) REFERENCES categories_prod(id)
);

-- заполнил сам
INSERT INTO workers (last_name, first_name, email, phone, password_hash, passport, address, gender, product_placement_1, product_placement_2, birthday) VALUES
('Кузьмина', 'Екатерина', 'katya@mail.com', '89042256372', '568990', '9613559988', 'ул. Смольная д.9 кв. 12', 'f', DEFAULT, DEFAULT, '1979-08-12'),
('Блинов', 'Виктор', 'vik27@gmail.com', '89046438887', '128901', '8764770995', 'ул. Озерная д. 322 кв. 27', 'm', DEFAULT, DEFAULT, '1994-12-30'),
('Деревянко', 'Дмитрий', 'dima@yandex.ru', '89222255742', DEFAULT, '8790520668', 'ул. Красня д.34 кв. 13', 'm', '2', '4', '1992-04-23'),
('Кузьницова', 'Елена', 'elena_kuz@yandex.ru', '89596976352', DEFAULT, '3409337642', 'ул. Ермолина гора д.4 кв. 548', 'f', '10', '7', '1982-01-30'),
('Демидова', 'Марина', 'marina@gmail.com', '89043369921', '004658', '2154537654', 'ул. Восницкого д.46 кв. 65 ', 'f', DEFAULT, DEFAULT, '1991-12-03'),
('Малых', 'Виталик', 'vitalik@yandex.ru', '89226678585', '115468', '9715643555', 'ул. 9 микрорайон д. 14 кв. -', 'm', '3', '6', '1985-03-20'),
('Кукушкин', 'Вадим', 'vadim@exampl.ru', '89110003452', '138896', '2580163582', 'ул. 9 Мая д.1 кв. 25', 'm', '2', DEFAULT, '1987-07-27'),
('Снигерев', 'Владимер', 'vova293@mail.com', '89046798564', DEFAULT, '6587412365', 'ул. Дробная д. 19 кв. -', 'm', '9', '5', '1995-05-14'),
('Силявко', 'Константин', 'kostyan@yandex.ru', '89775506762', '22550', '6325753159', DEFAULT, 'm', DEFAULT, '8', '1990-05-25'),
('Дроздов', 'Михаил', 'mikhail96@rambler.ru', '89555569911', DEFAULT, '6482591375', 'ул. Заморская д. 12 кв. 81', 'm', '1', '4', '1996-09-05'),
('Клименко', 'Мария', 'mariya_k@yandex.ru', '89042256985', DEFAULT, '2975864372', DEFAULT, 'f', DEFAULT, DEFAULT, '1988-02-15'); 

-- 4. Акции
CREATE TABLE stocks(
	id SERIAL PRIMARY KEY,
	price_id_stock BIGINT UNSIGNED DEFAULT NULL,
	prod_id BIGINT UNSIGNED NOT NULL,
	percent DECIMAL DEFAULT NULL,
	KEY (price_id_stock),
	KEY (prod_id),
	FOREIGN KEY (price_id_stock) REFERENCES price(id),
	FOREIGN KEY (prod_id) REFERENCES products(id)
);

-- заполнил сам
INSERT INTO stocks (price_id_stock, prod_id, percent) VALUES
('1', '1', '33'), ('2', '2', '28'),
('3', '3', DEFAULT), ('4', '4', '12'),
('5', '5', DEFAULT), ('6', '6', DEFAULT),
('7', '7', '5'), ('8', '8', DEFAULT),
('9', '9', DEFAULT), ('10', '10', '8'),
('11', '11', DEFAULT), ('12', '12', DEFAULT),
('13', '13', '18'), ('14', '14', DEFAULT),
('15', '15', DEFAULT), ('16', '16', DEFAULT),
('17', '17', DEFAULT), ('18', '18', '32'),
('19', '19', DEFAULT), ('20', '20', '23'),
('21', '21', '50'), ('22', '22', DEFAULT);

-- 5. Остаток продуктов
CREATE TABLE remaining_prod(
	id SERIAL PRIMARY KEY,
	prod_id BIGINT UNSIGNED NOT NULL,
	quantity INT NOT NULL,
	measure VARCHAR(20),
	updated_at DATETIME DEFAULT  CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	KEY (prod_id),
	FOREIGN KEY (prod_id) REFERENCES products(id)
); 

-- заполнил сам
INSERT INTO remaining_prod (prod_id, quantity, measure) VALUES
('1', '0', 'шт.'), ('2', '150', 'шт.'),
('3', '25', 'шт.'), ('4', '10', 'шт.'),
('5', '210', 'шт.'), ('6', '12', 'кг.'), 
('7', '142', 'шт.'), ('8', '58', 'шт.'), 
('9', '5', 'кг.'), ('10', '1', 'шт.'),
('11', '21', 'шт.'), ('12', '43', 'шт.'),
('13', '0', 'шт.'), ('14', '-1', 'шт.'),
('15', '29', 'кг.'), ('16', '15', 'кг.'),
('17', '46', 'шт.'), ('18', '142', 'шт.'),
('19', '15', 'шт.'), ('20', '240', 'шт.'),
('21', '36', 'кг.'), ('22', '24', 'шт.');

-- 6. Заказ продуктов
CREATE TABLE ordering_prod(
	id SERIAL PRIMARY KEY,
	prod_id BIGINT UNSIGNED NOT NULL,
	quantity INT NOT NULL,
	measure VARCHAR(20),
	KEY (prod_id),
	FOREIGN KEY (prod_id) REFERENCES products(id)
);

-- заполнил сам
INSERT INTO ordering_prod (prod_id, quantity, measure) VALUES
('1', '90', 'шт.'),
('10', '20', 'шт.'), 
('11', '30', 'шт.'),
('13', '43', 'шт.'),
('14', '68', 'шт.'),
('16', '120', 'кг.'), 
('21', '15', 'кг.'); 

-- 7. Продажи 
CREATE TABLE sales(
	id SERIAL PRIMARY KEY,
	quantity BIGINT UNSIGNED NOT NULL,
	measure VARCHAR(20) NOT NULL,
	sales_id BIGINT UNSIGNED NOT NULL,
	rema_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (sales_id) REFERENCES products(id),
	FOREIGN KEY (rema_id) REFERENCES remaining_prod(id)
);

-- заполнил сам
INSERT INTO sales (quantity, measure, sales_id, rema_id) VALUES
('25', 'шт.', '2', '2'),
('59', 'шт.', '7', '7'),
('3', 'кг', '16', '16'),
('4', 'шт', '11', '11'),
('11', 'шт', '3', '3');

-- 8. Списание 
CREATE TABLE write_downs(
	id SERIAL PRIMARY KEY,
	quantity BIGINT UNSIGNED NOT NULL,
	measure VARCHAR(20) NOT NULL,
	sales_id BIGINT UNSIGNED NOT NULL,
	rema_id BIGINT UNSIGNED NOT NULL,
	reason TEXT NOT NULL,
	FOREIGN KEY (sales_id) REFERENCES products(id),
	FOREIGN KEY (rema_id) REFERENCES remaining_prod(id)
);

-- заполнил сам
INSERT INTO write_downs (quantity, measure, sales_id, rema_id, reason) VALUES
('1', 'кг', '16', '16', 'гнилые картофельны'),
('3', 'шт', '11', '11', 'просрок'),
('1', 'шт', '4', '4', 'дефект');

-- 9. цена
CREATE TABLE price(
	id SERIAL PRIMARY KEY,
	number_prod BIGINT UNSIGNED NOT NULL,
	price_tag FLOAT NOT NULL,
	currency VARCHAR(100) NOT NULL,
	created_at DATETIME NOT NULL DEFAULT NOW(),
	updated_at DATETIME DEFAULT  CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (number_prod) REFERENCES products(id)
);

-- заполнил сам
INSERT INTO price (number_prod, price_tag, currency) VALUES
('1', '269.99', 'руб.'), ('2', '240.25', 'руб.'),
('3', '41.00', 'руб.'), ('4', '368.40', 'руб.'),
('5', '39.90', 'руб.'), ('6', '218.30', 'руб.'),
('7', '1495.00', 'руб.'), ('8', '70.00', 'руб.'),
('9', '115.99', 'руб.'), ('10', '429.50', 'руб.'),
('11', '78.34', 'руб.'), ('12', '115.33', 'руб.'),
('13', '126.12', 'руб.'), ('14', '104.00', 'руб.'),
('15', '89.60', 'руб.'), ('16', '58.00', 'руб.'),
('17', '68.20', 'руб.'), ('18', '260.90', 'руб.'),
('19', '51.30', 'руб.'), ('20', '115.00', 'руб.'),
('21', '34.21', 'руб.'), ('22', '109.00', 'руб.');

-- 10. Должности
CREATE TABLE positions(
	id SERIAL PRIMARY KEY,
	name_pos VARCHAR(250) NOT NULL,
	id_workers BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (id_workers) REFERENCES workers(id)
);

-- заполнил сам
INSERT INTO positions (name_pos, id_workers) VALUES
('Директор', '1'),
('Замдиректор', '2'),
('работник торгового зала', '3'),
('продавец-кассир', '4'),
('работник торгового зала', '5'),
('продавец-кассир', '6'),
('продавец-кассир', '7'),
('работник торгового зала', '6'),
('работник торгового зала', '7'),
('грузчик', '8'),
('работник торгового зала', '8'),
('администратор', '9'),
('администратор', '10'),
('охранник', '11');

-- 11. Касса
CREATE TABLE box_office(
	id SERIAL PRIMARY KEY,
	number_kass VARCHAR(10) NOT NULL,
	name_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME NOT NULL DEFAULT NOW(),
	updated_at DATETIME DEFAULT  CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (name_id) REFERENCES workers(id)
);

-- заполнил сам
INSERT INTO box_office (number_kass, name_id) VALUES
('касса № 1', '4'),
('касса № 2', '6'),
('касса № 3', '7'),
('касса № 4', '9'),
('касса № 5', '10');
