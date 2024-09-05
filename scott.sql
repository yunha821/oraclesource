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


-- ####################################################
-- 9/5(목)
-- 1. 오라클 내장 함수
-- 2. 사용자 정의 함수(PL/SQL)

-- 오라클 내장 함수
-- 1. 단일행 함수 : 데이터가 한 행 씩 입력되고 입력된 한 행당 결과가 하니씩 나오는 함수
-- 2. 다중행 함수 : 여러 행이 입력되고 결과가 하나의 행으로 반환되는 함수

-- 1. 문자함수
-- UPPER(문자열) : 괄호 안 문자열을 모두 대문자로
-- LOWER(문자열) : 괄호 안 문자열을 모두 소문자로
-- INITCAP(문자열) : 괄호 안 문자 데이터 중 첫문자만 대문자, 나머지는 소문자로
-- LENGTH(문자열) : 문자열 길이
-- LENGTHB(문자열) : 문자열 바이트 수
-- SUBSTR(문자열, 시작위치) / SUBSTR(문자열, 시작위치, 추출길이) : 문자열 일부 추출
-- INSTR(문자열, 찾으려는 문자) : 특정 문자나 문자열이 어디에 포함되어 있는지 (=자바 indexOf)
-- INSTR(문자열, 찾으려는 문자, 위치 찾기를 시작할 대상 문자열 데이터 위치, 시작위치에서 찾으려는 문자가 몇 번째인지)
-- REPLACE(문자열, 찾는문자, 대체문자)
-- CONCAT(문자열1, 문자열2) : 문자열 연결
-- TRIM / LTRIM / RTRIM : 특정 문자를 제거(주로 공백 제거 사용)

-- 데이터는 대소문자 구분 함

SELECT e.ENAME, UPPER(e.ENAME) , LOWER(e.ENAME) , INITCAP(e.ENAME)  FROM EMP e ;

SELECT FROM EMP e ;

--smith
SELECT * FROM EMP e WHERE UPPER(ename) = UPPER('smith'); 

SELECT * FROM EMP e WHERE UPPER(ename) LIKE UPPER('%smith%'); --LIKE 연산자 % 무조건 사용됨


-- DUAL : 오라클에서 제공하는 기본 테이블(함수 적용 결과 보기)
-- LENGTH / LENGTHB
SELECT  LENGTH('한글'), LENGTHB('한글'), LENGTH('AB'), LENGTHB('AB') -- 한글 : 글자 하나 당 3byte, 총 6 byte
FROM DUAL;

-- SUBSTR
SELECT
	JOB,
	SUBSTR(JOB, 1, 2),
	SUBSTR(JOB, 3, 2),
	SUBSTR(JOB, 5)
FROM
	EMP e; 

-- - : 오른쪽 끝을 의미
SELECT
	JOB,
	SUBSTR(JOB, -LENGTH(JOB)),
	SUBSTR(JOB, -LENGTH(JOB), 2),
	SUBSTR(JOB, -3)
FROM
	EMP e; 

 
SELECT
	INSTR('HELLO, ORACLE', 'L') AS INSTR_1,
	INSTR('HELLO, ORACLE', 'L', 5) AS INSTR_2,
	INSTR('HELLO, ORACLE','L',2,2) AS INSTR_3
	FROM dual;


-- 사원 이름에 S가 있는 행 구하기
-- LIKE
SELECT * FROM  EMP e WHERE e.ENAME LIKE '%S%';

--INSTR
SELECT * FROM  EMP e WHERE INSTR(e.ENAME,'S') >0 ;


-- 010-1234-1535

SELECT
	'010-1234-1535' AS REPLACE_BEFORE,
	REPLACE('010-1234-1535', '-', ' ') AS REPLACE_1,
	REPLACE('010-1234-1535', '-') AS REPLACE_2
FROM
	DUAL;

-- EMPNO, ENAME 연결 조회
-- CONCAT(EMPNO, CONCAT(':',ENAME))
SELECT CONCAT(EMPNO, ENAME),CONCAT(EMPNO, CONCAT(':',ENAME))
FROM	EMP e ;


-- || == concat
SELECT EMPNO || ENAME, EMPNO || ':' || ENAME
FROM	EMP e ;


