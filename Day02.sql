/*문제1)아래 3개의 테이블 만들기

USER
      
U_ID(PK)	VARCHAR2(100)
U_PW		VARCHAR2(100)      
U_NAME		VARCHAR2(200)   
U_ADDRESS	VARCHAR2(300) 
U_EMAIL     VARCHAR2(300)
U_BIRTH		DATE

--------------

ORDER    
  
O_NUM     	NUMBER 
O_DATE      DATE
U_ID(FK)    VARCHAR2(100)
->이 안에는 USER에 들어가있는 회원만 들어올 수 있음
->U_ID(PK)와 같은 자료형과 길이를 가져야 함
P_NUM(FK)	NUMBER
->P_NUM(PK)와 같은 자료형과 길이를 가져야 함

--------------

PRODUCT   

P_NUM(PK)   NUMBER
P_NAME		VARCHAR2(100)      
P_PRICE   	NUMBER
P_COUNT		NUMBER*/

CREATE TABLE "USER"( --1번
	U_ID			VARCHAR2(100) PRIMARY KEY,
	U_PW			VARCHAR2(100),      
	U_NAME			VARCHAR2(200),   
	U_ADDRESS		VARCHAR2(300), 
	U_EMAIL      	VARCHAR2(300),
	U_BIRTH			DATE
);
	/*코드를 수정한다고 다시 적용이 안됨
	 -테이블을 날리고 다시 만들기(안에 있는 데이터 날아감)
	 -테이블 생성 후 제약조건 추가*/

CREATE TABLE "ORDER"(--3번
	O_NUM     		NUMBER PRIMARY KEY,
	O_DATE      	DATE,
	U_ID      		VARCHAR2(100),
	P_NUM			NUMBER,
	CONSTRAINT USER_FK FOREIGN KEY(U_ID) REFERENCES "USER"(U_ID),
	CONSTRAINT PRODUCT_FK FOREIGN KEY(P_NUM) REFERENCES "PRODUCT"(P_NUM)
);
CREATE TABLE "PRODUCT"(--2번
	P_NUM   		NUMBER PRIMARY KEY,
	P_NAME			VARCHAR2(100),      
	P_PRICE   		NUMBER,
	P_COUNT			NUMBER
);


--------------------------------------------------
	/*	
	 문제2)테이블 만들기
	 -꽃 테이블과 화분 테이블 2개가 필요하고, 꽃을 구매할 때 화분도 같이 구매함
	 -꽃테이블 : 이름, 색깔, 가격이 있음
	 -화분테이블 : 제품 번호, 화분색깔, 화분모양, 꽃이름이 있음*/
	
	/*논리적 모델링)
	 
		꽃		화분
	--------------------
		이름(PK)	제품번호(PK)
		색깔		화분색깔
		가격		화분모양
				꽃이름(FK)	*/
	/*물리적 모델링)
	 
		FLOWER		
	----------------
		F_NAME(PK)	VARCHAR2(200)
		F_COLOR		VARCHAR2(100)
		F_PRICE		NUMBER
					
	-----------------
		POT
		P_NUM(PK)	NUMBER
		P_COLOR		VARCHAR2(100)
		P_SHAPE		VARCHAR2(200)
		F_NAME(FK)	VARCHAR2(200)			
				*/


CREATE TABLE FLOWER(
	F_NAME 	VARCHAR2(200) PRIMARY KEY,
	F_COLOR	VARCHAR2(100),
	F_PRICE	NUMBER
);

CREATE TABLE POT(
	P_NUM	NUMBER PRIMARY KEY,
	P_COLOR VARCHAR2(100),
	P_SHAPE	VARCHAR2(200),
	F_NAME 	VARCHAR2(200),
	CONSTRAINT FLOWER_FK FOREIGN KEY(F_NAME) REFERENCES FLOWER(F_NAME)
);

	
----------------------------------------------------------------------------
	/*
	문제3)CD 정보를 데이터베이스에 저장하려고 한다.
		-CD는 타이틀, 가격, 장르, 트랙 리스트 등의 정보를 가지고 있음
		-각 CD는 아티스트가 있으며 아티스트는 여러 CD를 출시함
		-트랙은 타이틀, 러닝타임(초)이 있음
		-관계(Relationship) -> FK
		CD와 아티스트는 N:1(한명의 아티스트는 여러 CD를 낼 수 있음)
		CD와 트랙은 1:N(하나의 CD에는 여러 트랙이 포함될 수 있음)
		
		1. 테이블을 작성하기(논리+물리)
		2. DDL문을 작성하기
		
		*개체와 관계
		개체(Entity)
		CD : 타이틀, 가격, 장르, 트랙 리스트
		아티스트 : 이름, 국적, 데뷔년도
		트랙 : 타이틀, 러닝타임*/

	/*	--테이블 작성(논리+물리)
		CD 테이블
		- C_TITLE(PK)	타이틀
		- PRICE		가격
		- GENRE		장르	
		- TRACKLIST	트랙리스트
		- ARTIST_NAME(FK)
		====================
		ARTIST테이블
		- A_NAME(PK)	이름
		- COUNTRY	국적
		- DEBUT_YEAR	데뷔년도
		=====================
		TRACK 테이블
		- TITLE(PK)
		- RUNNINGTIME
		- CD_TITLE(FK)*/

