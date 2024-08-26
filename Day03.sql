--10번 및 30번 부서에 속하는 사원 중 급여가 1500을 넘는 사원의 사원번호, 이름 및 급여를 조회
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY FROM EMPLOYEES 
WHERE DEPARTMENT_ID IN(10,30) AND SALARY > 1500;

--관리자가 없는 모든 사원에 이름 및 직종을 출력
SELECT FIRST_NAME, JOB_ID FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

--직업이 IT_PROG 또는 SA_MAN이면서 급여가 1000,3000,5000이 아닌 사원들의 이름, 직종, 급여 조회
SELECT FIRST_NAME, JOB_ID, SALARY FROM EMPLOYEES 
WHERE JOB_ID IN ('IT_PROG','SA_MAN') AND SALARY NOT IN(1000,3000,5000);

----------------------------------------------------------------------------------

--TBL_STDENT라는 테이블에 학번, 이름, 전공, 성별, 생일
--INSERT INTO TBL_STUDENT (ID, NAME, MAJOR, GENDER, BIRTH)
--VALUES (0,'홍길동','컴공','A','1980-01-02');--BAN_CHAR체크 제약조건 위배 -> 성별은 M 혹은 W만

--TBL_STDENT라는 테이블에 학번, 이름, 전공, 성별, 생일
INSERT INTO TBL_STUDENT (ID, NAME, MAJOR, GENDER, BIRTH)
VALUES (0,'홍길동','컴공','M','1980-01-02');--BAN_CHAR체크 제약조건 위배

--unique constraint위반 -> 홍길동이 학번 0에 들어가있어서 박디비는 0을 사용할 수 없음
--INSERT INTO TBL_STUDENT (ID, NAME, MAJOR, GENDER, BIRTH)
--VALUES (0,'박디비','컴공','W','1990-02-06');

INSERT INTO TBL_STUDENT (ID, NAME, MAJOR, GENDER, BIRTH)
VALUES (1,'박디비','컴공','W','1990-02-06');

--TBL_STUDENT에 있는 모든 데이터 조회
SELECT * FROM TBL_STUDENT;

--DEFARULT값 사용해보기
INSERT INTO TBL_STUDENT (ID, NAME,MAJOR,BIRTH)
VALUES (2,'홍길동','컴공','1994-08-26'); 

--INSERT할 때 컬럼명을 생략하면 DEFAULT값을 넣을 수 없음
INSERT INTO TBL_STUDENT
VALUES (3,'김자바','컴공','1994-08-26'); 

--하지만 성별을 추가해서 컬럼개수를 맞추면 추가가능
INSERT INTO TBL_STUDENT
VALUES (3,'김자바','컴공','M','1994-08-26'); 

----------------------------------------------------------------------------------

SELECT * FROM FLOWER;

--FLOWER테이블에 데이터 넣기_꽃이름, 꽃색깔, 가격
INSERT INTO FLOWER VALUES ('장미꽃','빨간색',3000);
INSERT INTO FLOWER VALUES ('해바라기','노란색',2000);
INSERT INTO FLOWER VALUES ('튤립','흰색',4000);
-->pk로 지정된 데이터

SELECT * FROM POT;

--POT테이블에 데이터 추가_화분번호, 화분색, 화분모양, 꽃이름
INSERT INTO POT VALUES(202408260001,'검은색','사각형','진달래');--오류 -> 꽃데이터에 없는 꽃이름
INSERT INTO POT VALUES(202408260001,'검은색','사각형','장미꽃');
-- : 화분테이블에 데이터를 추가할 때 꽃테이블에 있는 꽃만 추가할 수 있음
-->fk로 지정된 데이터

CREATE TABLE FLOWER2(
	F_NAME2 	VARCHAR2(200) PRIMARY KEY,
	F_COLOR2	VARCHAR2(100),
	F_PRICE2	NUMBER
);

SELECT * FROM FLOWER2;

--다른테이블에 있는 데이터를 조회해서 추가
INSERT INTO FLOWER2(F_NAME2,F_COLOR2,F_PRICE2)
SELECT F_NAME,F_COLOR,F_PRICE FROM FLOWER;--FLOWER와 FLOWER2의 길이는 같아야함

