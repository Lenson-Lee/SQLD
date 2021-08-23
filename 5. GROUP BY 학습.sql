

-- # GROUP BY, HAVING
-- 1. �����Լ�
SELECT
    COUNT(emp_no) AS "�� �����"
    , MAX(birth_de) AS "���� � ���" --1999 vs 1920 �� �� �ƽ��� ��� ����.
    , MIN(birth_de) AS "���� ���� ���� ���"
FROM tb_emp;


SELECT
    COUNT(*), -- * �ϸ� null�� ���� ������, COUNT(Ư�����) �ÿ��� NULL�����ϰ� ����.
    COUNT(direct_manager_emp_no) --��ȸ���� null�̶� ���� �ô�.
FROM tb_emp;


--2. GROUP BY: ���̺� ������ �׷�ȭ �� ��
-- ex) �μ����� ���� ������ �������, ���� ���̸��� ����� �������, �μ��� ���� ���� �˰� ����
SELECT emp_nm, birth_de, dept_cd
FROM tb_emp
ORDER BY dept_cd; --ORDER BY(����) : ASC- ������(�⺻��) // DESC(������)

SELECT
    dept_cd
    , COUNT(*) AS "�μ��� ���� ��"
    , MAX(birth_de) AS "�μ� ����"
    , MIN(birth_de) AS "�μ� ������"
FROM tb_emp
GROUP BY dept_cd
ORDER BY dept_cd;


--HAVING��: �׷�ȭ�� ������� ������ �ɾ� �� ���� ����
--HAVING�� ����GROUP BY ��/�ڿ� ����.
--HAVING�� �׷�ȭ �� �Ŀ� / WHERE�� �׷�ȭ �ϱ� ����. ���߿� �ڼ���.
SELECT
    dept_cd
    , COUNT(*) AS "�μ��� ���� ��"
    , MAX(birth_de) AS "�μ� ����"
    , MIN(birth_de) AS "�μ� ������"
FROM tb_emp
GROUP BY dept_cd
HAVING COUNT(*) >= 2 -- 2�� �̻��� �͸�
ORDER BY dept_cd;


-- '�������'(=group) �޿��� ���� ���� ���� �׼�, ���� ���� ���� �׼�, ��վ׼� ��ȸ
SELECT * FROM tb_sal_his
ORDER BY emp_no, pay_de; --emp_no�� ������ �� ���� ���鳢���� pay_de�� ������

SELECT
    emp_no
    , MAX(pay_amt) AS "�ְ� ���ɾ�"
    , MIN(pay_amt) AS "���� ���ɾ�"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999,99') AS "��� ���ɾ�"
FROM tb_sal_his
GROUP BY emp_no
ORDER BY emp_no;


--��� �޿��� 470 �̻��� ����� ��ȸ�ϰ� ����. �� �ؿ��� ���ɾ��� -> �׷�ȭ '����'�� ���ؾ��Ѵ�. => having
SELECT
    emp_no
    , MAX(pay_amt) AS "�ְ� ���ɾ�"
    , MIN(pay_amt) AS "���� ���ɾ�"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999,99') AS "��� ���ɾ�"
FROM tb_sal_his
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no;


-- 2019�� 1�Ⱓ ��� �޿��� 450 �̻��� ����� ��ȸ�ϰ� ����.
-- ��賻�� ��(�׷�ȭ �ϱ� ��)�� �ؾ��ϴ� ���� -> where���� ����.
SELECT
    emp_no
    , MAX(pay_amt) AS "�ְ� ���ɾ�"
    , MIN(pay_amt) AS "���� ���ɾ�"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999,99') AS "��� ���ɾ�"
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no;


-- 2019�� 1�Ⱓ ����� ������ �߰� ��ȸ
SELECT
    emp_no
    , MAX(pay_amt) AS "�ְ� ���ɾ�"
    , MIN(pay_amt) AS "���� ���ɾ�"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999,99') AS "��� ���ɾ�"
     , TO_CHAR(ROUND(SUM(pay_amt)), 'L999,999,999,99') AS "����"
   -- , ROUND(AVG(pay_amt)) * 12 AS "�� ���ɾ�"
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no;



-- ���� ORDER BY
-- ASC : ��������(�⺻��) // DESC: ��������
-- **�׻� select���� �� ������ �ٿ� ��ġ�ؾ� �Ѵ�**
SELECT emp_no, emp_nm, addr
FROM tb_emp
ORDER BY emp_no DESC;

-- �������� �Ѵٸ�?
SELECT emp_no, emp_nm, addr
FROM tb_emp
ORDER BY emp_no;


--�̸� �������� (ȫ, ��, ��...��)
SELECT emp_no, emp_nm, addr
FROM tb_emp
ORDER BY 2 DESC;


SELECT emp_no, emp_nm, addr
FROM tb_emp
ORDER BY emp_nm DESC, emp_nm;

SELECT emp_no, emp_nm, addr
FROM tb_emp
ORDER BY emp_no DESC, emp_nm DESC;

SELECT emp_no, emp_nm, addr
FROM tb_emp
ORDER BY 2 DESC, 1 DESC;

SELECT
    emp_no AS eno
    , emp_nm AS enm
    , addr
FROM tb_emp
ORDER BY eno DESC; --�÷��� enp_nm��� ��Ī eno��� ����