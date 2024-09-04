--SQL 쿼리문은 대소문자를 구별하지 않음
-- 단, 비밀번호는 구별함
-- DML : 데이터 조작어(CRUD - Create / Read / Update / Delete)
-- 1) 조회 
-- SELECT 컬럼명  ----------5번
-- FROM 테이블명   ----------1번
-- WHERE 조건절    ----------2번
-- GROUP BY 컬럼명 ----------3번
-- HAVING 집계함수 조건절 -----4번
-- ORDER BY 컬럼명..    -----6번


-- EMP(employee - 사원테이블)
-- DEPT(department - 부서테이블)
-- SALGRADE(급여테이블)

-- 전체 조회
SELECT * FROM EMP e;

-- 선택 조회
-- 1) 컬럼 지정
-- ctrl + shift + f : 자동정렬
SELECT
	EMPNO,
	ENAME,
	MGR
FROM
	EMP e;

-- 중복 제거 조회 : distinct
SELECT
	DISTINCT DEPTNO
FROM
	EMP e ;

-- 별칭(AS, "" 필수 아님)
SELECT
	EMPNO AS "사원번호"
FROM
	EMP e ;
	
SELECT
	EMPNO "사원번호"
FROM
	EMP e ;
	
SELECT
	EMPNO AS 사원번호 -- 중간에 공백 넣을 경우는 "" 필수
FROM
	EMP e ;
	
SELECT
	EMPNO,
	ENAME,
	SAL,
	COMM,
	SAL * 12 + COMM AS "연봉"
FROM
	EMP e;
	

-- 조회 후 정렬(오름차순-asc, 내림차순-desc)
-- sal 내림차순
SELECT
	ENAME,
	SAL
FROM
	EMP e
ORDER BY
	sal DESC;

-- sal 오름차순(기본)
SELECT
	ENAME,
	SAL
FROM
	EMP e
ORDER BY
	sal;
	
-- empno 내림차순
SELECT
	*
FROM
	EMP
ORDER BY
	EMPNO DESC ;
	
-- deptno 오름차순, sal 내림차순
SELECT
	*
FROM
	EMP e
ORDER BY
	DEPTNO ASC,
	SAL DESC;

-- 예제
SELECT 
	EMPNO AS EMPLOYEE_NO,
	ENAME EMPLOYEE_NAME,
	MGR  AS MANAGER,
	SAL  AS SALARY,
	COMM AS COMMISION,
	DEPTNO AS DEPARTMENT_NO
FROM
	EMP e
ORDER BY
	EMPNO DESC,
	ENAME ASC; 
	
-- 선택 조회
-- 2) 조건 지정
-- SELECT 컬럼나열 FROM 테이블명 WHERE 조건 나열;

-- 부서번호가 30번인 사원을 전체 조회
-- = : 동일하다
SELECT
	*
FROM
	EMP e
WHERE
	DEPTNO = 30;
	

-- 사원번호가 7839 인 사원 조회
-- 사원번호는 중복되지 않음
-- WHERE 조건으로 중복되지 않는 값이 사용된다면 결과는 하나만 조회됨
SELECT
	*
FROM
	EMP e
WHERE
	EMPNO = 7839;
	
-- 부서번호가 30이고, 직책이 salesman 인 사원 조회
-- 문자열은 홑따옴표만 사용 > ''
-- 값은 대소문자 구분
SELECT * FROM EMP e WHERE DEPTNO = 30 AND JOB = 'SALESMAN';

-- 사원번호가 7698 이고 부서번호가 30 인 사원 조회
SELECT * FROM EMP e WHERE EMPNO = 7698 AND DEPTNO = 30;

-- 부서번호가 30이거나 직책이 CLERK인 사원 조회
SELECT * FROM EMP e WHERE DEPTNO = 30 OR JOB ='CLERK';


-- 연봉이 36000 인 사원 조회
SELECT * FROM EMP e WHERE e.SAL * 12 =36000;

-- 급여가 3000보다 큰 사원 조회
SELECT * FROM EMP e WHERE e.SAL > 3000;

-- 급여가 3000 이상인 사원 조회
SELECT * FROM EMP e WHERE e.SAL >= 3000;

-- ename 이 f 이후의 문자열로 시작하는 사원 조회
SELECT * FROM EMP e WHERE e.ENAME >= 'F';

-- 급여가 2500 이상이고 직업이 analyst 인 사원 조회
SELECT * FROM EMP e WHERE e.SAL >= 2500 AND e.JOB = 'ANALYST';


-- job 이 manager, salesman, clerk 인 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.JOB = 'MANAGER'
	OR e.JOB = 'SALESMAN'
	OR e.JOB = 'CLERK';

-- IN
SELECT
	*
