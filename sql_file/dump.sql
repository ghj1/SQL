BEGIN TRANSACTION;
CREATE TABLE usersd(id integer primary key, username text, email text, phone text, website text, regdate text);
INSERT INTO "usersd" VALUES(1,'kim','kim@naver.com','010-3456-4567','kim.com','2021-10-25 17:27:31');
INSERT INTO "usersd" VALUES(2,'Park','park@naver.com','010-3456-4567','park.com','2021-10-25 17:27:31');
INSERT INTO "usersd" VALUES(3,'Lee','lee@naver.com','010-3333-3333','lee.com','2021-10-25 17:27:31');
INSERT INTO "usersd" VALUES(4,'Cho','cho@naver.com','010-4444-4444','cho.com','2021-10-25 17:27:31');
INSERT INTO "usersd" VALUES(5,'Yue','yue@naver.com','010-5555-5555','yue.com','2021-10-25 17:27:31');
INSERT INTO "usersd" VALUES(6,'Sea','sea@naver.com','010-6666-6666','sea.com','2021-10-25 17:27:31');
COMMIT;
