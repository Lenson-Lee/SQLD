
-- OUTER JOIN 추가 예제
SELECT * FROM job_history ORDER BY employee_id;

-- 모든 사원의 정보를 조회할건데 혹시 직무변동 이력이 있으면 함께 조회하고 싶다

SELECT 
    E.employee_id, E.first_name, E.hire_date, E.job_id AS "current job"
    , J.start_date, J.end_date, J.job_id AS "last job"
FROM employees E 
JOIN job_history J
ON E.employee_id = J.employee_id
ORDER BY J.employee_id
;

SELECT 
    E.employee_id, E.first_name, E.hire_date, E.job_id AS "current job"
    , J.start_date, J.end_date, J.job_id AS "last job"
FROM employees E 
LEFT JOIN job_history J
ON E.employee_id = J.employee_id
ORDER BY J.employee_id
;

-- 실습문제 (JOIN)
-- 1. 사원번호가 103번인 사원의 이름(employee_name)과 매니저 이름(manager_name)을 출력하세요.
SELECT
    A.employee_id, A.first_name, A.manager_id, B.first_name AS "manager_name"
FROM employees A
JOIN employees B
ON A.manager_id = B.employee_id
WHERE A.employee_id = 103
ORDER BY A.employee_id;
-- 실제로 셀프조인은 SNS 데이터베이스 중 팔로잉, 팔로워 등에 사용된다.


-- 2. 모든 사원의 first_name과 department_name, 
--    street_address + ',' + city + ',' + state_province를 address라는 alias로 조회하세요.
-- employees, departments, locations 3개 조인
SELECT * FROM employees;    --부서 없는 애가 있는걸 확인할 수 있다.=>left join

SELECT
    E.first_name, D.department_name, D.location_id  --location_id도 널이 있음을 확인
    , L.street_address || ',' || L.city || ',' || L.state_province AS address
FROM employees E
LEFT JOIN departments D
ON E.department_id = D.department_id
LEFT JOIN locations L
ON D.location_id = L.location_id;

-- 3. 103번 사원의 first_name과 department_name, 
--    street_address + ',' + city + ',' + state_province를 address라는 alias로 
--    지정하여 조회하세요.
SELECT
    E.first_name, D.department_name, D.location_id
    , L.street_address || ',' || L.city || ',' || L.state_province AS address
FROM employees E
LEFT JOIN departments D
ON E.department_id = D.department_id
LEFT JOIN locations L
ON D.location_id = L.location_id

--위와 동일, 밑에 조건만 추가
WHERE E.employee_id = 103;


-- 4. 부서 이름이 IT로 시작하는 사원의 first_name과 department_name, 
--    street_address + ',' + city + ',' + state_province를 address라는 alias로 
--    지정하여 조회하세요.
SELECT
    E.first_name, D.department_name, D.location_id
    , L.street_address || ',' || L.city || ',' || L.state_province AS address
FROM employees E
LEFT JOIN departments D
ON E.department_id = D.department_id
LEFT JOIN locations L
ON D.location_id = L.location_id
WHERE D.department_name LIKE 'IT%';

-- 5. jobs테이블에서 모든 직무 id(job_id)와 직무명(job_title)을 조회하는데 
--    만약 직무변동 이력이 있다면 해당 이력 정보 
-- (start_date, end_date, job_id, employee_id, first_name, department_id, department_name)
--    도 함께 조회하세요.
SELECT * FROM jobs;

SELECT
    J.job_id, J.job_title
    , H.start_date, H.end_date, H.job_id, H.employee_id
    , E.first_name, E.department_id
FROM jobs J
LEFT JOIN job_history H
ON J.job_id = H.job_id
LEFT JOIN employees E--(job id)직무가 계속 보여야하니까 leftjoin 유지
ON H.employee_id = E.employee_id
LEFT JOIN departments D
ON E.department_id = D.department_id
;