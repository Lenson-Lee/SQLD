

--SELECT �⺻(DELETE FROM�� �޸� ���̿� ���� ��.)
SELECT
    certi_cd, certi_nm
FROM TB_CERTI;

SELECT
    certi_nm
FROM TB_CERTI;

-- *�� ��� �÷��� ��Ī�Ѵ�.
SELECT
    *
FROM TB_CERTI;

--ALL�� �⺻������ ����. �ᵵ �Ƚᵵ ����?
--DISTINCT: �ߺ��� ����
SELECT ALL
    issue_insti_nm
FROM TB_CERTI; 

SELECT DISTINCT
    issue_insti_nm
FROM TB_CERTI;

SELECT DISTINCT
    certi_nm, issue_insti_nm
FROM TB_CERTI;

--�� ��Ī ����(ALIAS) ���⼭�� �ֵ���ǥ. AS�� ������ ����.
--������ų� ����θ� ���������� �ֵ���ǥ�� ���� ����
SELECT
    certi_cd AS "�ڰ��� �ڵ�"
    , certi_nm AS "�ڰ��� �̸�"
    , issue_insti_nm "��������"
 FROM tb_certi;
 
 
 --���տ�����(||)�� ����� �÷������� ����
 SELECT
    certi_nm || '(' || certi_cd || ') - ' || issue_insti_nm AS "�ڰ�������" 
 FROM tb_certi;
 
 --���� ���̺� (dual) : �ܼ� �������� ��ȸ�ϰ� ���� ��
 SELECT
    (3 + 7) * 5 / 10 AS "������" 
 FROM dual;
 
 --WHERE���ǹ�: ��ȸ�ܷΰ�  ���� �����ϴ� ������
 SELECT * FROM tb_emp;
 
 SELECT 
    emp_no,  emp_nm, addr
FROM tb_emp
WHERE sex_cd = 2;

--PK�� ������ �����ϸ� ������ �������� ��ȸ�˴ϴ�.
SELECT
    emp_no, emp_nm, tel_no
FROM tb_emp
WHERE emp_no = 1000000005;


--�� ������(-, <>, <,  =<. >, =>)
--  SQL �񱳿����� (BETWEEN, IN, LIKE)
SELECT
    emp_no, emp_nm, birth_de
FROM tb_emp
WHERE    birth_de >- '19900110' AND birth_de <='19991231';

--BETWEEN������(�񱳿����� ������ ���� �����)
SELECT
    emp_no, emp_nm, birth_de
FROM tb_emp
WHERE    birth_de BETWEEN '19900110' AND '19991231';


--IN ������
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = '100004'
    OR dept_cd = '100006';
    
--in���� ���� �� ���ϴ�
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd IN ('100004', '100006');


--LIKE ������
--���ϵ�ī�� ��Ī - %: 1���� �̻� ����, _: �� 1���� ����

--��%�� �����ϴ�
SELECT 
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '��%';

--%������ ������
SELECT 
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '%��';

--��__ �̤����� �ֵ�
SELECT 
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '��__';

SELECT
    emp_nm, addr, tel_no
FROM tb_emp
WHERE addr LIKE '%����%';       --WHERE addr = '����'(x), ������ ���Ե� ������ �޾ƾ� �Ѵ� -> LIKE

-- ������ �达�̸鼭, �μ��� 100003, 100004, 100006�� �߿� �ϳ��̸鼭, 
-- 90������ ����� ���, �̸�, ����, �μ��ڵ带 ��ȸ
SELECT
    emp_no, emp_nm, birth_de, dept_cd
FROM tb_emp
WHERE emp_nm LIKE '��__'
 AND dept_cd IN ('100003, 100004, 100006')
 AND birth_de BETWEEN '19900101' AND '19991231';


--NULL�� ��ȸ(is null�� ��� �Ѵ�. = NULL �ƴ�!!)
SELECT
    emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no IS NULL; --NULL�� IS NULL�θ� ��.

-- NULL�� �ƴ� �� ��ȸ
SELECT
    emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no IS NOT NULL;


--���� �񱳿�����
SELECT 
    emp_no, emp_nm, sex_cd, dept_cd
FROM tb_emp
WHERE emp_nm LIKE '��%' 
    AND sex_cd <> 1;    --AND sex_cd != 1�� ������ ���� <> ���� ���.