CREATE TABLE CD(
	C_TITLE		VARCHAR2(300) PRIMARY KEY,
	PRICE		NUMBER,
	GENRE		VARCHAR2(300),
	TRACKLIST	VARCHAR2(300),
	A_NAME		VARCHAR2(300),
	CONSTRAINT CD_FK FOREIGN KEY (A_NAME) REFERENCES ARTIST(A_NAME)
);
CREATE TABLE ARTIST(
	A_NAME		VARCHAR2(300) PRIMARY KEY,
	COUNTRY		VARCHAR2(300),
	DEBUT_YEAR	DATE
);
CREATE TABLE TRACK(
	T_TITLE		VARCHAR2(300) PRIMARY KEY,
	RUNNINGTIME	NUMBER,
	C_TITLE		VARCHAR2(300),
	CONSTRAINT TRACK_FK FOREIGN KEY (C_TITLE) REFERENCES CD(C_TITLE)
);

------------------------------------------------------------------------------
	/*
	문제4)회사의 정보를 DB에 저장하려고 한다.
	-회사는 네 개의 부서를 운영한다. 부서는 (부서번호, 부서이름)을 저장함
	-부서는 1명 이상의 직원(직원번호, 직원이름, 직책)을 두고 있음. 각 직원은 하나의 부서에 소속됨
	-직원은 부양가족(이름, 나이)이 있을 수 있음 -> 누구의 가족인지 알아야 함
	-각 직원은 근무했던 부서에 대한 근무기록(기간, 직책)이 있음 -> 누가 일했는지 알아야 함*/
--CONSTRAINT [FK명] FOREIGN KEY [FK가 될 컬럼명] REFERENCES [FK로 연결한 PK가 위치한 부모테이블] [PK컬럼명]
	/*
		부서(DEPARTMENT)
		-부서번호(D_NUM)(PK)
		-부서이름(D_NAME)
		----------
		직원(EMPLOYEE)
		-직원번호(E_NUM)(PK)
		-직원이름(E_NAME)
		-직책(E_POSITION)
		-부서번호(D_NUM)(FK)
		------------
		부양가족(DEPENDENTS)
		-이름(DE_NAME)
		-나이(DE_AGE)
		-직원번호(E_NUM)(FK)
		-------------
		근무기록(WORK_RECORD)
		-기간(W_YEAR)
		-직원번호(E_NUM)(FK)
		
		*/


CREATE TABLE DEPARTMENT(
	D_NUM		NUMBER PRIMARY KEY,
	D_NAME		VARCHAR2(200)
);
CREATE TABLE EMPLOYEE(
	E_NUM		NUMBER PRIMARY KEY,
	E_NAME		VARCHAR2(200),
	E_POSITION	VARCHAR2(200),
	D_NUM		NUMBER,
);
CREATE TABLE DEPENDENTS(
	DE_NAME		VARCHAR2(200),
	DE_AGE		NUMBER,
	E_NUM		NUMBER,
);
CREATE TABLE WORK_RECORD(
	W_YEAR		DATE,
	E_NUM		NUMBER,
);
	
	
-------------------------------------------------------------------------

--EMPLOYEES에 있는 전체 사원번호와 이름 조회가능
SELECT EMPLOYEE_ID, FIRST_NAME FROM EMPLOYEES;

--컬럼조회
SELECT * FROM COLS WHERE TABLE_NAME = 'EMPLOYEES';

--사원테이블에서 모든 정보를 조회하세요
SELECT * FROM EMPLOYEES;

--DEPARTMENTS(부서)테이블의 모든 정보를 조회하시오
SELECT * FROM DEPARTMENTS;

--사원테이블에서 FIRST_NAME(이름), JOB_ID(직종), SALARY(급여)를 조회하시오.
SELECT FIRST_NAME, JOB_ID, SALARY from EMPLOYEES;

