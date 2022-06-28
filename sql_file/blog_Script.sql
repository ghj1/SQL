###############################################################
#1.DDL  
# : DDL mysqldb에 post, user 테이블 생성

CREATE DATABASE blogDB;
USE blogDB;
###############################################################

# CREATE table  
create table post (
id integer, 
title text not null, 
content text
);

#테이블 삭제
#DROP TABLE
drop table post;

#테이블 생성 post
#CREATE TABLE post 
create table post (
id integer primary key, 
title text not null, 
content text
);

#테이블 생성 : users
#CREATE TABLE users()
create table users (
id integer primary key auto_increment, 
nickname varchar(20) unique
);

#테이블 생성 : notice 
#CREATE TABLE notice
create table notice ()
id integer primary key auto_increment,
title varchar(30) not null default '제목없음',
content varchar(50) not null default '내용 없음'
);

# 테이블 이름 변경
# ALTER TABLE 원래테이블명 RENAME TO 수정테이블명

alter table post rename to board;
alter table board rename to post;

#테이블 컬럼 추가
#ALTER TABLE 테이블명 ADD COLUMN post_date TEXT; 

ALTER table post add column post_date text;

#테이블 컬럼명 수정
#ALTER TABLE 테이블명 CHANGE COLUMN 원컬럼명 수정컬럼명;

ALTER table post change column post_date reg_date text;

#테이블 컬럼 데이터 속성 추가
#post 테이블의 id 컬럼 auto_increment를 추가하려면
#ALTER TABLE document MODIFY COLUMN document_id INT auto_increment

ALTER table post 
modify column id int auto_increment;

#테이블 컬럼 삭제
#ALTER TABLE [테이블명] DROP [컬럼명];


#[문제1] post 테이블의 reg_date 컬럼 삭제하기
ALTER table drop reg_date;


#[문제2] user 테이블에 address 컬럼 추가 
# address varchar(20)
ALTER table users add column address varchar(20);

#[문제3] user 테이블에 address 컬럼의 타입을 varchar(30)으로 수정 

ALTER table users modify address varchar(30);

###############################################################
#2. DML CRUD 
###############################################################

#1) 데이터 행 추가 명령(insert)
INSERT into post (title, content) values ('파이썬, sql', '강의 정말 재미있어요.!');

INSERT into post (title, content)values ('파이썬, sql', '코딩 정말 재미있어요.!');
INSERT into post (title, content)values ('세상을 바꾸는코딩', '코딩으로 세상이 더 편리해 졌어요.');
INSERT into post (title, content)values ('코딩을 배우는 이유', '회사분위기 좋고, 월급 많이 주는 곳으로 취업하고 쉽다.');
INSERT into post (title, content)values ('파이썬을 배우는 이유', '문법이 쉽고, 코딩을 쉽게 익힐 수 있어서.');

#[문제] users 테이블에 다음의 데이터 입력하기
#nickname, address
#('sky','대구광역시'), ('blue','서울시 강서구'), ('blue','서울시 강서구'), ('beaver','미국 뉴욕시')

INSERT into users (nickname, address) values ('sky','대구광역시');
INSERT into users (nickname, address) values ('blue','서울시 강서구');
INSERT into users (nickname, address) values ('magpie','서울시 광진구');
INSERT into users (nickname, address) values ('beaver','미국 뉴욕시');

#2) 데이터 조회(select)
# SELECT * from 테이블명
select * FROM post;

# SELECT 컬럼명1, 컬럼명2 FROM 테이블명
select id, nickname from users u; 

# WHERE 조회조건
select * from post WHERE id=2;

# where LIKE 
select * from post WHERE title LIKE '%sql';
select * from post WHERE title LIKE '코딩%';
select * from post WHERE title LIKE '%코딩%';

# WHERE BETWEEN AND 
select * from post WHERE id BETWEEN 1 and 3;

# WHERE IN 
select id, title  from post WHERE id BETWEEN 1 and 3;

# ORDER  BY  [ASC/DESC] 오름차순/내림차순
select title, content from post order by title ASC;  
select title, content from post order by 1 DESC;

####
#[문제1] users 테이블에서 서울에 사는 사람들의 모든 정보 조회
SELECT * FROM users where address LIKE '%서울%'

#[문제2] users 테이블에서 nickname, address를 조회하고 nickname 기준으로 오름차순 정렬하기
SELECT nickname , address 
FROM users u 
order by 1 asc;

#3) 테이블 데이터 수정
# UPDATE 테이블명 SET 컬렴명=값, ... WHERE 조건식;
UPDATE post set title = '머신러닝', content = '내용은 어려운데 반복학습하면 잘할 수 있다.' 
WHERE id=3;

# UPDATE 확인하기
SELECT * 
FROM post p 
WHERE id=3

#4) DELETE FROM 테이플 WHERE 조건식;
DELETE FROM post WHERE id=3;



