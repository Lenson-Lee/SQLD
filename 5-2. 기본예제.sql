-- 실습문제

-- 1. employees테이블에서 각 사원의 부서별 부서 번호(department_id)와 평균 급여(salary)를 조회하세요. 
SELECT
    NVL(department_id, 0) AS 부서번호
    , ROUND(AVG(salary), 2) AS avg
FROM employees
GROUP BY department_id
-- ORDER BY department_id; --오라클은 null을 가장 큰 값으로 본다. 여기서는 nvl을 통해 null을 0으로 바꿔서 맨 밑에 있다.
ORDER BY 부서번호;  --부서번호로 입력시 튜닝된 값으로 나와서 0이 맨 위.


-- 2. employees테이블에서 부서별 부서 번호(department_id)와 부서별 총 사원 수를 조회하세요.
SELECT
    NVL(department_id, 0) AS 부서번호
    , COUNT(employee_id) AS 사원수
FROM employees
GROUP BY department_id;


-- 3. employees테이블에서 부서의 급여 평균이 8000을 초과하는 부서의 부서번호와 급여 평균을 조회하세요.
SELECT
    department_id
    , ROUND(AVG(salary), 1) AS 평균
FROM employees
GROUP BY department_id  --이게 포인트! '부서'의 '평균'!! 통계를 낸 후 조건에 맞는 값 찾아야 한다. -> having으로 조건찾기
HAVING AVG(salary) > 8000
ORDER BY 평균;


-- 4. employees테이블에서 급여 평균이 8000을 초과하는 각 직무(job_id)에 대하여 
--    직무 이름(job_id)이 SA로 시작하는 사원은 제외하고 직무 이름과 급여 평균을 
--    급여 평균이 높은 순서로 정렬하여 조회하세요.
SELECT
    job_id
    , ROUND(AVG (salary), 1) AS 평균
FROM employees
WHERE job_id NOT LIKE 'SA%'
GROUP BY job_id
--평균 후에 8000 조건 찾아야 한다. => having
HAVING AVG (salary) > 8000
--ORDER BY 2 DESC 밑에와 같은 결과
ORDER BY 평균 DESC