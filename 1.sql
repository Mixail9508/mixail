
-- создал таблицу logs на движке Arhive
DROP TABLE IF EXISTS logs;

CREATE TABLE logs(
	name_table VARCHAR(82) NOT NULL,
	id BIGINT NOT NULL,
	name_value VARCHAR(82) NOT NULL,
	created_at DATETIME NOT NULL
)ENGINE=Archive;

-- создал триггер на добавлении таблицы users в таблицу logs
DROP TRIGGER IF EXISTS table_users_logs;

DELIMITER //

CREATE TRIGGER table_users_logs AFTER INSERT ON users
FOR EACH ROW 
BEGIN 
	INSERT INTO logs (created_at, name_table, id, name_value)
	VALUES (NOW(), 'users', NEW.id, NEW.first_name);
END//

DELIMITER ;

-- проверил таблицу users и общую таблицу logs
SELECT * FROM users;
SELECT * FROM logs;

-- заполнил
INSERT INTO users (first_name, last_name, email, phone)
VALUES ('Лола', 'Баеш', 'lola@yandex.ru', '89556994578');

-- заполнил
INSERT INTO users (first_name, last_name, email, phone)
VALUES ('Диана', 'Лощилова', 'diana@gmail.com', '89559516498'),
		('Ксюша', 'Ангидак', 'ksusha12@yandex.ru', '89776731946'),
		('Кристина', 'Дуоколд', 'kristi@mail.ru', '89042071507'),
		('Лиза', 'Андреева', 'lisa557@yandex.ru', '89550896437');

-- создал триггер на добавлении таблицы catalogs в таблицу logs
DROP TRIGGER IF EXISTS table_catalogs_logs;

DELIMITER //

CREATE TRIGGER table_catalogs_logs AFTER INSERT ON catalogs
FOR EACH ROW 
BEGIN 
	INSERT INTO logs (created_at, name_table, id, name_value)
	VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END//

DELIMITER ;

-- заполнил
INSERT INTO catalogs (name) VALUES
('водонагреватели'), ('стиральные машины'), ('микроволновые печи'),
('холодильники'), ('аудиосистемы'), ('сотовые телефоны');

-- проверил таблицу catalogs и общую таблицу logs
SELECT * FROM catalogs;
SELECT * FROM logs;

-- создал триггер на добавлении таблицы products в таблицу logs
DROP TRIGGER IF EXISTS table_products_logs;

DELIMITER //

CREATE TRIGGER table_products_logs AFTER INSERT ON products
FOR EACH ROW 
BEGIN 
	INSERT INTO logs (created_at, name_table, id, name_value)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END//

DELIMITER ;

-- заполнил 
INSERT INTO products (name,description) VALUES
('помидоры', 'Помидор - это и ягода, и овощ. Термин "овощи" - кулинарный, его употребление не слишком систематично и в основном подчиняется исторической традиции. Термин "ягоды" - биологический, обозначает конкретный тип плодов, к которому относятся в том числе и помидоры.'),
('мороженное', 'Моро́женое — пищевой продукт-десерт, представляющий собой замороженную в процессе непрерывного взбивания массу, содержащую в основе своей питательные, вкусовые, ароматические и эмульгирующие вещества. К мороженому нередко относят также фруктовый лёд, получаемый простым замораживанием фруктово-ягодных соков и пюре (из апельсина чаще всего делают фруктовый лёд).'),
('клубника', 'Клубника – это дикая зеленая земляника. Свое название она получила благодаря специфической форме ягод, которые внешне напоминают клубочки.'),
('китайская капуста', 'Пеки́нская капу́ста (лат. Brassica rapa subsp. pekinensis), или китайская капуста, или петсай (англ. pe-tsai), или салатная капуста — травянистое растение семейства Капустные (Brassicaceae), овощная культура; подвид репы (Brassica rapa).'),
('кефир', 'Кефир (от тур. кеф - здоровье) – это питательный напиток, полученный из молока путем брожения кисломолочных бактерий: палочек, стрептококков, дрожжей, уксусных бактерий и еще около 16 видов.'),
('макароны', 'Макаро́ны (итал. Maccheroni) — трубчатые макаронные изделия (тесто), из высушенного пшеничного теста, замешанного на воде. Некоторые макароны длиной схожи со спагетти, но полые внутри. В русском языке макаронами называют макаронные изделия в целом (собственно макароны, рожки, перья, вермишель, лапша и т. п.).'),
('чеснок', 'Чеснок – это многолетнее растение из рода Лук. Русское название чеснока происходит от православного глагола «чесать, рвать», что имело значение «расщепленная луковица». Чеснок именно так и выглядит, как расщепленная на дольки-зубчики луковица.'),
('огурцы', 'Огурцы - древнейший овощ, который был известен еще с Античных времен. Родиной огурцов является Западная Индия.'),
('арбуз', 'Арбуз - это большая, сладкая и низкокалорийная тыквина (еще недавно, правда, называвшаяся ягодой), состоящая в основном из воды.'),
('кешью', 'Кешью – съедобный ореховидный плод, произрастающий на вечнозеленом дереве семейства Сумаховых. Данный продукт обладает изысканным сладковато-сливочным вкусом, ввиду чего его широко используют в кулинарии.');

-- проверил таблицу products и общую таблицу logs
SELECT * FROM products;
SELECT * FROM logs;