######################################
#[문제] 테이블 수정
#1. users
#1) 테이블 컬럼 다음과 같이 모두 수정
##컬럼 :email varchar(20), passwd varchar(20), gender varchar(6), age int
##email : PK, Not Null
##passwd :Not Null

#2) 테이블 데이터 입력
# apple@naver.com, apple1234, female, 20
# grape@gmail.com, grape1234, male, 41
# peach@daum.net, peach1234, male, 30
# starwars@naver.com, starwars1234, female, 25
# pear@naver.com, starwars1234, female, 45

DROP table users;

CREATE table users(
email varchar(20) primary key not null,
passwd varchar(20) not null,
gender varchar(6),
age int
);

# 컬럼의 타입속성을 잘못했다면 수정
#[해결]
ALTER table users modify email varchar(20)

INSERT into users (email, passwd, gender, age) values('apple@naver.com', 'apple1234', 'female', 20);
INSERT into users (email, passwd, gender, age) values('grape@gmail.com', 'grape1234', 'male', 41);
INSERT into users (email, passwd, gender, age) values('peach@daum.net', 'peach1234', 'male', 30);
INSERT into users (email, passwd, gender, age) values('starwars@naver.com', 'starwars1234', 'female', 25);
INSERT into users (email, passwd, gender, age) values('pear@naver.com', 'starwars1234', 'female', 45);

#확인
SELECT * FROM users u ;

#2. post 테이블
#1) author 컬럼 추가
#컬럼 : id, title, content, author varchar(20)
#id : PK, Not Null
#title : Not Null
#content : Not null
#author : Not null

#2) author테이블 데이터 입력
# '파이썬, sql', '강의 정말 재미있어요.!', 'apple@naver.com'
# '파이썬, sql', '코딩 정말 재미있어요.!', 'grape@gmail.com'
# '세상을 바꾸는코딩', '코딩으로 세상이 더 편리해 졌어요.', 'peach@daum.net'
# '코딩을 배우는 이유', '회사분위기 좋고, 월급 많이 주는 곳으로 취업하고 쉽다.', 'starwars@naver.com'
# '파이썬을 배우는 이유', '문법이 쉽고, 코딩을 쉽게 익힐 수 있어서.', 'pear@naver.com'

# peach@daum.net
# starwars@naver.com
# pear@naver.com

#[해결]
# post 테이블 데이터 전체 삭제
# 방법1 : post 테이블 데이터 삭제
DELETE FROM post; 
# 방법2 : post 테이블 데이터 삭제, 속도가 더 빠름
TRUNCATE post;

#author 컬럼 추가
ALTER table post add column author varchar(30) ;

INSERT into post (title, content, author) values ('파이썬, sql', '강의 정말 재미있어요.!', 'apple@naver.com');
INSERT into post (title, content, author)values ('파이썬, sql', '코딩 정말 재미있어요.!', 'grape@gmail.com');
INSERT into post (title, content, author)values ('세상을 바꾸는코딩', '코딩으로 세상이 더 편리해 졌어요.', 'peach@daum.net');
INSERT into post (title, content, author)values ('코딩을 배우는 이유', '회사분위기 좋고, 월급 많이 주는 곳으로 취업하고 쉽다.', 'starwars@naver.com');
INSERT into post (title, content, author)values ('파이썬을 배우는 이유', '문법이 쉽고, 코딩을 쉽게 익힐 수 있어서.', 'pear@naver.com');


#결과 확인
SELECT * FROM post p WHERE id=1;
SELECT * FROM post p ;

#[tip] id 값 재 조정하는 방법##########################
#ALTER TABLE [테이블명] AUTO_INCREMENT=1;
#SET @COUNT = 0;
#UPDATE [테이블명] SET [AUTO_INCREMENT 열 이름] = @COUNT:=@COUNT+1;
ALTER TABLE post AUTO_INCREMENT=1;
SET @COUNT = 0;
UPDATE post SET id = @COUNT:=@COUNT+1;
#######################################################

#author 컬럼 데이터 넣고, not null 속성 추가할 때, data type 명시해야함. 
ALTER table post 
modify column author varchar(30) not null;

#[tip]##########################################
# varchar 30 : 최대 캐릭터수,  최대 255자 지정 가능, 가변길이 
# text : 65535자
# char(10) : 1개 넣으면, 나머지 공백이 들어감. 정해진 길이에 주로 사용
#######################################################

###############################################################
#3. group by, join 
###############################################################

#테이블 데이터 확인 
select * FROM users u ;
select * FROM post p ;

# count() : row 카운트 
SELECT gender, COUNT(*) from users u group by gender ;

# avg(숫자컬럼) : 컬럼의 평균
SELECT gender, AVG(age1) 
from users u
WHERE age > 20
group by gender ;

# join : 두 테이블을 연결 시켜서 조회
select p.author, title, gender, age
FROM post p join users u
#FROM post p inner join users u where p.author = u.email ;
where p.author = u.email AND age >= 30

