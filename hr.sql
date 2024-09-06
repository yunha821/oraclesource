-- EMPLOYEES (scott 계정의 emp 테이블 원본)
-- EMPLOYEES 전체 조회
SELECT * FROM EMPLOYEES e ;
-- 컬럼 지정 조회 (from 데이블명 먼저 지정하면 컬럼명 자동지정 가능)
SELECT
	FIRST_NAME,
	LAST_NAME,
	JOB_ID
	EMPLOYEES e ;
FROM


-- 사원 번호가 176인 사원의 LAST_NAME, 부서번호 조회
SELECT e.LAST_NAME , DEPARTMENT_ID FROM EMPLOYEES e WHERE EMPLOYEE_ID =176;

-- 연봉이 12000 이상 되는 직원들의 LAST_NAME과 연봉 조회
SELECT e.LAST_NAME, e.SALARY FROM EMPLOYEES e WHERE SALARY >=12000;

-- 연봉이 5000~ 12000 범위가 아닌 사람들의 LAST_NAME 과 연봉 조회
SELECT e.LAST_NAME, e.SALARY FROM EMPLOYEES e WHERE SALARY < 5000 OR SALARY >112000;


-- 20번 혹은 50번 부서에서 근무하는 사원들의 LAST_NAME, 부서번호를 조회
-- 단 이름의 오름차순, 부서의 오름차순으로 정렬
SELECT
	e.LAST_NAME ,
	e.DEPARTMENT_ID
FROM
	EMPLOYEES e
WHERE
	e.DEPARTMENT_ID IN(20, 50)
ORDER BY
	e.LAST_NAME ASC ,
	e.DEPARTMENT_ID ASC; 

-- 커미션을 버는 사원들의 last_name, salary, commision_pct 를 조회
-- 단 연봉의 내림차순, 커미션 내림차순으로 정렬
SELECT
	e.LAST_NAME,
	e.SALARY,
	e.COMMISSION_PCT
FROM
	EMPLOYEES e
WHERE
	e.COMMISSION_PCT > 0
ORDER BY
	e.SALARY DESC,
	e.COMMISSION_PCT DESC;


-- 연봉이 2500, 3500, 7000이 아니며 job_id가 SA_REP or ST_CLERK 인 사원 조회
SELECT
	*
FROM
	EMPLOYEES e
WHERE
	e.SALARY NOT IN(2500, 3500, 7000)
	AND e.JOB_ID IN('SA_REP', 'ST_CLERK');


-- 2018/02/20 ~ 2018/05/01 사이에 고용된 직원들의 LAST_NAME, EMPLOYEE_ID, 고용일자(HIRE_DATE)조회
-- 날짜 데이터도 홑따옴표
SELECT
	e.LAST_NAME, e.EMPLOYEE_ID , e.HIRE_DATE 
FROM
	EMPLOYEES e
WHERE
	e.HIRE_DATE >= '2018-02-20'
	AND e.HIRE_DATE <= '2018-05-01';

-- 2015년에 고용된 사원 조회
SELECT * FROM EMPLOYEES e WHERE e.HIRE_DATE >= '2015-01-01' AND e.HIRE_DATE <='2015-12-31';


-- BETWEEN A AND B 사용하기

-- 20번 혹은 50번 부서에서 근무하며, 연봉이 5000~12000 사이인 직원들의 
-- FIRST_NAME, LAST_NAME, 연봉 조회(연봉 오름차순)
SELECT
	e.FIRST_NAME ,
	e.LAST_NAME ,
	e.SALARY
FROM
	EMPLOYEES e
WHERE
	e.DEPARTMENT_ID IN(20, 50)
	AND e.SALARY BETWEEN 5000 AND 12000
ORDER BY
	e.SALARY;


--  연봉이 5000~12000 사이가 아닌 직원들의 전체 정보 조회
SELECT
	*
FROM
	EMPLOYEES e
WHERE
 e.SALARY NOT BETWEEN 5000 AND 12000;


-- 2018/02/20 ~ 2018/05/01 사이에 고용된 직원들의 LAST_NAME, EMPLOYEE_ID, 고용일자(HIRE_DATE)조회
 SELECT
	e.LAST_NAME,
	e.EMPLOYEE_ID ,
	e.HIRE_DATE