--여러테이블에 한번에 데이터를 추가
INSERT ALL
	INTO FLOWER VALUES('개나리','노란색',5000)
	INTO FLOWER2 VALUES('계란꽃','흰색',7000)
SELECT * FROM DUAL;--DUAL : 가상의 테이블을 지정

SELECT * FROM FLOWER;
SELECT * FROM FLOWER2;

--DUAL : 가상의 테이블 -> 테이블을 딱히 지정하지않았는데 오늘 날짜 조회가능
SELECT SYSDATE FROM DUAL;

--POT의 행을 삭제해보기
SELECT * FROM POT;
DELETE FROM POT WHERE F_NAME = '장미꽃';

--PK와 FK로 연결된 테이블에서 외래키로 참조되고 있는 데이터는 부모테이블에서 삭제가 불가능
SELECT * FROM FLOWER;
DELETE FROM FLOWER WHERE F_NAME = '장미꽃';

--TBL_STUDENT테이블에서 이름이 홍길동인 사람 삭제하기
SELECT * FROM TBL_STUDENT;
DELETE FROM TBL_STUDENT WHERE NAME = '홍길동';
-- : 꼭 하나만 삭제되는 것이 아닌 조건에 맞다면 여러개의 행도 삭제됨

--수정(업데이트)하기
--TBL_STUDENT테이블에서 학번 1번인 학생의 이름을 홍길동으로, 성별을 남자로 수정하기
UPDATE TBL_STUDENT SET NAME = '홍길동', GENDER = 'M'
WHERE ID = 1;

--회원과 관련된 기능
--로그인 : SELECT, 회원가입 : INSERT, 회원정보수정 : UPDATE, 회원탈퇴 :  DELETE

--상품과 관련된 기능
--검색 : SELECT, 상품추가 : INSERT, 재고처리 : UPDATE, 상품삭제 :  DELETE

----------------------------------------------------------------------------------

--사원테이블에서 급여를 많이 받는 순서대로 사번,이름,급여,입사일 순으로 출력하되, 급여가 같은 경우 입사일 빠른 순으로 정렬
SELECT EMPLOYEE_ID,FIRST_NAME,SALARY,HIRE_DATE FROM EMPLOYEES
ORDER BY SALARY DESC, HIRE_DATE ASC ;
--아래와같이도 쓸 수있음 -> 결과 같음
SELECT EMPLOYEE_ID,FIRST_NAME,SALARY,HIRE_DATE FROM EMPLOYEES
ORDER BY '8' DESC, '6' ASC ;--컬럼의 순서를 알고있다면 번호로 정렬할 수 있음

--사원테이블에서 부서번호가 빠른순, 부서번호가 같다면 직종이 빠른순, 직종도 같다면 급여를 많이 받는 순서로 정렬
--사번, 이름, 부서번호, 직종, 급여 순으로 출력
SELECT EMPLOYEE_ID,FIRST_NAME,DEPARTMENT_ID,JOB_ID,SALARY FROM EMPLOYEES
ORDER BY DEPARTMENT_ID,JOB_ID,SALARY DESC;

--급여가 15000이상인 사원들의 사번, 이름, 급여, 입사일을 입사일이 빠른 순으로 조회
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, HIRE_DATE FROM EMPLOYEES 
WHERE SALARY >=15000 ORDER BY HIRE_DATE ASC;

----------------------------------------------------------------------------------