SELECT
	'[' || TRIM(' _Oracle_ ') || ']' AS TRIM,
	'[' || LTRIM(' _Oracle_ ') || ']' AS LTRIM,
	'[' || LTRIM('<_Oracle_>', '_<') || ']' AS LTRIM2,
	'[' || RTRIM(' _Oracle_ ') || ']' AS RTRIM,
	'[' || RTRIM('<_Oracle_>', '>_') || ']' AS RTRIM2
FROM
	Dual;


-- 숫자함수
-- ROUND(숫자) or ROUND(숫자, [반올림 위치])
-- TRUNC(숫자) or TRUNC(숫자, [버림 위치])
-- CEIL(숫자) : 지정한 숫자와 가장 가까운 큰 정수 찾기
-- FLOOR(숫자) :지정한 숫자와 가장 가까운 작은 정수 찾기
-- MOD(숫자, 나눌 숫자) == %

SELECT
	ROUND(1234.5678) AS ROUND,
	ROUND(1234.5678, 0) AS ROUND_0,
	ROUND(1234.5678, 1) AS ROUND_1,
	ROUND(1234.5678, 2) AS ROUND_2,
	ROUND(1234.5678, -1) AS ROUND_MINUS_1,
	ROUND(1234.5678, -2) AS ROUND_MINUS_2
FROM  dual;

SELECT
	TRUNC (1234.5678) AS TRUNC,
	TRUNC(1234.5678, 0) AS TRUNC_0,
	TRUNC(1234.5678, 1) AS TRUNC_1,
	TRUNC(1234.5678, 2) AS TRUNC_2,
	TRUNC(1234.5678, -1) AS TRUNC_MINUS_1,
	TRUNC(1234.5678, -2) AS TRUNC_MINUS_2
FROM  dual;

SELECT CEIL (3.14), FLOOR(3.14), CEIL(-3.14), FLOOR(-3.14)
FROM dual;

SELECT mod(15,6)
FROM dual;

-- 날짜 함수
-- SYSDATE : 오라클 서버가 설치된 OS의 현재 날짜와 시간 사용
-- 날짜 데이터 + 숫자 : 날짜 데이터와 숫자만큼 일수 이후의 날짜
-- 날짜 데이터 - 날짜 데이터 : 일수 차이
-- 날짜 데이터 + 날짜 데이터 : 안됨
-- ADD_MONTHS(날짜 데이터, 더할 개월 수)
-- MONTHS_BETWEEN(날짜 데이터, 날짜 데이터) : 두 날짜 데이터 간의 차이를 개월 수로 계산
-- NEXT_DAY(날짜 데이터, 요일문자) : 날짜 데이터에서 돌아오는 요일의 날짜 반환
-- LAST_DAT(날짜 데이터) : 특정 날짜가 속한 달의 마지막 날짜 조회

SELECT SYSDATE FROM dual;

SELECT SYSDATE, SYSDATE -1, SYSDATE +1  FROM dual;

SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3) FROM	 dual;

-- 입사 20주년 조회
SELECT
	e.EMPNO,
	e.ENAME,
	e.HIREDATE,
	ADD_MONTHS(e.HIREDATE, 240)
FROM
	EMP e;

SELECT
	EMPNO,
	ENAME,
	HIREDATE,
	SYSDATE,
	MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTH1,
	MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTH2,
	TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTH3
FROM
	EMP;

SELECT SYSDATE , NEXT_DAY(SYSDATE, '월요일'), LAST_DAY(SYSDATE) FROM dual; 




-- 형변환 함수
-- TO_CHAR(날짜 데이터, '출력되길 원하는 문자형태')
-- TO_NUMBER(문자 데이터, '인식되길 원하는 숫자형태')
-- TO_DATE(문자 데이터, '출력되길 원하는 날짜형태')

-- NUMBER + '문자숫자' : 연산해줌
SELECT
	e.EMPNO,
	e.ENAME,
	e.EMPNO + '500'
FROM
	EMP e ;

-- 수치가 부적합합니다.
-- e.EMPNO 가 숫자 타입이기 때문에
SELECT e.EMPNO, e.ENAME, e.EMPNO + 'abc'
FROM EMP e ; (X)

-- 날짜 데이터 => 문자 데이터
-- 자바 월 mm / 분 MM
-- 오라클 월 MM / 분 MI
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD') AS 현재날짜
FROM Dual;

SELECT
	SYSDATE,
	TO_CHAR(SYSDATE, 'MM') AS 현재월,
	TO_CHAR(SYSDATE, 'MON') AS 현재월2,
	TO_CHAR(SYSDATE, 'MONTH') AS 현재월3
