/* INNER JOIN */

-- 1. 부서위치(LOCATION_ID)가 1700인 부서에 근무하는 사원들의 EMPLOYEE_ID, LAST_NAME, DEPARTMENT_NAME을 조회하시오.
-- DEPARTMENTS 테이블 : LOCATION_ID, DEPARTMENT_NAME
-- EMPLOYEES   테이블 : EMPLOYEE_ID, LAST_NAME

SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_NAME
  FROM DEPARTMENTS D INNER JOIN EMPLOYEES E     -- 1대다 관계로 부모가 앞에 자식이 뒤로
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID   -- 조인 조건 (기본키 먼저, 외래키 나중)
 WHERE D.LOCATION_ID = 1700;              -- 일반 조건
    
SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_NAME
  FROM DEPARTMENTS D , EMPLOYEES E    
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID   -- 조인 조건
   AND D.LOCATION_ID = 1700;              -- 일반 조건
 
    
-- 2. 부서명이 'Executive'인 부서에 근무하는 사원들의 EMPLOYEE_ID, LAST_NAME, DEPARTMENT_NAME을 조회하시오.

SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_NAME
  FROM DEPARTMENTS D INNER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID    -- 조인 조건
 WHERE D.DEPARTMENT_NAME = 'Executive';     -- 일반 조건

SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_NAME
  FROM DEPARTMENTS D, EMPLOYEES E
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID    -- 조인 조건
   AND D.DEPARTMENT_NAME = 'Executive';     -- 일반 조건
    

-- 3. 직업아이디(JOB_ID)가 변하지 않은 사원들의 EMPLOYEE_ID, LAST_NAME, JOB_ID를 조회하시오.
--    현재 JOB_ID(EMPLOYEES)와 과거 JOB_ID(JOB_HISTORY)가 일치하는 사원을 조회하시오.

SELECT E.EMPLOYEE_ID, E.LAST_NAME, JH.JOB_ID
  FROM EMPLOYEES E INNER JOIN JOB_HISTORY JH
    ON E.EMPLOYEE_ID = JH.EMPLOYEE_ID   -- 조인 조건
 WHERE E.JOB_ID = JH.JOB_ID;     -- 일반조건(현재 JOB_ID(EMPLOYEES)와 과거 JOB_ID(JOB_HISTORY)가 일치)
   
SELECT E.EMPLOYEE_ID, E.LAST_NAME, JH.JOB_ID
  FROM EMPLOYEES E, JOB_HISTORY JH
 WHERE E.EMPLOYEE_ID = JH.EMPLOYEE_ID   -- 조인 조건
   AND E.JOB_ID = JH.JOB_ID;     -- 일반조건(현재 JOB_ID(EMPLOYEES)와 과거 JOB_ID(JOB_HISTORY)가 일치)


-- 4. 부서별로 사원수와 평균연봉을 DEPARTMENT_NAME과 함께 조회하시오.
--    평균연봉은 정수로 절사하고, 사원수의 오름차순 정렬하시오.

SELECT D.DEPARTMENT_NAME AS 부서명, COUNT(*) AS 사원수, TRUNC(AVG(E.SALARY)) AS 평균연봉
  FROM DEPARTMENTS D INNER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID    -- 조인조건
 GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME
 ORDER BY 사원수;

SELECT D.DEPARTMENT_NAME AS 부서명, COUNT(*) AS 사원수, TRUNC(AVG(E.SALARY)) AS 평균연봉
  FROM DEPARTMENTS D, EMPLOYEES E
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID    -- 조인조건
 GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME
 ORDER BY 사원수;


-- 5. CITY가 'S'로 시작하는 지역에 근무하는 사원들의 EMPLOYEE_ID, LAST_NAME, DEPARTMENT_NAME, CITY를 조회하시오.
--    EMPLOYEE_ID의 오름차순 정렬로 조회하시오.
-- DEPARTMENTS 테이블 : DEPARTMENT_NAME
-- EMPLOYEES   테이블 : EMPLOYEE_ID, LAST_NAME
-- LOCATIONS   테이블 : CITY