FROM
	EMP e
WHERE
	e.JOB IN('MANAGER','SALESMAN','CLERK'); 

	
-- sal 이 3000이 아닌 사원 조회
-- !=, <>, ^=
SELECT * FROM EMP e WHERE e.SAL != 3000;

SELECT * FROM EMP e WHERE e.SAL <> 3000;

SELECT * FROM EMP e WHERE e.SAL ^= 3000;


-- job 이 manager, salesman, clerk 인이 아닌 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.JOB <> 'MANAGER'
	AND e.JOB != 'SALESMAN'
	AND e.JOB ^= 'CLERK';

SELECT
	*
FROM
	EMP e
WHERE
	e.JOB NOT IN('MANAGER','SALESMAN','CLERK'); 
	
-- 부서번호가 10번이거나 20번인 사원 조회
SELECT * FROM EMP e WHERE E.DEPTNO IN(10,20);


-- BETWEEN A AND B : 일정 범위 내의 데이터 조회 시 사용
-- NOT BETWEEN A AND B : 일정 범위가 아닌 데이터 조회 시 사용

-- 급여가 2000 이상이고 3000이하인 사원 조회
SELECT * FROM EMP e WHERE e.SAL BETWEEN 2000 AND 3000;

-- 급여가 2000 이상이고 3000이하가 아닌 사원 조회
SELECT * FROM EMP e WHERE e.SAL NOT BETWEEN 2000 AND 3000;


-- LIKE 연산자와 와일드 카드(%, _)
-- ENAME = 'JONES' : 전체 일치
-- ENAME 이 J 로 시작하는 or A 가 들어간.. : 부분 일치(LIKE)

-- J% : J로 시작하면 그 뒤에 어떤 문자가 몇 개가 오던지 상관없음
SELECT * FROM EMP e  WHERE ENAME LIKE 'J%';

-- _J%: 어떤 문자로 시작해도 상관없으나 개수는 하나 / 두번째 문자는 J/ 그 뒤에 어떤 문자가 몇 개가 오던지 상관없음
SELECT * FROM EMP e  WHERE ENAME LIKE '_J%';
SELECT * FROM EMP e  WHERE ENAME LIKE '_L%';

-- 사원명에 AM 문자가 포함된 사원 조회
SELECT * FROM EMP e WHERE ENAME LIKE '%AM%';

-- 사원명에 AM 문자가 포함되지 않는 사원 조회
SELECT * FROM EMP e WHERE ENAME NOT LIKE '%AM%';



-- IS NULL
-- SELECT * FROM EMP WHERE COMM = NULL; (X)
SELECT * FROM EMP e WHERE COMM IS NULL;
SELECT * FROM EMP e WHERE COMM IS NOT NULL;



-- 집합 연산자
-- UNION : 합집합(결과 값의 중복 제거)
-- UNION ALL : 합집합(중복)
-- MINUS : 차집합
-- INTERSECT : 교집합

-- UNION
-- 부서번호가 10번인 사원 조회(사번, 이름, 급여, 부서번호)
-- 부서번호가 20번인 사원 조회(사번, 이름, 급여) => 컬럼이 동일해야함 > 부서번호 추가 / 타입도 동일해야 함(select 순서)
SELECT
	e.EMPNO ,
	e.ENAME,
	e.SAL,
	e.DEPTNO
FROM
	EMP e
WHERE
	e.DEPTNO = 10
UNION
SELECT
	e.EMPNO ,
	e.ENAME,
	e.SAL,
	e.DEPTNO
FROM
	EMP e
WHERE
	e.DEPTNO = 20 ;


-- UNION ALL
SELECT
	e.EMPNO ,
	e.ENAME,
	e.SAL,
	e.DEPTNO
FROM
	EMP e
WHERE
	e.DEPTNO = 10
UNION ALL
SELECT
	e.EMPNO ,
	e.ENAME,
	e.SAL,
	e.DEPTNO
FROM
	EMP e
WHERE
	e.DEPTNO = 10 ;


-- MINUS
SELECT
	e.EMPNO ,
	e.ENAME,
	e.SAL,
	e.DEPTNO
FROM
	EMP e
MINUS
SELECT
	e.EMPNO ,
	e.ENAME,
	e.SAL,
	e.DEPTNO
FROM
	EMP e
WHERE
	e.DEPTNO = 10 ;


-- INTERSECT
SELECT
	e.EMPNO ,
	e.ENAME,
	e.SAL,
	e.DEPTNO
FROM
	EMP e
INTERSECT
SELECT
	e.EMPNO ,
	e.ENAME,
	e.SAL,
	e.DEPTNO
FROM
	EMP e
WHERE
	e.DEPTNO = 10 ;












