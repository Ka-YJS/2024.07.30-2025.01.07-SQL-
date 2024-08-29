--CASE문 : JAVA에서 IF문과 같음
SELECT ENAME,DEPTNO, CASE WHEN DEPTNO = 10 THEN 'NEW YORK' 
						  WHEN DEPTNO = 20 THEN 'DALLAS' ELSE 'UNKOWN'
					 END AS LOC_NAME	  
FROM EMP
WHERE JOB = 'MANAGER';

--직종이 'IT_PROG'인 사람들의 평균 급여
SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
SELECT AVG(CASE JOB_ID WHEN 'IT_PROG' THEN SALARY END) FROM EMPLOYEES;--같은결과

SELECT * FROM EMP;

--EMP테이블에서 SAL이 3000이상이면 HIGH, 1000이상이면 MID, 둘다 아니면 LOW를 사원명,급여,등급(GRADE)순으로 조회
SELECT ENAME,SAL, 	CASE WHEN SAL >= 3000 THEN 'HIGH' 
						 WHEN SAL >= 1000 THEN 'MID' ELSE 'LOW'
					END AS GRADE 
FROM EMP;

--STADIUM 테이블에서 SEAT_COUNT 0DLTKD 0이상 30000이하면 'S', 30001이상 50000이하면 'M' 다 아니면 'L'
--경기장이름, 좌석수, 크기순으로 조회
SELECT STADIUM_NAME 경기장, SEAT_COUNT 좌석수,
	CASE WHEN SEAT_COUNT BETWEEN 0 AND 30000 THEN 'S'
		 ELSE CASE
			  WHEN SEAT_COUNT BETWEEN 30001 AND 50000 THEN 'M'
			  ELSE 'L'
		 END
	END AS 크기
FROM STADIUM;

--PLAYER테이블에서 몸무게 50이상 70이하면 'L', 71이상 80이하면 'M' NULLL이면 '미등록' 다 아니면 'H'
SELECT PLAYER_NAME 선수이름, WEIGHT||'KG' 몸무게,
	CASE
		WHEN WEIGHT BETWEEN 50 AND 70 THEN 'L'
		WHEN WEIGHT BETWEEN 71 AND 80 THEN 'M'
		WHEN WEIGHT IS NULL THEN '미등록'
		ELSE 'H'
	END 체급
FROM PLAYER; 

------------------------------------------------------------------------------------------
--PL/SQL문
DBMS_OUTPUT.PUT_LINE('출력할 내용');

--변수의 선언 : =이 아닌 :=을 사용, 실행 : ctrl+enter
DECLARE
NAME VARCHAR2(20) := '홍길동';
AGE	 NUMBER(3) := 30;
BEGIN
	 DBMS_OUTPUT.PUT_LINE('이름 :   '|| NAME ||CHR(10)||'나이 : '|| AGE);
END;

------------------------------------------------------------------------------------------

--IF문
--점수에 맞는 학점 출력, 변수, SCORE변수에는 80점대입, GRADE, 출력결과 -> 당신점수 : XX점, 학점 : B
--90이상 A, 80이상 B, 70이상 C, 60이상 D, 그 이하는 F
DECLARE -- 변수, 상수를 선언할 수 있음
	SCORE NUMBER := 80;-- =은 같다 라는 뜻이기 때문에 :=로 써줘야 대입이 됨
	GRADE VARCHAR2(5);--어떤 학점인지 정확히 할 수 없기 때문에 초기화를 할 수 없음
BEGIN
	IF SCORE >= 90 THEN GRADE := 'A';
	ELSIF SCORE >= 80 THEN GRADE := 'B';
	ELSIF SCORE >= 70 THEN GRADE := 'C';
	ELSIF SCORE >= 60THEN GRADE := 'D';
	ELSE GRADE := 'F';
END IF;
DBMS_OUTPUT.ENABLE;
DBMS_OUTPUT.PUT_LINE('당신의 점수: '||SCORE||'점'||CHR(10)||'학점: '||GRADE);
--CHR(10) : 아스키코드 10번을 나타냄
END;

------------------------------------------------------------------------------------------
--반복문
--FOR문
BEGIN	FOR i in 1..4 LOOP	  	
		IF MOD(i, 2) = 0 THEN 			
			DBMS_OUTPUT.PUT_LINE( i || '는 짝수!!');		
		ELSE
			DBMS_OUTPUT.PUT_LINE( i || '는 홀수!!');	
		END IF;
	END LOOP;
END;

--LOOP문
--NUM1 변수 선언, 1을 대입
--WHILE문으로 1부터 10까지의 총합을 출력

DECLARE
	NUM1 NUMBER :=1;
	TOTAL NUMBER;
BEGIN
	WHILE(NUM1 <=10 )
	LOOP
		TOTAL := TOTAL + NUM1;--자바에서는 +=와 같음
		NUM1 := NUM1 +1;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE(TOTAL);
END;

