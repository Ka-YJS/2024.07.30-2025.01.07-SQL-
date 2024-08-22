/*테이블 생성하기
 CREATE TABLE 테이블명(
 	컬럼명 타입(길이),
 	컬럼명 타입(길이),
 	컬럼명 타입(길이),
 	컬럼명 타입(길이);
 */

CREATE TABLE TBL_MEMBER(
	NAME VARCHAR2(500),
	AGE	NUMBER
);
CREATE TABLE TBL_CAR(
	ID NUMBER,			--차량식별번호
	BRAND VARCHAR2(100),--브랜드
	COLOR VARCHAR2(100),--색깔
	PRICE NUMBER,		--가격
	CONSTRAINT CAR_PK PRIMARY KEY(ID)--테이블을 생성하면서 제약조건을 지정
);

/*
주의할점)
-컬럼이 여러개일때 콤마(,)잘 써야 함
-사이에 공백 두지 않기
-같은 이름으로는 안만들어짐
-마지막에는 콤바(,)안붙임*/

DROP TABLE TBL_MEMBER;
DROP TABLE TBL_CAR;
--DROP : 영구삭제이므로 쓰기전에 반드시 주의할 것

/*테이블의 변경)
-CREATE문으로 테이블을 생성한 후 불가피하게 수정해야 할 상황이 발생할 때가 많음
-최초설계를 잘못한 원인도 있고 요구사항이 변경되기 때문이기도 함
-여러 원인으로 기존에 생성했던 컬럼의 데이터 타입을 수정하거나 
삭제, 새로운 컬럼을 넣어야 하는 경우가 발생하는데, 이때마다 테이블을 삭제하고 다시 생성하는 것은 여러 문제를 만들 수 있음
-이럴때 ALTER TABLE문을 사용해 테이블을 수정할 수 있음*/

/*문제)
 -테이블명 : ex2_10
 -속성1 : Col1 문자형 길이는 10 null값 비허용
 -속성2 : Col2 문자형 길이는 10 null값 허용
 -속성3 : Create_date 날짜타입 기본값 현재날짜(SYSDATE)
 *SYSDATE : 현재시간을 반환함
 */
CREATE TABLE ex2_10(
	Col1 VARCHAR2(10) NOT NULL,
	Col2 VARCHAR2(10) NULL,--NULL은 생략가능
	Create_date DATE DEFAULT SYSDATE
);

--컬럼명 변경 : Col1 -> Col11
--형식 : ALTER TABLE 테이블명 RENAME COLUMN 기존컬럼명 TO 새로운컬럼명
ALTER TABLE ex2_10 RENAME COLUMN Col1 TO Col11;

--컬럼타입 변경
--형식 : ALTER TABLE 테이블명 MODIFY 컬럼명 데이터타입;
ALTER TABLE ex2_10 MODIFY Col2 VARCHAR2(10);

--컬럼의 삭제
--형식 : ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
ALTER TABLE ex2_10 DROP COLUMN Create_date;

--컬럼의 추가
--형식 : ALTER TABLE 테이블명 ADD 컬럼명 데이터타입;
ALTER TABLE ex2_10 ADD Col3 NUMBER;

--제약조건 추가
--형식 : ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 제약조건 종류(컬럼명);
ALTER TABLE ex2_10 ADD CONSTRAINT PK_ex2_10 PRIMARY KEY(Col11);

--제약조건 삭제
--형식 : ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
ALTER TABLE ex2_10 DROP CONSTRAINT PK_ex2_10;

/*
문제)
-테이블생성
-테이블명 TBL_ANIMAL
-ID 숫자 기본키
-"TYPE" 문자형 길이 100
-AGE 숫자형 길이 3
-FEED 문자형 길이 100*/

CREATE TABLE TBL_ANIMAL(
	ID NUMBER PRIMARY KEY,
	"TYPE" VARCHAR2(100),
	AGE NUMBER(3),
	FEED VARCHAR2(100)
);

--제약조건 삭제
ALTER TABLE TBL_ANIMAL DROP CONSTRAINT SYS_C007000;

--제약조건 추가하기
--ID 칼럼에 ANIMAL_PK라는 이름으로 기본키 설정하기
ALTER TABLE TBL_ANIMAL ADD CONSTRAINT ANIMAL_PK PRIMARY KEY(ID);

--TBL_ANIMAL 테이블 삭제하기
DROP TABLE TBL_ANIMAL;

--DEFAULT와 CHECK제약조건
CREATE TABLE TBL_STUDENT(
	ID NUMBER,--학번
	NAME VARCHAR2(100),--이름
	MAJOR VARCHAR2(100),--전공
	GENDER CHAR(1) DEFAULT 'W' NOT NULL CONSTRAINT BAN_CHAR CHECK(GENDER = 'M' OR GENDER = 'W'),
	--CHECK(GENDER = 'M' OR GENDER = 'W') : 성별에는 M과 W만 들어올 수 있다고 나타냄, 그외는 다 오류
	BIRTH DATE CONSTRAINT BAN_DATE CHECK(BIRTH >= TO_DATE('1980-01-01','YYYY-MM-DD')),
	CONSTRAINT STD_PK PRIMARY KEY(ID)
);