FROM
	Dual;

-- DD, DDD, DAY
SELECT
	SYSDATE,
	TO_CHAR(SYSDATE, 'DD') AS 일자,
	TO_CHAR(SYSDATE, 'Day') AS 일자2,
FROM
	Dual;

SELECT
	SYSDATE,
	TO_CHAR(SYSDATE, 'HH:MI:SS') AS 현재시간,
	TO_CHAR(SYSDATE, 'HH12:MI:SS') AS 현재시간2,
	TO_CHAR(SYSDATE, 'HH24:MI:SS') AS 현재시간3,
	TO_CHAR(SYSDATE, 'HH:MI:SS AM') AS 현재시간4
FROM
	Dual;


-- 문자 데이터 => 숫자 데이터
SELECT 1300 - '1500', '1300' + 1500
FROM dual;

SELECT '1300' + '1500'
FROM dual;

-- 수치가 부적합합니다(, 가 포함되면 문자로 처리)
-- SELECT '1,300' + '1,500'
-- FROM dual;

-- 9(숫자 한자리를 의미: 빈자리는 채우지 않음) or 0(숫자 한자리: 빈자리를 채움)

SELECT
	TO_NUMBER('1,300', '999,999') + TO_NUMBER('1,500', '999,999')
FROM
	Dual;


-- 문자 데이터 => 날짜 데이터
SELECT
	TO_DATE('2024-09-05', 'yyyy-mm-dd') AS TODATE1,
	TO_DATE('20240905', 'YYYY-MM-DD') AS TODATE2
FROM
	dual;
	

-- EMP 테이블에서 1981-06-01 이후에 입사한 사원 조회
SELECT * FROM EMP e WHERE e.HIREDATE >= '1981-06-01' ;

SELECT * FROM EMP e WHERE e.HIREDATE >= TO_DATE('1981-06-01', 'yyyy-mm-dd');


-- 날짜 데이터 + 날짜 데이터
-- 수치가 부적합합니다.
-- select '2024-09-05' - '2024-01-02' from dual;

--날짜와 날짜의 가산은 할 수 없습니다
SELECT TO_DATE('2024-09-05') + TO_DATE('2024-01-02')
FROM dual;

SELECT TO_DATE('2024-09-05') - TO_DATE('2024-01-02')
FROM dual;




-- NULL 처리 함수
-- NULL 과 산술연산이 안됨 => NULL 을 다른 값으로 변경
-- NVL(널 값, 대체 값)
-- NVL2(널 값, 널 아닌 경우 반환값, 널인 경우 반환값)
-- SAL == NULL (x) IS (o)

SELECT
	e.EMPNO ,
	e.ENAME ,
	e.SAL ,
	e.COMM ,
	e.SAL + NVL(e.COMM, 0) 
FROM
	EMP e ;


-- null 이 아니면 SAL*12+comm
-- null 이면 SAL*12
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.SAL ,
	e.COMM ,
	 NVL2(e.COMM, 'O', 'X')
FROM
	EMP e ;

SELECT
	e.EMPNO ,
	e.ENAME ,
	e.SAL ,
	e.COMM ,
	NVL2(e.COMM, 'O', 'X'), NVL2(e.COMM, (e.SAL*12)+e.COMM , e.SAL*12)
FROM
	EMP e ;



-- DECODE 함수 / CASE 문
-- DECODE(데이터,
--			조건1, 조건1 만족할 때 해야할 것,
--			조건2, 조건2 만족할 때 해야할 것
--			조건3, 조건3 만족할 때 해야할 것
--			) AS 별칭

-- JOB 이 MANAGER 라면 SAL * 1.1
-- JOB 이 SALESMAN 라면 SAL * 1.5
-- JOB 이 ANALYST 라면 SAL
-- 그 외라면 SAL * 1.03

SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	DECODE(JOB, 'MANAGER', e.SAL * 1.1,
	'SALESMAN', e.SAL * 1.5, 'ANALYST', e.SAL,
	e.SAL * 1.03) AS UPSAL
FROM
	EMP e;

SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	CASE
		JOB 
	WHEN 'MANAGER' THEN e.SAL * 1.1
		WHEN 'SALESMAN' THEN e.SAL * 1.5
		WHEN 'ANALYST' THEN e.SAL
		ELSE e.SAL * 1.03 
		END	AS UPSAL
	FROM
		EMP e;

	