------------------------------------------------------------------------------------------

--프로시저
--F(X) = 2X +1;, 프로시저명 F, 매개변수 X, 출력결과 -> X : 0, Y : 0
CREATE OR REPLACE PROCEDURE F ( X NUMBER)
IS
	Y NUMBER;
BEGIN
	Y :=2*X+1
	DBMS_OUTPUT.PUT_LINE('X:'||X||', Y:'||Y);
END F;

CALL F(2);

------------------------------------------------------------------------------------------
--프로시저와 SQL -> DML과 프로시저를 접목
SELECT * FROM JOBS;

--JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY 
--프로시저명 : MY_NEW_JOB_PROC, 호출했을 때 4개의 값을 전달받음 -> JOBS에 INSERT
CREATE OR REPLACE PROCEDURE MY_NEW_JOB_PROC(
	P_JOB_ID IN JOBS.JOB_ID%TYPE,
	P_JOB_TITLE IN JOBS.JOB_TITLE%TYPE,
	P_MIN_SALARY IN JOBS.MIN_SALARY%TYPE,
	P_MAX_SALARY IN JOBS.MAX_SALARY%TYPE
)
IS
	CNT NUMBER :=0;
BEGIN
	--1. JOBS테이블에 매개변수로 받은 JOB_ID가 존재하는지 개수를 세는 쿼리문 작성하기
	SELECT COUNT(JOBS_ID) INTO CNT FROM JOBS
	-- : 쿼리문을 통해 나온 결과를 CNT변수에 대입하겠다는 의미
	WHERE JOB_ID = P_JOB_ID;
	--2. CNT=이면 INSERT, CNT=1이면 UPDATE하기
	IF CNT != 0 THEN
	UPDATE JOBS SET
	--사용자가 전달한 PK값이 중복이 있기 때문에 오게 되는 것
	--그렇기 때문에 이미 있는 값을 추가하는게 아니고 수정해주겠다 는 의미임
		JOB_TITLE = P_JOB_TITLE,
		MIN_SALARY = P_MIN_SALARY,
		MAX_SALARY = P_MAX_SALARY
		WHERE JOB_ID = P_JOB_ID;
		DBMS_OUTPUT.ENABLE;
		DBMS_OUTPUT.PUT_LINE('UPDATE ALL DONE ABOUT '||' '||P_JOB_ID);
	
	ELSE
	
		--INSERT문 작성
		INSERT INTO JOBS(JOB_ID,JOB_TITLE,MIN_SALARY, MAX_SALARY)
		VALUES(P_JOB_ID,P_JOB_TITLE,P_MIN_SALARY,P_MAX_SALARY);
		DBMS_OUTPUT.ENABLE;
		DBMS_OUTPUT.PUT_LINE('ALL DONE ABOUT '||' '||P_JOB_ID);
	END IF;
	
END;

CALL MY_NEW_JOB_PROC('IT', 'Developer', 7000, 15000);

SELECT * FROM JOBS;

------------------------------------------------------제거하는 프로시저 만들기
CREATE OR REPLACE PROCEDURE DEL_JOB_PROC(
	P_JOB_ID IN JOBS.JOB_ID%TYPE)
--보통 DELETE를 하면 하나의 행을 삭제하는데 중복되는 값이 있으면 안되기 때문에 
--PK 값을 매개변수로 받아서 삭제해보기
IS
	CNT NUMBER := 0;
BEGIN
	SELECT COUNT(JOB_ID) INTO CNT FROM JOBS 
	WHERE JOB_ID = P_JOB_ID; 
	--값이 있는지 없는지 검사를 해야하기 때문에 CNT에 넣어주기
	IF CNT !=0 THEN 
	--0이 아니라는 것은 삭제할 JOB_ID가 존재하고 있음 -> 삭제해주기
		DELETE FROM JOBS
		WHERE JOB_ID = P_JOB_ID;
		DBMS_OUTPUT.ENABLE;
		DBMS_OUTPUT.PUT_LINE('DELETE ALL DONE ABOUT '||' '||P_JOB_ID);
	ELSE
		DBMS_OUTPUT.PUT_LINE('삭제 할 데이터가 없습니다.');
	END IF;
END;

CALL DEL_JOB_PROC('IT');

------------------------------------------------------------------------------------------
--SEQUENCE

CREATE TABLE TBL_USER(
	IDX NUMBER PRIMARY KEY,
	NAME VARCHAR2(50)
);

--시퀀스 생성하기
CREATE SEQUENCE SEQ_USER;

INSERT INTO TBL_USER VALUES(SEQ_USER.NEXTVAL,'홍길동');
INSERT INTO TBL_USER VALUES(SEQ_USER.NEXTVAL,'김길동');
INSERT INTO TBL_USER VALUES(SEQ_USER.NEXTVAL,'이길동');
INSERT INTO TBL_USER VALUES(SEQ_USER.NEXTVAL,'박길동');

SELECT * FROM TBL_USER;
