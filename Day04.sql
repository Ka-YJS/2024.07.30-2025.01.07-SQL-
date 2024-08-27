--ABS() : 절대값 반환
SELECT -10, ABS(-10) FROM DUAL;

--ROUND(소수,출력하고싶은 자리수) : 반올림
SELECT ROUND(1234.567,1), ROUND(1234.567,-1), ROUND(1234.567) FROM DUAL;

--FLOOR() : 주어진 숫자보다 작거나 같은 정수 중 최대값을 반환함
SELECT FLOOR(2),FLOOR(2.1) FROM DUAL; 

--TRUNC() : 버림
SELECT TRUNC(1234.567,1),TRUNC(1234.567,-1), TRUNC(1234.567) FROM DUAL; 

--CEIL() : 올림
SELECT CEIL(2), CEIL(2.1) FROM DUAL;

--MOD() : 나누기 후 나머지를 반환
SELECT MOD(1,3),MOD(2,3),MOD(3,3),MOD(4,3),MOD(0,3) FROM DUAL;

--POWER() : 주어진 수만큼 제곱
SELECT POWER(2,1),POWER(2,2),POWER(2,3),POWER(2,0) FROM DUAL;

------------------------------------------------------------------------------------

--사원테이블에서 사원번호가 짝수인사람은 0, 홀수인 사람은 1을 사원번호, 연산결과 순으로 조회
SELECT EMPLOYEE_ID,MOD(EMPLOYEE_ID,2) FROM EMPLOYEES;

--사원번호가 짝수인 사람들의 사원번호와 이름을 조회하시오
SELECT EMPLOYEE_ID, FIRST_NAME FROM EMPLOYEES
WHERE MOD(EMPLOYEE_ID,2)=0 ORDER BY EMPLOYEE_ID;

--사원테이블에서 이름, 급여, 급여의 1000당 ■로 채워 조회하세요
--ex)급여 8,000 -> ■■■■■■■■(8개의 ■)
SELECT FIRST_NAME,SALARY, RPAD('■',ROUND(SALARY/1000),'■') FROM EMPLOYEES;

------------------------------------------------------------------------------------

--ADD_MONTHS() : 특정날짜에 개월수를 더한 날을 반환함
SELECT SYSDATE,ADD_MONTHS(SYSDATE,2) FROM DUAL;

--MONTHS_BETWEEN() : 두 날짜 사이의 개월수를 반환
SELECT SYSDATE, HIRE_DATE, MONTHS_BETWEEN(SYSDATE,HIRE_DATE)  FROM EMPLOYEES;
-->HIRE_DATE에서 뒤에 00:00:00.000은 JAVA에서 split으로 미리 잘라도 됨

--NEXT_DAY() : 주어진 날짜 다음에 나타나는 지정요일(1:일요일 ~ 7:토요일) 반환함
SELECT SYSDATE, NEXT_DAY(SYSDATE,1) FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'일요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,SUNDAY) FROM DUAL;--오류남
SELECT SYSDATE, NEXT_DAY(SYSDATE-7,'일') FROM DUAL;-- : 저번주 일요일찾기

--사원테이블에서 모든 사원의 입사일로부터 6개월 뒤의 날짜를 이름, 입사일, 6개월 뒤의 날짜순으로 출력
SELECT FIRST_NAME,HIRE_DATE,ADD_MONTHS(HIRE_DATE,6) FROM EMPLOYEES;

--사원테이블에서 120번인 사원이 입사후 3년 6개월 뒤 진급예정임 -> 이름, 진급날짜 조회
SELECT FIRST_NAME,ADD_MONTHS(HIRE_DATE,42) FROM EMPLOYEES WHERE EMPLOYEE_ID=120;

--모든 사원들이 입사일로부터 오늘까지 몇개월 경과했는지 출력
SELECT FIRST_NAME, MONTHS_BETWEEN(SYSDATE,HIRE_DATE) FROM EMPLOYEES;