-- COMM 널일 때 '해당사항없음'
-- COMM =0 일 때 '수당없음'
-- COMM >0 일 때 '수당 : COMM'

SELECT
	e.EMPNO,
	e.ENAME,
	e.COMM,
	CASE
	WHEN e.COMM  IS NULL THEN '해당사항없음'
		WHEN e.COMM = 0 THEN '수당없음'
		WHEN e.COMM > 0 THEN '수당 : ' || e.COMM 
		END	AS COMM_TEXT
	FROM
		EMP e;
	

-- EMP 테이블에서 사원들의 월 평균 근무일수는 21.5일이다
-- 하루 근문시간을 8시간으로 봤을 때 사원들의 하루급여(DAY_PAY)와
-- 시급(TIME_PAY) 을 계산하여 결과를 출력한다
-- 사번, 이름, SAL, DAY_PAY, TIME_PAY 출력
-- 단, 하루 급여는 소수점 셋째자리에서 버리고, 시급은 두번째 소수점에서 반올림하기
SELECT
	e.EMPNO,
	e.ENAME,
	e.SAL,
	TRUNC(e.SAL / 21.5, 2) AS DAY_PAY,
	ROUND(e.SAL / 21.5 / 8, 1) AS TIME_PAY
FROM
	EMP e; 
	

-- EMP 테이블에서 사원들은 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다.
-- 사원들이 징직원이 되는 날짜(R_JOB)를 YYYY-MM-DD 형식으로 출력한다.
-- 사번, 이름, 고용일, R_JOB 출력

SELECT
	e.EMPNO,
	e.ENAME,
	e.HIREDATE,
	TO_CHAR( NEXT_DAY(ADD_MONTHS(e.HIREDATE, 3), '월요일'), 'yyyy-mm-dd') AS R_JOB
FROM
	EMP e;

-- + 추가수당
-- COMM 이 없으면 'N/A', 있으면 COMM 출력
SELECT
	e.EMPNO,
	e.ENAME,
	e.HIREDATE,
	TO_CHAR( NEXT_DAY(ADD_MONTHS(e.HIREDATE, 3), '월요일'), 'yyyy-mm-dd') AS R_JOB,
	CASE 
		WHEN e.comm IS NULL THEN 'N/A'
		WHEN e.comm IS NOT NULL THEN e.comm || ''
	END AS COMM
FROM
	EMP e;

--ORA-01722: 수치가 부적합합니다
--SELECT comm, NVL(comm, 'N/A')
--FROM emp;

-- NVL
SELECT
	e.EMPNO,
	e.ENAME,
	e.HIREDATE,
	TO_CHAR( NEXT_DAY(ADD_MONTHS(e.HIREDATE, 3), '월요일'), 'yyyy-mm-dd') AS R_JOB,
	NVL(TO_CHAR(e.COMM), 'N/A')AS COMM
FROM
	EMP e;


-- EMP 테이블의 모든 사원을 대상으로 직속 상관의 사원번호(MGR)를 변환해서 CHG_MGR 에 출력
-- 사번, 이름,MGR, CHG_MGR 출력
-- 조건
-- MGR 이 널이면 '0000' / MGR 의 앞 두자리가 75 이면 '5555'/ 76 이면 '6666' / 77 이면 '7777' / 78이면 '8888' 출력
-- DECODE 문
SELECT
	e.EMPNO,
	e.ENAME,
	e.MGR,
	DECODE(SUBSTR(TO_CHAR(e.MGR),1,2),
	NULL , '0000',
	'75', '5555',
	'76', '6666',
	'77', '7777',
	'78', '8888',
	SUBSTR(TO_CHAR(e.MGR), 1) 
	)AS CHG_MGR
FROM
	EMP e ;

-- CASE 문
SELECT
	e.EMPNO,
	e.ENAME,
	e.MGR,
	CASE
		WHEN MGR IS NULL THEN '0000'
		WHEN MGR LIKE '75%' THEN '5555'
		WHEN MGR LIKE '76%' THEN '6666'
		WHEN MGR LIKE '77%' THEN '7777'
		WHEN MGR LIKE '78%' THEN '8888'
		ELSE SUBSTR(TO_CHAR(e.MGR), 1)
	END AS CHG_MGR
FROM
	EMP e ;





