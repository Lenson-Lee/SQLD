-- # �ǽ� ����
-- 1. employees, departments���̺��� INNER JOIN�ؼ�
--    first_name, department_id, department_name�� ��ȸ�ϼ���.
SELECT COUNT(*) FROM employees; --107���� �����µ� �����ϸ� �� 106���ϱ�?
SELECT employee_id, department_id FROM employees;   --���� �� ���� �μ��� ��� ��ȸ�� �ȵȴ�.

SELECT
    e.first_name, e.department_id, d.department_name   
FROM employees e, departments d
WHERE e.department_id = d.department_id;
--���� ��
SELECT
    e.first_name, e.department_id, d.department_name   
FROM employees e JOIN departments d
ON e.department_id = d.department_id;

-- 2. employees, departments���̺��� NATURAL JOIN�ؼ�
--    first_name, department_id, department_name�� ��ȸ�ϼ���.
SELECT
    e.first_name, department_id, d.department_name
FROM employees e NATURAL JOIN departments d;


--32���� ������? manager_id�� ���ļ� department_id�� manager �� �� ��ġ�ϴ� �ุ ���Դ� => using�� ���� 
--��ó�� ���߷������� ��ġ�� �÷��� ���� ���� ���ϴ� ���� ������ ���� ���� �־ �� ���� �ʴ°� ����.
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


-- 3. employees, departments���̺��� JOIN ON�� ����ؼ�
--    first_name, department_id, department_name�� ��ȸ�ϼ���.
SELECT
    e.first_name, d.department_id, d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;