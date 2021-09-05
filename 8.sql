
-- создал отдельную таблицу
CREATE TABLE vi(
	value BIGINT NOT NULL
);

-- заполнил таблицу данными
INSERT INTO vi (value) VALUES
('1'),
('2'),
('3'),
('4'),
('5');

-- вычесление произведения
SELECT exp(sum(ln(value))) FROM vi;