-- 다중행 함수
-- SUM(합계를 낼 열), COUNT(), MAX(), MIN(), AVG()
-- DISTINCT : 중복 제거

SELECT
	SUM(sal)
FROM
	EMP e ;

SELECT
	SUM(DISTINCT sal),
	SUM(ALL sal),
	SUM(sal)
FROM
	EMP e ;

SELECT
	SUM(DISTINCT sal),
	count(ALL sal),
	count(sal)
FROM
	EMP e ;

SELECT MAX(sal), MIN(sal) FROM emp;

SELECT
	MAX(sal),
	MIN(sal)
FROM
	emp
WHERE
	DEPTNO = 10;

-- 부서 번호가 20번인 사원의 최근 입사일 조회
SELECT Max(HIREDATE) FROM EMP e WHERE DEPTNO =20;

SELECT AVG(DISTINCT sal), AVG(ALL sal), AVG(sal)
FROM emp;

-- 부서 번호가 30번인 사원들의 평균 추가 수당
SELECT AVG(comm)
FROM EMP e
WHERE DEPTNO =30;



-- GROUP BY : 결과 값을 원하는 열로 묶어 출력
-- GROUP BY 그룹화할 열

-- 각 부서별 평균 급여 출력
SELECT
	AVG(sal)
FROM
	EMP e
GROUP BY
	e.DEPTNO
ORDER BY
	e.DEPTNO ;

-- 각 부서별, 직책별 평균 급여 출력
SELECT
	e.DEPTNO ,
	e.JOB,
	AVG(sal)
FROM
	EMP e
GROUP BY
	e.DEPTNO
ORDER BY
	e.DEPTNO ;


-- GROUP BY 표현식이 아닙니다.(GROUP BY 절을 사용할 때에는 SELECT 절에서 사용할 수 있는 열이 제한됨)
-- SELECT 가능 : GROUP BY 쓰여진 열, 다중행 함수
-- SELECT ename, AVG(sal) FROM EMP e GROUP BY DEPTNO ;

-- GROUP BY ~ HAVING : 그룹바이 절에 조건을 줄 때 사용
-- 각 부서의 직책별 평균 급여(평균 급여가 2000 이상인 그룹만 조회)
SELECT
	DEPTNO ,
	job,
	AVG(sal)
FROM
	EMP e
GROUP BY
	DEPTNO ,
	job
HAVING
	AVG(sal)>= 2000
ORDER BY
	DEPTNO,
	job ;
	
-- ORA-00934: 그룹 함수는 허가되지 않습니다
--SELECT
--	DEPTNO ,
--	job,
--	AVG(sal)
--FROM
--	EMP e
--WHERE
--	AVG(sal)>= 2000
--GROUP BY
--	DEPTNO ,
--	job
--ORDER BY
--	DEPTNO,
--	job ;


-- 부서별, 평균급여, 최고급여, 최저급여, 사원 수 출력
-- 평균급여 출력 시 소수점을 제외하고 출력
SELECT DEPTNO,FLOOR((AVG(SAL)),	MAKE_REF(SAL),MIN(SAL),
	COUNT(E.DEPTNO)
FROM EMP  
GROUP BY DEPTNO 
ORDER BY DEPTNO;

-- 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수 출력
SELECT
	e.job,
	COUNT(e.job)
FROM
	EMP e
GROUP BY
	job
HAVING
	count(job)>= 3;
	
-- 사원들의 입사년도를 기준으로 부서 별로 몇 명의 입사인원이 있는지 출력
-- 1987 20 2 (1987년도 20번 부서에 2명 입사)




-- JOIN(조인): 두 개 이상의 테이블을 연결하여 하나의 테이블처럼 출력
-- 내부조인
--	등가조인: 테이블 연결 후 출력 행을 각 테이블의 특정 열에 일치한 데이터를 기준으로 선정
--	비등가조인
-- 외부조인

SELECT
	*
FROM
	EMP,
	DEPT ;
	
-- 1) 내부 조인
-- 등가 조인 : EMP 테이블의 DEPTNO 와 DEPT 테이블의 DEPTNO가 일치 시 연결

-- 열의 정의가 애매합니다(조인 시)
SELECT
	e.EMPNO,
	e.ENAME,
	d.DEPTNO,
	d.DNAME,
	d.LOC
FROM
	EMP e,
	DEPT d
WHERE
	e.DEPTNO = d.DEPTNO ;