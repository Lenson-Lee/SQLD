-- �ǽ�����

-- 1. employees���̺��� �� ����� �μ��� �μ� ��ȣ(department_id)�� ��� �޿�(salary)�� ��ȸ�ϼ���. 
SELECT
    NVL(department_id, 0) AS �μ���ȣ
    , ROUND(AVG(salary), 2) AS avg
FROM employees
GROUP BY department_id
-- ORDER BY department_id; --����Ŭ�� null�� ���� ū ������ ����. ���⼭�� nvl�� ���� null�� 0���� �ٲ㼭 �� �ؿ� �ִ�.
ORDER BY �μ���ȣ;  --�μ���ȣ�� �Է½� Ʃ�׵� ������ ���ͼ� 0�� �� ��.


-- 2. employees���̺��� �μ��� �μ� ��ȣ(department_id)�� �μ��� �� ��� ���� ��ȸ�ϼ���.
SELECT
    NVL(department_id, 0) AS �μ���ȣ
    , COUNT(employee_id) AS �����
FROM employees
GROUP BY department_id;


-- 3. employees���̺��� �μ��� �޿� ����� 8000�� �ʰ��ϴ� �μ��� �μ���ȣ�� �޿� ����� ��ȸ�ϼ���.
SELECT
    department_id
    , ROUND(AVG(salary), 1) AS ���
FROM employees
GROUP BY department_id  --�̰� ����Ʈ! '�μ�'�� '���'!! ��踦 �� �� ���ǿ� �´� �� ã�ƾ� �Ѵ�. -> having���� ����ã��
HAVING AVG(salary) > 8000
ORDER BY ���;


-- 4. employees���̺��� �޿� ����� 8000�� �ʰ��ϴ� �� ����(job_id)�� ���Ͽ� 
--    ���� �̸�(job_id)�� SA�� �����ϴ� ����� �����ϰ� ���� �̸��� �޿� ����� 
--    �޿� ����� ���� ������ �����Ͽ� ��ȸ�ϼ���.
SELECT
    job_id
    , ROUND(AVG (salary), 1) AS ���
FROM employees
WHERE job_id NOT LIKE 'SA%'
GROUP BY job_id
--��� �Ŀ� 8000 ���� ã�ƾ� �Ѵ�. => having
HAVING AVG (salary) > 8000
--ORDER BY 2 DESC �ؿ��� ���� ���
ORDER BY ��� DESC