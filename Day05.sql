--직종, 평균급여를 출력하되, 평균급여가 Bruce사원보다 큰(초과) 경우를 조회
SELECT JOB_ID,AVG(SALARY) FROM EMPLOYEES
GROUP BY JOB_ID HAVING AVG(SALARY)>(SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Bruce');

--사원테이블에서 성에 'Bat'이라는 단어를 포함하고 있는 사원과 같은 부서에서 근무하는 사원의 부서번호,이름을 출력
SELECT DEPARTMENT_ID,FIRST_NAME FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE LAST_NAME LIKE 'Bat%');

--사원테이블에서 100번 부서의 최소 급여보다 많이 받는(초과) 다른 모든 부서의 부서번호, 최소급여를 출력
SELECT DEPARTMENT_ID,MIN(SALARY) FROM EMPLOYEES
GROUP BY DEPARTMENT_ID HAVING MIN(SALARY)>(SELECT MIN(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID=100);

-----------------------------------------------------------------------------------------------------------

SELECT * FROM PLAYER;

--PLAYER테이블에서 'K01'인 선수 중 POSITION이 'GK'인 선수
SELECT *FROM (SELECT *FROM PLAYER WHERE TEAM_ID = 'K01')
WHERE "POSITION" = 'GK';

--PLAYER테이블에서 전체평균키와 포지션별 평균키 구하기
SELECT "POSITION",AVG(HEIGHT),(SELECT ROUND(AVG(HEIGHT),1)FROM PLAYER) FROM PLAYER
WHERE "POSITION" IS NOT NULL GROUP BY "POSITION";

-------------------------------------------------------------------------------------------------------------------------

--AUTO COMMIT() : 내가 실행하는 쿼리문이 테이블에 바로 반영 -> COMMIT이 되면 되돌아가는 것이 불가능함
--위에 T를 눌러서 커밋과 롤백을 활성화시킴(Auto->None으로 변경)

--PLAYER테이블에서 NICKNAME이 NULL인 선수들은 정태민 선수의 닉네임으로 변경하기
UPDATE PLAYER SET NICKNAME = (SELECT NICKNAME FROM PLAYER WHERE PLAYER_NAME = '정태민')
WHERE NICKNAME IS NULL;
SELECT * FROM PLAYER;

--사원테이블에서 평균 급여보다 낮은 사원들의 급여를 10%인상 -> AVG(SALARY)=6461
UPDATE EMPLOYEES SET SALARY = SALARY*1.1 WHERE SALARY<(SELECT AVG(SALARY) FROM EMPLOYEES); 
SELECT AVG(SALARY) FROM EMPLOYEES;

--PLAYER테이블에서 평균키보다 큰 선수들을 삭제
SELECT AVG(HEIGHT) FROM PLAYER; 
DELETE FROM PLAYER WHERE HEIGHT > (SELECT AVG(HEIGHT)FROM PLAYER) ;
SELECT * FROM PLAYER;

-------------------------------------------------------------------------------------------------------------------------

--사원테이블에서 성과 이름 연결하기
SELECT FIRST_NAME ||' '|| LAST_NAME FROM EMPLOYEES;

--OO의 급여는 OO이다.
SELECT FIRST_NAME||'의 급여는'||SALARY||'이다.' FROM EMPLOYEES;

-------------------------------------------------------------------------------------------------------------------------

SELECT * FROM EMPLOYEES;

SELECT COUNT(SALARY) AS 개수,
       MAX(SALARY) AS 최대값,
       MIN(SALARY) AS 최소값,
       SUM(SALARY) AS 합계,
       AVG(SALARY) AS 평균 FROM EMPLOYEES;

--사원테이블에서EMPLOYEE_ID를 "사번"으로 FIRST_NAME을 "이름"로, SALARY를 "급여"로 바꿔서 검색
SELECT EMPLOYEE_ID AS "사번", FIRST_NAME AS "이름", SALARY AS "급여" FROM EMPLOYEES;
SELECT EMPLOYEE_ID "사번", FIRST_NAME "이름", SALARY "급여" FROM EMPLOYEES;--AS삭제도 가능

--JOIN
SELECT DEPARTMENT_ID, DEPARTMENT_ID FROM EMPLOYEES, DEPARTMENTS;--오류
SELECT EMPLOYEES.DEPARTMENT_ID, DEPARTMENTS.DEPARTMENT_ID FROM EMPLOYEES, DEPARTMENTS;
SELECT e.DEPARTMENT_ID, d.DEPARTMENT_ID FROM EMPLOYEES e, DEPARTMENTS d;

--INNER JOIN : 
--사원테이블에는 부서명이 없음, 부서테이블에는 DEPARTMENT_ID칼럼을 PK로 가지고 있음
--사원테이블에는 DEPARTMENT_ID칼럼을 FK로 가지고 있음
SELE * FROM DEPARTMENTS d;
SELE * FROM EMPLOYEES e ;
SELECT E.FIRST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

--부서테이블, 지역테이블(LOCATION)로부터 부서명과 도시명(CITY)을 조회
SELECT DEPARTMENT_NAME, CITY
FROM DEPARTMENTS D JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID;

--지역테이블과 나라테이블(CONTRIES)를 조회하여 도시명과 국가명(CONTRY_NAME)을 조회하세요
SELECT * FROM COUNTRIES;
SELECT CITY, COUNTRY_NAME
FROM LOCATIONS L JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID;

--이름, 성, 직종, 직업명을 조회 -> 테이블 : EMPLOYEES, JOBS
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_ID, J.JOB_TITLE
FROM EMPLOYEES E JOIN JOBS J ON E.JOB_ID = J.JOB_ID;

--테이블 3개 조인하기
--사원,부서,지역테이블로부터 이름,이메일,부서번호,부서명,지역번호,도시명 출력
SELECT E.FIRST_NAME,E.EMAIL,E.DEPARTMENT_ID,D.DEPARTMENT_NAME,L.LOCATION_ID,L.CITY
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID;

--Seattle에 있는 사람만 조회(on이 where과 같은 역할을 함)
SELECT E.FIRST_NAME,E.EMAIL,E.DEPARTMENT_ID,D.DEPARTMENT_NAME,L.LOCATION_ID,L.CITY
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
AND L.CITY = 'Seattle';

-------------------------------------------------------------------------------------------------------------------------

--INNER JOIN_SELF INNER JOIN
SELECT * FROM EMP;

SELECT E2.ENAME 직원,E1.ENAME 상사
FROM EMP E1 JOIN EMP E2
ON E1.EMPNO = E2.MGR;

--직원과 상사의 넘버를 저장함
SELECT E2.ENAME,E2.MGR 직원,E1.ENAME 상사,E1.EMPNO
FROM EMP E1 JOIN EMP E2
ON E1.EMPNO = E2.MGR;

-------------------------------------------------------------------------------------------------------------------------

CREATE TABLE 테이블A(
	A_id NUMBER,
	A_NAME VARCHAR2(10)
);

CREATE TABLE 테이블B(
	B_id NUMBER,
	B_NAME VARCHAR2(10)
);

INSERT ALL
	INTO 테이블A values(1, 'John')
	INTO 테이블A values(2, 'Jane')
	INTO 테이블A values(3, 'Bob')
	INTO 테이블B values(101, 'Apple')
	INTO 테이블B values(102, 'Banana')
SELECT * FROM DUAL;

SELECT * FROM 테이블A;--3개
SELECT * FROM 테이블B;--2개

SELECT * FROM 테이블A CROSS JOIN 테이블B;--6개

-------------------------------------------------------------------------------------------------------------------------

--OUTER JOIN
--사원 테이블과 부서테이블의 LEFT OUTER JOIN을 이용하여 사원이 어느 부서에 있는지 조회
SELECT E.FIRST_NAME,D.DEPARTMENT_NAME 
FROM EMPLOYEES E LEFT OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID  = D.DEPARTMENT_ID; 

--사원 테이블과 부서테이블의 RIGHT OUTER JOIN을 이용하여 사원이 어느 부서에 있는지 조회
SELECT E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E RIGHT OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

--FULL OUTER : LEFT값과 RIGHT값이 다 나옴
--ex.상품주문할 때 왼쪽값(회원정보)와 오른쪽값(상품정보)가 주문정보에 모두 담김
SELECT E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E FULL OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-------------------------------------------------------------------------------------------------------------------------

--TEAM테이블과 STADIUM테이블을 통해 홈팀이 있는 구장만 팀이름과 구장이름으로 조회
SELECT * FROM TEAM;
SELECT * FROM STADIUM;

SELECT TEAM_NAME, STADIUM_NAME 
FROM TEAM T LEFT OUTER JOIN STADIUM S  ON T.TEAM_ID = S.HOMETEAM_ID;

SELECT TEAM_NAME, STADIUM_NAME 
FROM TEAM T RIGHT OUTER JOIN STADIUM S  ON T.TEAM_ID = S.HOMETEAM_ID;--홈팀없는 경기장까지 나옴

-------------------------------------------------------------------------------------------------------------------------

--VIEW
--누가 얼마받는지에 대한 조회
SELECT EMPLOYEE_ID,FIRST_NAME,SALARY FROM EMPLOYEES;--BUT.매번 이렇게 적기 귀찮음

CREATE VIEW MY_EMPL AS
(SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES);--TABLE을 DROP하지 않고도 OR REPLACE을 사용해서 쉽게 TABLE 수정가능

SELECT * FROM MY_EMPL;

CREATE OR REPLACE VIEW MY_EMPL AS---> AS가 없으면 VIEW가 만들어 지지 않음
(SELECT EMPLOYEE_ID,FIRST_NAME,SALARY, (SALARY * COMMISSION_PCT) COMM
FROM EMPLOYEES);

SELECT * FROM MY_EMPL;

--선수테이블
SELECT * FROM PLAYER;

--VIEW작성 : 선수의 이름과 나이를 조회하는 쿼리를 넣기(TABLE이름 : PLAYER_AGE)
CREATE OR REPLACE VIEW PLAYER_AGE AS(
SELECT PLAYER_NAME,ROUND((SYSDATE - BIRTH_DATE)/365) AGE FROM PLAYER);

SELECT * FROM PLAYER_AGE;

--나이가 30살 이상인 선수들만 검색
SELECT * FROM PLAYER_AGE WHERE AGE>=30;

--VIEW작성 : TABLE이름은 DATA_PLUS, 급여를 많이 받는 순으로 순위와 이름, 급여를 조회
CREATE OR REPLACE VIEW DATA_PLUS AS(
SELECT DENSE_RANK()OVER(ORDER BY SALARY DESC) "RANK", FIRST_NAME, SALARY
FROM EMPLOYEES);

SELECT * FROM DATA_PLUS;

--PLAYER테이블 뒤에 TEAM_NAME 칼럼을 추가한 VIEW만들기
--JOIN을 사용, 뷰이름 : PLAYER_TEAM_NAME
CREATE OR REPLACE VIEW PLAYER_TEAM_NAME AS(
	SELECT P.*, TEAM_NAME
	FROM PLAYER P JOIN TEAM T
	ON P.TEAM_ID = T.TEAM_ID);

SELECT * FROM PLAYER_TEAM_NAME;

--HOMETEAM_ID, STADIUM_NAME, TEAM_NAME을 조회
--홈팀이 없는 경기장도 검색하기, VIEW이름 : STADIUM_INFO

CREATE OR REPLACE VIEW STADIUM_INFO AS(
	SELECT HOMETEAM_ID, STADIUM_NAME, TEAM_NAME
	FROM TEAM T RIGHT OUTER JOIN STADIUM S
	ON T.TEAM_ID = S.HOMETEAM_ID);

SELECT * FROM STADIUM_INFO;

--홈팀이 없는 경기장을 검색
SELECT * FROM STADIUM_INFO WHERE HOMETEAM_ID IS NULL;

-------------------------------------------------------------------------------------------------------------------------

--TCL
SELECT * FROM EMPLOYEES;

--EMPLOTEES테이블에서 JOB_ID가 'IT_PROG'인 사람의 이름을 자신의 이름으로 바꾸기
UPDATE EMPLOYEES SET FIRST_NAME = 'Ka' WHERE JOB_ID = 'IT_PROG';
ROLLBACK;
--데이터베이스에 영향을 주는 INSERT, UPDATE, DELETE문에서 많이 사용됨