--<<내장함수_문자함수>>
SELECT ASCII('A')FROM DUAL;
SELECT CHR(65)FROM DUAL;
--부서명을 왼쪽으로 밀고, 총 10칸을 할당한 뒤에 나머지 공백을 *로 채움
SELECT RPAD(DEPARTMENT_NAME,10,'*')FROM DEPARTMENTS;
--부서명을 오른쪽으로 밀고, 총 10칸을 할당한 뒤에 나머지 공백을 *로 채움
SELECT LPAD(DEPARTMENT_NAME,10,'*')FROM DEPARTMENTS;
--TRTIM : 문자열의 공백삭제
SELECT TRIM('   TRIM   ')FROM DUAL; 
SELECT RTRIM('   TRIM   ')FROM DUAL; 
SELECT LTRIM('   TRIM   ')FROM DUAL; 
--INSTR : 특정문자의 위치를 반환
SELECT INSTR('HELLO','O')FROM DUAL;--JAVA와 달리 인덱스 1번부터 시작
--INSTR(데이터,찾을문자,검색위치,몇번째에나오는지)
SELECT INSTR('HELLO','L',1,2)FROM DUAL;--HELLO에서 L을 찾을건데, 1번부터 찾기시작하고, 2번째 L의 위치는?
SELECT INSTR('HELLO','Z')FROM DUAL;--찾는 값이 없으면 0을 반환함
--INITCAP : 첫 문자를 대문자로 변환하는 함수
SELECT INITCAP('good morning') FROM DUAL;
SELECT INITCAP('good/morning') FROM DUAL;
--LENGTH : 주어진 문자열 반환
SELECT LENGTH ('JOHN')FROM DUAL;
--CONCAT : 주어진 문자열 연결
SELECT CONCAT('HELLOW','WORLD')FROM DUAL;
--SUBSTR : 문자열 시작위치부터 길이만큼 자른 후 반환
SELECT SUBSTR('HELLO ORACLE',2), SUBSTR('HELLO ORACLE',7,5)FROM DUAL;
--REPLACE(데이터,원래글자,바꿀글자)
SELECT REPLACE('GOOD MORNING','MORNING','EVENING')FROM DUAL;
--UPPER : 주어진 문자 전부 대문자
SELECT UPPER('good morning') FROM DUAL;
--LOWER : 주어진 문자 전부 소문자
SELECT LOWER('GOOD MORNING')FROM DUAL;

----------------------------------------------------------------------------------

--<<문제풀기1>>

--부서번호가 50번인 사원들의 이름을 출력하되, 이름이 모두 'el'을 모두 **로 대체하여 출력
SELECT REPLACE(FIRST_NAME,'el','**') FROM EMPLOYEES WHERE DEPARTMENT_ID = 50;
--이름이 6글자이상인 사원의 사번과 이름, 급여를 출력
SELECT EMPLOYEE_ID,FIRST_NAME,SALARY FROM EMPLOYEES WHERE LENGTH(FIRST_NAME)>=6;
--' H E L L O '의 공백을 모두 제거하여 출력
SELECT REPLACE(' H E L L O ',' ','')FROM DUAL;

--<<문제풀기2>>
/*문제)아래 칼럼을 가지는 PRODUCT2테이블을 생성하는 DDL을 작성하시오
-제약조건의 이름은 자동으로 부여되도록 별도록 지정하지 마시오
(단, 제약조건의 이름을 지정하더라도 감점하지않음)
-칼럼정보
1>NO : 제품번호, 숫자, 기본키
2>NAME : 제품명, 문자열 최대 100바이트, 필수
3>PRICE : 제품가격, 숫자
4>P_DATE : 생산일자, 날짜*/

CREATE TABLE PRODUCT2(
	"NO"	NUMBER PRIMARY KEY,
	NAME	VARCHAR2(100) NOT NULL,
	PRICE	NUMBER,
	P_DATE	DATE
);

--<<문제풀기3>>TABLE PRODUCT2활용
--모든 칼럼에 타입에 맞는 데이터삽입, 널 값이 없도록 작성
--P_DATE칼럼의 데이터 중 하나 이상은 반드시 현재날짜를 호출하는 오라클함수사용

SELECT * FROM PRODUCT2;
DROP TABLE PRODUCT2;

INSERT INTO PRODUCT2 VALUES(1000,'컴퓨터',100,SYSDATE);
INSERT INTO PRODUCT2 VALUES(1002,'냉장고',200,SYSDATE);
INSERT INTO PRODUCT2 VALUES(1003,'에어컨',300,SYSDATE);
INSERT INTO PRODUCT2 VALUES(1004,'오디오',20,SYSDATE);
INSERT INTO PRODUCT2 VALUES(1005,'세탁기',60,SYSDATE);

--<<문제풀기3>>TABLE PRODUCT2활용
--NO가 1000인 데이터의 PRICE를 20증가시키시오
--NAME이 '세탁기'인 데이터를 모두 삭제하시오

UPDATE PRODUCT2 SET PRICE = PRICE+20 WHERE "NO" = 1000;
DELETE FROM PRODUCT2 WHERE NAME = '세탁기';
SELECT * FROM PRODUCT2 ORDER BY PRICE DESC;

