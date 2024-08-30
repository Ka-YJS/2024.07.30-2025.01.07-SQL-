--시퀀스명.CURRVAL : 현재 시퀀스 객체에 들어있는 값을 반환함
SELECT SEQ_USER.NEXTVAL FROM DUAL;
SELECT SEQ_USER.CURRVAL FROM DUAL;

--시퀀스 값 초기화 하는 방법 : 가장 좋은 방법은 지웠다가 다시 만들기
--(대부분은 권한이 없기때문에 삭제할 수가 없음)

--1. 현재 시퀀스의 값을 확인
--2. 현재 시퀀스 값만큼 INCREMENT를 뺌
ALTER SEQUENCE SEQ_USER INCREMENT BY -21;--현재 시퀀스의 증가량을 -로 바꾸기

--3. NEXTVAL을 한번 함 : 증가량만큼 변화
SELECT SEQ_USER.NEXTVAL FROM DUAL;

--4. 증가량을 다시 1로 바꿔놓기
ALTER SEQUENCE SEQ_USER INCREMENT BY 1;

SELECT SEQ_USER.NEXTVAL FROM DUAL;

--시퀀스 삭제하기 : DROP SEQUENCE 시퀀스명;
DROP SEQUENCE SEQ_USER;

----------------------------------------------------

--java와 연결하기

CREATE TABLE DEPT2(
	DEPTNO NUMBER(3) PRIMARY KEY,
	DNAME VARCHAR2(10),
	LOC VARCHAR2(5)
);

INSERT INTO DEPT2 VALUES(10,'총무부','101');
INSERT INTO DEPT2 VALUES(20,'영업부','202');
INSERT INTO DEPT2 VALUES(30,'전산부','303');
INSERT INTO DEPT2 VALUES(40,'관리부','404');
INSERT INTO DEPT2 VALUES(50,'경리부','505');

SELECT * FROM DEPT2;