FROM
	EMPLOYEES e
WHERE
	e.HIRE_DATE BETWEEN '2018-02-20'
	AND '2018-05-01';
	

-- LIKE
-- LAST_NAME 에 u가 포함되는 사원들의 사번, LAST_NAME 조회
SELECT e.EMPLOYEE_ID , e.LAST_NAME FROM EMPLOYEES e WHERE e.LAST_NAME LIKE '%u%';

-- LAST_NAME 의 네번째 글자가 a 인 사원들의 사번, LAST_NAME 조회
SELECT e.EMPLOYEE_ID , e.LAST_NAME FROM EMPLOYEES e WHERE e.LAST_NAME LIKE '___a%';

-- LAST_NAME에 a 혹은 e 글자가 포함되는 사원들의 사번, LAST_NAME 조회(단,LAST_NAME은 오름차순)
SELECT
	e.EMPLOYEE_ID ,
	e.LAST_NAME
FROM
	EMPLOYEES e
WHERE
	e.LAST_NAME LIKE '%e%'
	OR e.LAST_NAME LIKE '%a%'
ORDER BY
	e.LAST_NAME ;

-- -- LAST_NAME에 a 와 e 글자가 포함되는 사원들의 사번, LAST_NAME 조회(단,LAST_NAME은 오름차순)
SELECT
	e.EMPLOYEE_ID ,
	e.LAST_NAME
FROM
	EMPLOYEES e
WHERE
	e.LAST_NAME LIKE '%a%'
	AND e.LAST_NAME LIKE '%e%'
ORDER BY
	e.LAST_NAME ;


-- IS NULL
-- MANAGER_ID 가 없는 사원들의 LAST_NAME, JOB_ID 조회
SELECT
	e.LAST_NAME,
	e.JOB_ID
FROM
	EMPLOYEES e
WHERE
	e.MANAGER_ID IS NULL;

-- JOB_ID가 ST_CLERK 가 아닌 사원이 없는 부서 조회
-- 단, 부서번호가 NULL 인 경우는 제외한다.
SELECT DISTINCT 
	e.DEPARTMENT_ID
FROM
	EMPLOYEES e
WHERE
	e.JOB_ID NOT IN('ST_CLERK')
	AND e.DEPARTMENT_ID IS NOT NULL;


--COMMISSION_PCT 가 NULL이 아닌 사원들 중에서 COMMISSIION = SALARY * COMMISSIION_PCT 구한다
-- 사원번호, FIRST_NAME, JOB_ID 와 함께 조회
SELECT
	e.EMPLOYEE_ID ,e.FIRST_NAME , e.JOB_ID, e.COMMISSION_PCT * e.SALARY AS COMMISSION
FROM
	EMPLOYEES e
WHERE
	e.COMMISSION_PCT IS NOT NULL;


-- 부서 80 의 사원에 적용 가능한 세율 표시하기
-- LAST_NAME, SALARY, TAX_RATE 출력
-- TAX_RATE 은 SALARY/2000 으로 나눈 후 버림
-- 해당 값이 0이면 0.0/ 1, 0.09 / 2, 0.20 / 3, 0.30 / 4, 0.40 / 5, 0.42 / 6, 0.44/ 그외 0.45
SELECT
	e.LAST_NAME ,
	e.SALARY ,
	DECODE(TRUNC(e.SALARY / 2000),
	0, 0.0,
	1, 0.09,
	2, 0.20,
	3, 0.30,
	4, 0.40,
	5, 0.42,
	6, 0.44,
	0.45
	) AS TAX_RATE
FROM
	EMPLOYEES e;



-- 회사 내의 최대 연봉 및 최소 연봉의 차이를 출력
SELECT
	MAX(e.SALARY)- MIN(e.SALARY) AS SAL_GAP
FROM
	EMPLOYEES e ;

-- 매니저로 근무하는 사원들의 총 숫자를 출력
SELECT
	COUNT(DISTINCT e.MANAGER_ID) AS 매니저수
FROM
	EMPLOYEES e;

-- 매니저가 없는 사원들은 제외하고 매니저가 관리하는 사원들 중에서 최소 급여를 받는 사원 조회
-- (매니저가 관리하는 사원 중에서 연봉이 6000 미만 제외)
SELECT
	Manager_ID,
	MIN(SALARY)
