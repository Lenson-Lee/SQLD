-- # 실습 문제
-- 1. employees, departments테이블을 INNER JOIN해서
--    first_name, department_id, department_name을 조회하세요.
SELECT COUNT(*) FROM employees; --107명이 나오는데 조인하면 왜 106명일까?
SELECT employee_id, department_id FROM employees;   --보면 한 명이 부서가 없어서 조회가 안된다.

SELECT
    e.first_name, e.department_id, d.department_name   
FROM employees e, departments d
WHERE e.department_id = d.department_id;
--같은 글
SELECT
    e.first_name, e.department_id, d.department_name   
FROM employees e JOIN departments d
ON e.department_id = d.department_id;

-- 2. employees, departments테이블을 NATURAL JOIN해서
--    first_name, department_id, department_name을 조회하세요.
SELECT
    e.first_name, department_id, d.department_name
FROM employees e NATURAL JOIN departments d;


--32행이 나오네? manager_id가 겹쳐서 department_id와 manager 둘 다 일치하는 행만 나왔다 => using을 통해 
--이처럼 내추럴조인은 겹치는 컬럼에 따라서 내가 원하는 값이 나오지 않을 수도 있어서 잘 쓰지 않는게 좋다.
SELECT
    e.first_name, department_id, d.department_name
FROM employees e
JOIN departments d
USING (department_id, manager_id);

SELECT
    E.first_name, E.department_id, D.department_name
FROM employees E, departments D
WHERE E.department_id = D.department_id
    AND E.manager_id = D.manager_id;

--==USING
SELECT
    e.first_name, department_id, d.department_name
FROM employees e JOIN departments d USING(department_id);


-- 3. employees, departments테이블을 JOIN ON을 사용해서
--    first_name, department_id, department_name을 조회하세요.
SELECT
    e.first_name, d.department_id, d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;