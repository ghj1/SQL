-- mydb database 생성
CREATE  DATABASE mydb;
CREATE  DATABASE okdb;

-- DB 선택 명령
use mydb;
use okdb;

-- mytable datatables 생성
CREATE TABLE mytable(
id INT UNSIGNED NOT NULL AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
modelnumber VARCHAR(15) NOT NUll,
series VARCHAR(30) NOT NULL,
PRIMARY KEY(id));

-- okdb table 생성
CREATE TABLE myt(
id INT UNSIGNED NOT NULL AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
modelnumber VARCHAR(15) NOT NUll,
series VARCHAR(30) NOT NULL,
PRIMARY KEY(id));

-- 데이터 create( INSERT into) 
use mydb;
INSERT INTO mytable VALUES(1, 'i7', '7700', 'Kaby Lake');
INSERT INTO mytable (name, modelnumber, series) VALUES('i7', '7700k','Kaby Lake');
INSERT INTO mytable (name, modelnumber, series) VALUES('i7', '7500','Kaby Lake');
INSERT INTO mytable (name, modelnumber, series) VALUES('i7', 'G4600','Kaby Lake');
INSERT INTO mytable (name, modelnumber, series) VALUES('i7', '7600','Kaby Lake');

-- 데이터 읽기(검색)
SELECT name, modelnumber FROM mytable m;
SELECT name AS cpu_name, modelnumber AS cpu_num FROM mytable m;
SELECT *FROM mytable m ORDER BY id DESC;
SELECT *FROM mytable m ORDER BY id ASC;

-- 조건에 맞는 데이터만 검색하기(비교)
SELECT *FROM mytable m WHERE id < 2;
SELECT *FROM mytable m WHERE id > 1;

-- 조건에 맞는 데이터만 검색하기(논리 연산자)
SELECT *FROM mytable m WHERE id > 0 OR id < 2;
SELECT *FROM mytable m WHERE id = 1 AND  name = 'i7';

-- 조건에 맞는 데이터만 검색하기(LIKE를 활용한 부분 일치)
SELECT *FROM mytable m WHERE name LIKE 'i%';
SELECT *FROM mytable m WHERE name LIKE 'i_';

-- 결과 중 일부 데이터만 가져오기(LIMIT을 활용)
SELECT *FROM mytable m LIMIT 1;
SELECT *FROM mytable m LIMIT 2, 2;

-- 조건 조합
SELECT id, name FROM mytable m
WHERE id < 4 AND name LIKE '%i%'
ORDER BY name ASC
LIMIT  2;

-- 데이터 수정
UPDATE mytable SET name = 'i5', modelnumber = '5500' WHERE id = 3;

-- 데이터 식제 
DELETE FROM mytable WHERE id = 3;

-- ALTER 
ALTER TABLE mytable ADD COLUMN lowest_price INT UNSIGNED;
UPDATE mytable SET lowest_price = 347100 WHERE id = 1;
SELECT name, modelnumber FROM mytable m  WHERE lowest_price > 30000;