--사원들의 이름,입사일,입사후 오늘까지의 개월수를 조회,
--입사기간이 200개월 이상인 사람만 출력, 개월수는 소수점 이하 한자리까지 출력
SELECT FIRST_NAME,HIRE_DATE,TRUNC(MONTHS_BETWEEN(SYSDATE,HIRE_DATE),1) FROM EMPLOYEES
WHERE TRUNC(MONTHS_BETWEEN(SYSDATE,HIRE_DATE),1)>=200;

------------------------------------------------------------------------------------

--TO_CHAR() : 날짜를 형식에 맞춰 문자열로 변환
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD'), 
		TO_CHAR(SYSDATE,'YYYY-MM-DD DAY'), 
		TO_CHAR(SYSDATE,'YYYY-MM-DD HH:MI:SS')
FROM DUAL;
SELECT TO_CHAR(1234567,'9,999,999')FROM DUAL; 
SELECT TO_CHAR(1234567,'L9,999,999')FROM DUAL; 
SELECT TO_CHAR(12,'0999')FROM DUAL; 

--TO_DATE() : 문자열 -> 날짜형
SELECT TO_DATE('2024.08.27')FROM DUAL; 
SELECT TO_DATE('08.27.2024','MM,DD,YYYY')FROM DUAL; 
SELECT TO_DATE('2024.08','YYYY.MM') FROM DUAL;--일을 입력하지 않으면 1일로 자동으로 나옴
SELECT TO_DATE('11','DD') FROM DUAL;--날짜만 표시하면 현재연도와 현재월에 대해서 자동으로 표시됨 

------------------------------------------------------------------------------------

--NVL()
SELECT EMPLOYEE_ID,FIRST_NAME,SALARY,COMMISSION_PCT FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL;--1.NULL값을 조회함
SELECT EMPLOYEE_ID,FIRST_NAME,SALARY,NVL(COMMISSION_PCT,0) FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL;--2.NULL값에 0을 넣어줌

--NVL2() : 
SELECT EMPLOYEE_ID,FIRST_NAME,SALARY,NVL2(COMMISSION_PCT,'보너스받음','보너스안받음')FROM EMPLOYEES;
--NULL값이 아님 = 보너스 받음, NULL값임 = 보너스 안받음

------------------------------------------------------------------------------------

--RANK()OVER() : 그룹내 순위를 계산 -> NUMBER타입으로 순위를 반환
SELECT RANK() OVER(ORDER BY SALARY DESC), FIRST_NAME,SALARY FROM EMPLOYEES;

--DENSE_RANK()
SELECT DENSE_RANK() OVER(ORDER BY SALARY DESC), FIRST_NAME,SALARY FROM EMPLOYEES;

------------------------------------------------------------------------------------

--COUNT() : 행의 개수를 세서 반환
SELECT COUNT(*) FROM EMPLOYEES;

--MIN() : 최소값 구하기
SELECT MIN(SALARY) FROM EMPLOYEES;

--MAX() : 최대값 구하기
SELECT MAX(SALARY) FROM EMPLOYEES;

--AVG() : 평균 구하기
SELECT AVG(SALARY) FROM EMPLOYEES;

--SUM() : 총합 구하기
SELECT SUM(SALARY) FROM EMPLOYEES;

--사원테이블에서 보너스를 받는 사원의 수를 조회
SELECT COUNT(COMMISSION_PCT) FROM EMPLOYEES;

--사원테이블에서 직종이 'SA_REP'인 사원들의 평균/최고/최저급여, 급여의 총합 조회
SELECT AVG(SALARY),MAX(SALARY),MIN(SALARY),SUM(SALARY) FROM EMPLOYEES
WHERE JOB_ID = 'SA_REP';

--사원테이블에서 부서의 개수 출력
SELECT COUNT(DISTINCT DEPARTMENT_ID) FROM EMPLOYEES;--DISTINCT : 중복제거