FROM
	EMPLOYEES e
GROUP BY
	MANAGER_ID
HAVING
	MANAGER_ID IS NOT NULL
	AND MIN(SALARY) >= 6000
ORDER BY
	MANAGER_ID ;

--1.
-- join
-- 자신의 담당 매니저의 고용일보다 빠른 입사자 찾기
-- 사원번호, 입사일, 이름(last_name), 매니저아이디 출력
-- self 조인
SELECT
	e.EMPLOYEE_ID,
	e.HIRE_DATE,
	e.LAST_NAME,
	e.MANAGER_ID
FROM
	EMPLOYEES e
JOIN EMPLOYEES e2 ON
	e.manager_id = e2.EMPLOYEE_ID 
	AND e.HIRE_DATE < e2.HIRE_DATE ;

--2.
-- 도시 이름이 T로 시작하는 지역에 사는 사원들의 정보 조회
-- 사원번호, 이름(last_name), 부서번호, 지역명
-- employees, department, locations 조인
SELECT
	e.EMPLOYEE_ID ,
	e.LAST_NAME,
	d.DEPARTMENT_ID ,
	l.CITY
FROM
	EMPLOYEES e
JOIN DEPARTMENTS d ON
	e.DEPARTMENT_ID = d.DEPARTMENT_ID
JOIN LOCATIONS l ON
	d.LOCATION_ID = l.LOCATION_ID
WHERE l.CITY LIKE 'T%';


--3.
-- 각 부서별 사원 수, 평균 연봉(소수점 2자리까지) 조회
-- 부서명, 부서 위치 아이디, 부서별 사원 수 , 평균 연봉 출력
-- employees, department 조인
SELECT
	d.DEPARTMENT_NAME,
	d.LOCATION_ID,
	COUNT(e.EMPLOYEE_ID),
	ROUND(AVG(e.SALARY), 2)
FROM
	EMPLOYEES e
JOIN DEPARTMENTS d ON
	e.DEPARTMENT_ID = d.DEPARTMENT_ID
GROUP BY
	d.DEPARTMENT_NAME,
	d.LOCATION_ID
ORDER BY
	d.LOCATION_ID ;

--4.
-- Excutive 부서에서 근무하는 모든 사원들의 부서번호, 이름(last_name), job_id 조회
-- employees, department 조인
SELECT
	e.LAST_NAME,
	e.DEPARTMENT_ID,
	e.JOB_ID 
FROM
	EMPLOYEES e
JOIN DEPARTMENTS d ON
	e.DEPARTMENT_ID = d.DEPARTMENT_ID
WHERE
d.DEPARTMENT_NAME = 'Executive';

--5.
-- 기존의 직무를 계속 하고 있는 사원 조회
-- 사원번호, job_id 출력
-- employees, job_history 조인
SELECT
	e.EMPLOYEE_ID ,
	jh.JOB_ID
FROM
	EMPLOYEES e
JOIN JOB_HISTORY jh ON
	e.EMPLOYEE_ID = jh.EMPLOYEE_ID
	AND e.JOB_ID = jh.JOB_ID ;


--6.
-- 각 사원별 소속부서에서 자신보다 늦게 고용되었으나 많은 급여를 받는 사원의 정보 조회
-- first_name과 last_name 을 연결하여 출력, 급여, 입사일 출력
-- employees self 조인
SELECT
	DISTINCT e.department_id,
	e.first_name || ' ' || e.last_name,
	e.salary,
	e.hire_date
FROM
	EMPLOYEES e
JOIN EMPLOYEES e2 ON
	e.department_id = e2.DEPARTMENT_ID
	AND e.HIRE_DATE < e2.HIRE_DATE
	AND e.SALARY < e2.SALARY
ORDER BY e.department_id; 


-- 다중열 서브 쿼리로 변경
-- Excutive 부서에서 근무하는 모든 사원들의 부서번호, 이름(last_name), job_id 조회
SELECT
	e.LAST_NAME,
	e.DEPARTMENT_ID,
	e.JOB_ID
FROM
	EMPLOYEES e
WHERE
	(e.DEPARTMENT_id,
	'Executive') IN (
	SELECT
		d.department_id,
		d.department_name
	FROM
		DEPARTMENTS d) ;