--사원테이블에서 사번, 이름, 직종, 급여, 보너스, 실제의 보너스 금액을 출력
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY, COMMISSION_PCT, 
SALARY * COMMISSION_PCT FROM EMPLOYEES;

--사원테이블에서 급여가 10000이상인 사원들의 정보를 사번, 이름, 급여 순으로 출력
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY FROM EMPLOYEES WHERE SALARY >=10000;

--사원테이블에서 이름이 Michael인 사원의 사번, 이름을 조회
--문자열 데이터는 ' '에 넣어서 표현
SELECT EMPLOYEE_ID, FIRST_NAME FROM EMPLOYEES WHERE FIRST_NAME = 'Michael';

--사원테이블에서 직종이 IT_PROG인 사원들의 정보를 사번, 이름, 직종, 급여 순으로 조회
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';

--사원테이블에서 급여가 10000이상이면서 13000이하인 사원의 정보를 이름, 급여 순으로 조회
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY FROM EMPLOYEES WHERE SALARY>=10000 AND SALARY<=13000;

--사원테이블에서 입사일이 05년9월21일인 사원의 정보를 사번, 이름, 입사일 순으로 출력
SELECT HIRE_DATE FROM EMPLOYEES; --입사일자가 어떻게 표기되어있는지 먼저 확인
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE FROM EMPLOYEES WHERE HIRE_DATE >= '2005-09-21';

--사원테이블에서 2006년도에 입사한 사원들의 정보를 사번, 이름, 직종, 입사일 순으로 출력
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, HIRE_DATE FROM EMPLOYEES
WHERE HIRE_DATE >= '2006-01-01' AND HIRE_DATE <= '2006-12-31';

--사원테이블에서 직종이 'SA_MAN' 이거나 'IT_PROG'인 사원들의 모든 정보를 출력
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'SA_MAN' OR JOB_ID = 'IT_PROG';

--사원테이블에서 급여가 2200, 3200, 5000, 6000를 받는 사원들의 정보를 사번, 이름 직종, 급여 순으로 출력
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY FROM EMPLOYEES
WHERE SALARY = 2200 OR SALARY = 3200 OR SALARY = 5000 OR SALARY = 6000;

------------------------------------------------------------------------------------

--BETWEEN연산자
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, HIRE_DATE FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '2006-01-01' AND '2006-12-31';

--IN(값,값,값)
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY FROM EMPLOYEES 
WHERE SALARY IN (2200, 3200, 5000, 6000);

--NOT IN : 직종이 'SA_MAN', 'IT_PROG'가 "아닌" 모든 사원들의 정보를 출력
SELECT * FROM EMPLOYEES WHERE JOB_ID NOT IN('SA_MAN', 'IT_PROG');

---------------------------------------------------------------------------------------

--사원테이블에서 사원들의 이름 중 M으로 시작하는 사원들의 정보를 사번, 이름, 직종 순으로 출력
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'M%';

--사원테이블에서 이름이 d로 끝나는 사원의 사번, 이름, 직종을 출력
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%d';

--사원테이블에서 이름에 a가 포함되어 있는 사원의 정보를 이름, 직종 순으로 출력
SELECT FIRST_NAME, JOB_ID FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%a%';

--이름의 첫글자가 M이면서 총 7글자의 이름을 가진 사원 정보를 사번, 이름 순으로 입력
SELECT EMPLOYEE_ID, FIRST_NAME FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'M______';

--사원테이블에서 이름의 세번째글자에 a가 들어가는 사원들의 정보를 사번, 이름순으로 출력
SELECT EMPLOYEE_ID, FIRST_NAME FROM EMPLOYEES
WHERE FIRST_NAME LIKE '__a%';

--이름에 소문자o가 들어가면서 a로 끝나는 사원들의 정보를 이름, 급여 순으로 조회
SELECT EMPLOYEE_ID, SALARY FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%o%a';

--이름이 H로 시작하면서 6글자이상인 사원들의 정보를 사번, 이름순으로 조회
SELECT EMPLOYEE_ID, FIRST_NAME FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'H_____%';

--사원테이블에서 이름에 s가 들어있지 않은 사원들만 사번, 이름으로 검색
SELECT EMPLOYEE_ID, FIRST_NAME FROM EMPLOYEES
WHERE FIRST_NAME NOT LIKE '%s%';

--en, el 포함된 이름가진 사원들의 사번, 이름 검색
SELECT EMPLOYEE_ID, FIRST_NAME  FROM EMPLOYEES 
WHERE FIRST_NAME LIKE '%el%' OR FIRST_NAME LIKE '%en%';

--
SELECT  FROM EMPLOYEES
WHERE  LIKE ;


