--사원테이블에서 부서번호가 80번인 사원들의 평균급여를 소수점 둘째자리에서 반올림
SELECT ROUND(AVG(SALARY),1) FROM EMPLOYEES WHERE DEPARTMENT_ID=80;

------------------------------------------------------------------------------------

--각 부서별 급여의 평균과 총 합을 출력
SELECT DEPARTMENT_ID, COUNT(*),AVG(SALARY),SUM(SALARY) FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;--GROUP BY와 함께쓰면 집계함수를 그룹함수와 함께 쓸 수 있음

--부서별, 직종별로 그룹을 나눠서 인원수를 출력 단, 부서번호가 낮은순으로 정렬
SELECT DEPARTMENT_ID,JOB_ID, COUNT(*) FROM EMPLOYEES
GROUP BY DEPARTMENT_ID,JOB_ID
ORDER BY DEPARTMENT_ID;

--각 직종별 인원수를 출력
SELECT JOB_ID,COUNT(*) FROM EMPLOYEES GROUP BY JOB_ID;

--각 직종별 급여의 합을 출력
SELECT JOB_ID, SUM(SALARY) FROM EMPLOYEES GROUP BY JOB_ID;

--부서별로 가장 높은 급여를 조회
SELECT DEPARTMENT_ID, MAX(SALARY) FROM EMPLOYEES GROUP BY DEPARTMENT_ID;

--부서별 급여의 합계를 내림차순으로 조회
SELECT DEPARTMENT_ID, SUM(SALARY) FROM EMPLOYEES GROUP BY DEPARTMENT_ID
ORDER BY SUM(SALARY) DESC;

------------------------------------------------------------------------------------

CREATE TABLE 월별매출 (
    상품ID VARCHAR2(5),
    월 VARCHAR2(10),
    회사 VARCHAR2(10),
    매출액 INTEGER );
    
INSERT INTO  월별매출 VALUES ('P001', '2019.10', '삼성', 15000);
INSERT INTO  월별매출 VALUES ('P001', '2019.11', '삼성', 25000);
INSERT INTO  월별매출 VALUES ('P002', '2019.10', 'LG', 10000);
INSERT INTO  월별매출 VALUES ('P002', '2019.11', 'LG', 20000);
INSERT INTO  월별매출 VALUES ('P003', '2019.10', '애플', 15000);
INSERT INTO  월별매출 VALUES ('P003', '2019.11', '애플', 10000);

SELECT * FROM 월별매출;

--ROLLUP() : 소그룹간의 합계를 계산하는 함수
SELECT 상품ID,월,SUM(매출액) FROM 월별매출
GROUP BY ROLLUP(상품ID,월);
SELECT 상품ID,월,회사,SUM(매출액) FROM 월별매출
GROUP BY ROLLUP(상품ID,월,회사);

--CUBE() : 항목들 간의 다차원적인 소계
--GROUP BY 절에 명시한 모든 컬럼에 대해 소그룹 합계를 계산해줌
SELECT 상품ID, 월, SUM(매출액) AS 매출액 FROM 월별매출
GROUP BY CUBE(상품ID, 월);

--GROUPING SETS() : 특정 항목에 대한 소계를 내는 함수
SELECT 상품ID, 월, SUM(매출액) AS 매출액 FROM 월별매출
GROUP BY GROUPING SETS(상품ID,월);--상품별합계, 날짜별 합계

------------------------------------------------------------------------------------

--HAVING() : 
--각 부서의 급여의 최대값, 최소값, 인원수를 출력 -> 단, 급여의 최대값이 8000이상인 결과만 보여줄 것
SELECT DEPARTMENT_ID, MAX(SALARY),MIN(SALARY),COUNT(*) FROM EMPLOYEES
GROUP BY DEPARTMENT_ID HAVING MAX(SALARY)>=8000;

--각 부서별 인원수가 20명 이상인 부서의 정보를 부서번호, 급여의 합, 급여의 평균, 인원수 순으로 출력
-- ->단, 급여의 평균은 소수점 2자리 반올림
SELECT DEPARTMENT_ID,SUM(SALARY),ROUND(AVG(SALARY),1), COUNT(*)
FROM EMPLOYEES GROUP BY DEPARTMENT_ID HAVING COUNT(*)>=20;