-- 관계를 앞부터 작성 (앞/뒤 어디부터 시작해도 상관없다.)
SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
  FROM DEPARTMENTS D INNER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID INNER JOIN LOCATIONS L
    ON L.LOCATION_ID = D.LOCATION_ID
 WHERE L.CITY LIKE 'S%'
 ORDER BY E.EMPLOYEE_ID;

SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
  FROM LOCATIONS L, DEPARTMENTS D, EMPLOYEES E
 WHERE L.LOCATION_ID = D.LOCATION_ID
   AND D.DEPARTMENT_ID = E.DEPARTMENT_ID
   AND L.CITY LIKE 'S%'
 ORDER BY E.EMPLOYEE_ID;
 

-- 6. 모든 사원들의 EMPLOYEE_ID, LAST_NAME, DEPARTMENT_NAME, CITY, COUNTRY_NAME을 조회하시오.
--    단, DEPARTMENT_ID가 없는 사원은 조회하지 마시오.

-- 관계를 뒤부터 작성 (앞/뒤 어디부터 시작해도 상관없다.)
SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY, C.COUNTRY_NAME
  FROM COUNTRIES C INNER JOIN LOCATIONS L
    ON C.COUNTRY_ID = L.COUNTRY_ID INNER JOIN DEPARTMENTS D
    ON L.LOCATION_ID = D.LOCATION_ID INNER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;  -- 조인조건(조인조건은 NULL이 제외된 상태로 처리)

SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY, C.COUNTRY_NAME
  FROM COUNTRIES C, LOCATIONS L, DEPARTMENTS D, EMPLOYEES E
 WHERE C.COUNTRY_ID = L.COUNTRY_ID
   AND L.LOCATION_ID = D.LOCATION_ID
   AND D.DEPARTMENT_ID = E.DEPARTMENT_ID;  -- 조인조건(조인조건은 NULL이 제외된 상태로 처리)
 

/* OUTER JOIN */

-- 7. 모든 사원들의 EMPLOYEE_ID, LAST_NAME, DEPARTMENT_NAME을 조회하시오.
--    부서번호(DEPARTMENT_ID)가 없는 사원도 조회하고, EMPLOYEE_ID순으로 오름차순 정렬하시오.
--    부서번호(DEPARTMENT_ID)가 없는 사원의 부서명(DEPARTMENT_NAME)은 'None'으로 조회하시오.

-- 부서                사원
-- 일치하는정보포함     모든정보포함

-- 오른쪽에 있는 사원 테이블의 모든 정보 포함을 위해 오른쪽 외부 조인

SELECT E.EMPLOYEE_ID, E.LAST_NAME, NVL(DEPARTMENT_NAME, 'None')
  FROM DEPARTMENTS D RIGHT OUTER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
 WHERE 
 GROUP BY EMPLOYEE_ID
 ORDER BY EMPLOYEE_ID;

-- 8. 부서별 근무하는 사원수를 조회하시오.
--    단, 근무하는 사원이 없으면 0으로 조회하시오.




/* SELF JOIN */

-- 9. MANAGER보다 먼저 입사한 사원들의 EMPLOYEE_ID, LAST_NAME, HIRE_DATE과 MANAGER의 HIRE_DATE를 조회하시오.
--    사원의 HIRE_DATE가 MANAGER의 HIRE_DATE보다 작은 사원을 조회하시오. (MANAGER보다 먼저 입사한 사원)


-- 10. 같은 부서의 사원들 중에서 나보다 늦게 입사하였으나 연봉을 더 많이 받는 사원이 있는 사원들의
--     DEPARTMENT_ID, LAST_NAME, SALARY, HIRE_DATE와 높은 연봉을 받는 사원의 LAST_NAME, SALARY, HIRE_DATE를 조회하시오.