-- добавил в профили 24 пользователя
INSERT INTO profiles (user_id, gender, birthday, city, country) VALUES
(4, 'f', '1995-11-25', 'Moscow', 'Russia'),
(5, 'm', '2008-02-19', 'Moscow', 'Russia'),
(45, 'm', '2015-02-25', 'New-york', 'USA'),
(55, 'm', '1998-05-26', 'Saint-Pétersbourg', 'Russia'),
(56, 'm', '2008-07-23', 'Varsovie', 'Pologne'),
(57, 'f', '2010-09-28', 'Saint-Pétersbourg', 'Russia'),
(58, 'f', '1988-12-31', 'New-york', 'USA'),
(59, 'm', '1963-12-05', 'New-york', 'USA'),
(60, 'f', '1973-10-01', 'New-york', 'USA'),
(61, 'm', '2008-01-03', 'Varsovie', 'Pologne'),
(62, 'f', '1965-08-06', 'Saint-Pétersbourg', 'Russia'),
(63, 'm', '1968-08-07', 'Syktyvkar', 'Russia'),
(65, 'm', '1988-04-23', 'Syktyvkar', 'Russia'),
(66, 'm', '2000-06-30', 'Moscow', 'Russia'),
(67, 'f', '2010-01-01', 'Moscow', 'Russia'),
(68, 'm', '2018-08-08', 'Moscow', 'Russia'),
(69, 'm', '2012-11-30', 'Syktyvkar', 'Russia'),
(70, 'f', '1975-09-28', 'Moscow', 'Russia'),
(71, 'f', '1976-04-03', 'Varsovie', 'Pologne'),
(72, 'f', '1999-10-16', 'Syktyvkar', 'Russia'),
(73, 'f', '2012-10-15', 'Moscow', 'Russia'),
(74, 'f', '2014-08-18', 'Moscow', 'Russia'),
(75, 'm', '1992-05-21', 'Kirov', 'Russia'),
(76, 'f', '2015-02-05', 'Berlin', 'Deutch');

-- добавил 10 записей на стену
INSERT INTO record_wall (from_user_id, to_user_id, media_types_id, txt) VALUES
('76', '70', '1', 'Schöne Landschaft bei uns in Deutschland'),
('71', '73', '1', 'Und wir haben jetzt eine Neuausrichtung'),
('1', '55', '1', 'Aqui está um documento sobre literatura educacional, em troca, peço que envie os cursos do seu paísl'),
('56', '1', '1', 'Obrigado pelo material, aqui está o curso'),
('53', '5', '1', 'Imagem fotográfica da propriedade de Varsóvia'),
('59', '56', '1', 'O Kremlin e a Praça Vermelha'),
('45', '45', '1', 'фотоизображение книги'),
('55', '75', '1', 'физ-зарядка'),
('2', '64', '1', 'книга-талантов'),
('68', '2', '1', 'Fächer-Tal');

-- добавил 13 сообщений
INSERT INTO messages (from_user_id,to_user_id, txt) VALUES
('2', '55', 'Привет'),
('2', '55', 'Как дела'),
('55', '2', 'Привет!'),
('55', '2', 'Все хорошо, работаю'),
('55', '2', 'А как твои дела, чем занят'),
('2', '55', 'тоже все хорошо'),
('2', '55', 'дома в отпуске отдыхаю'),
('55', '2', 'Понятно, кстати приглашаю тебя на футбол. Пойдешь?'),
('2', '55', 'Да'),
('2', '55', 'А восколько и где встречаемся'),
('55', '2', 'У фонтана возле стадиона в 19'),
('2', '55', 'хорошо, до встречи'),
('55', '2', 'до встречи');

-- отметка доставки сообщения
UPDATE messages 
SET
	is_delivered = TRUE;

-- добавил 13 медиафайлов 
INSERT INTO media (user_id , media_types_id, file_name, file_size) VALUES
('56', '2', 'Алые паруса.mp3', '150'),
('57', '1', 'Tank.jpeg', '350'),
('4', '1', 'Zero_brud.jpeg', '500'),
('4', '3', 'plan.pdf', '1024'),
('76', '3', 'Homework.sql', '2048'),
('75', '3', 'Agata_buch.pdf', '1024'),
('45', '1', 'парусник.jpeg', '550'),
('55', '2', 'Михаил Круг.mp3', '350'),
('69', '2', 'English_buch.mp3', '150'),
('63', '3', 'mafia.jpeg', '310'),
('56', '1', 'Аэропорт.mp3', '560'),
('58', '1', 'Boing.jpeg', '355'),
('60', '1', 'Airobus.jpeg', '351');

-- добавил 10 записей лайков
INSERT INTO likes (from_user_id, to_user_id, media_types_id) VALUES
('76', '3', '1'),
('3', '55', '1'),
('56', '57', '1'),
('56', '56', '1'),
('63', '1', '1'),
('4', '45', '2'),
('73', '76', '1'),
('45', '56', '1'),
('63', '63', '1'),
('70', '60', '2');

-- добавил 12 друзей
INSERT INTO friend_requests (from_user_id, to_user_id) VALUES
('2', '76'),
('76', '2'),
('55', '45'),
('60', '73'),
('4', '76'),
('45', '57'),
('59', '67'),
('70', '73'),
('70', '72'),
('69', '65'),
('66', '56'),
('45', '2');

-- подтверждение заявки
UPDATE friend_requests 
SET
	accepted = TRUE;

-- -- добавил 10 сообществ
INSERT INTO communities (name, description, admin_id) VALUES
('анекдоты', 'шутки и разные смешилки', '45'),
('Help', 'Help_poisk', '73'),
('Deutch_buch', 'Deutch riddle buch', '76'),
('World_of_press', 'newspapers, news', '55'),
('улица', 'разные физические занятия и посты', '45'),
('наука и техника', 'изобритения будущего', '2'),
('news', 'новости и происшествия', '67'),
('cafee', 'рейтинг кафе', '64'),
('Общество', 'развитие общественности', '72'),
('Buch', 'Книги из разных стран', '4');

-- добавил 11 записей о добовлении в сообщества
INSERT INTO communities_users (community_id, user_id) VALUES
('7', '4'),
('12', '55'),
('1', '58'),
('8', '76'),
('11', '75'),
('2', '45'),
('9', '3'),
('6', '57'),
('5', '60'),
('4', '62'),
('3', '67');

-- добавил 12 приложений и игр
INSERT INTO applications (applications_from_id, user_id, name_applications) VALUES
('3','45','карты'),
('55','60','love_bottle'),
('76','75','Arma'),
('73','59','music'),
('75','60','photo_editor'),
('66','1','Text_editor'),
('58','5','шутер'),
('62','58','знакомства'),
('60','69','Buch_reader'),
('70','76','Tank'),
('5','45','secrets'),
('4','75','sbk');