--부서별, 직종별로 그룹화 하여 결과를 부서번호, 직종, 인원수 순으로 출력, 단, 직종이 'MAN'으로 끝나는 경우만 출력
SELECT DEPARTMENT_ID,JOB_ID,COUNT(*) FROM EMPLOYEES
WHERE JOB_ID LIKE '%MAN'--WHERE은 GROUP BY보다 먼저 쓰기
GROUP BY DEPARTMENT_ID,JOB_ID;

--각 부서별 평균 급여를 소수점 한자리까지 버림으로 출력 -> 평균 급여가 10000미만인 그룹만 조회,
-- 부서번호가 50이하인 부서만 조회 
SELECT DEPARTMENT_ID, TRUNC(AVG(SALARY),1) FROM EMPLOYEES
WHERE DEPARTMENT_ID<=50 GROUP BY DEPARTMENT_ID HAVING TRUNC(AVG(SALARY),1)<10000; ;

--각 부서별 부서번호, 급여의 합, 평균, 인원수 순으로 출력
-- ->단, 급여의 합이 30000이상인 경우만 출력해야 하며, 급여의 평균은 소수점 2자리에서 반올림
SELECT DEPARTMENT_ID,SUM(SALARY),ROUND(AVG(SALARY),1),COUNT(*) FROM EMPLOYEES
GROUP BY DEPARTMENT_IDHAVING SUM(SALARY)>=30000;

------------------------------------------------------------------------------------

CREATE TABLE TEST001(
	ID	VARCHAR2(20) PRIMARY KEY,
	PW 	VARCHAR2(10),
	AGE NUMBER);

------------------------------------------------------------------------------------

--INDEX

SELECT * FROM TEST001;
SELECT * FROM ALL_INDEXES WHERE TABLE_NAME =  'TBL_STUDENT';
SELECT * FROM ALL_INDEXES WHERE TABLE_NAME =  'EMPLOYEES';

------------------------------------------------------------------------------------

--SUBQUERY

/*사원테이블에서 이름이 'Michael'이고, 직종이 'MK_MAN'인 사원의 급여보다
  많이 받는 사원들의 정보를 사번, 이름, 직종, 급여 순으로 출력*/
SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Michael' AND JOB_ID = 'MK_MAN';--13000
SELECT EMPLOYEE_ID,FIRST_NAME,JOB_ID,SALARY FROM EMPLOYEES WHERE SALARY>13000;

SELECT EMPLOYEE_ID,FIRST_NAME,JOB_ID,SALARY FROM EMPLOYEES
WHERE SALARY>(SELECT  SALARY
				FROM EMPLOYEES 
				WHERE FIRST_NAME = 'Michael' AND JOB_ID = 'MK_MAN');
--두개의 쿼리를 쓴 값과 합쳐 쓴 것의 결과가 같음

--사번이 150번인 사원의 급여와 같은 급여를 받는 사원들의 정보를 사번, 이름, 급여 순으로 출력
SELECT EMPLOYEE_ID,FIRST_NAME,SALARY FROM EMPLOYEES
WHERE SALARY = (SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID =150);

--월급이 회사의 평균월급 이상인 사람들의 이름과 월급을 조회
SELECT FIRST_NAME,SALARY FROM EMPLOYEES
WHERE SALARY >=(SELECT AVG(SALARY) FROM EMPLOYEES);

--사번이 111번인 사원의 직종과 같고 사번이 159번인 사원의 급여보다 많이 받는 사원들의 정보를 사번, 이름, 직종, 급여 순으로 출력
SELECT EMPLOYEE_ID,FIRST_NAME,JOB_ID,SALARY FROM EMPLOYEES
WHERE JOB_ID=(SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID=111)
				AND SALARY>(SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID=159);

