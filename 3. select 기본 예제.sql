

--SELECT 기본(DELETE FROM과 달리 사이에 무언가 들어감.)
SELECT
    certi_cd, certi_nm
FROM TB_CERTI;

SELECT
    certi_nm
FROM TB_CERTI;

-- *은 모든 컬럼을 지칭한다.
SELECT
    *
FROM TB_CERTI;

--ALL은 기본적으로 생략. 써도 안써도 같다?
--DISTINCT: 중복값 제외
SELECT ALL
    issue_insti_nm
FROM TB_CERTI; 

SELECT DISTINCT
    issue_insti_nm
FROM TB_CERTI;

SELECT DISTINCT
    certi_nm, issue_insti_nm
FROM TB_CERTI;

--열 별칭 지정(ALIAS) 여기서는 쌍따옴표. AS는 생략이 가능.
--띄어쓰기없거나 영어로만 써져있으면 쌍따옴표도 생략 가능
SELECT
    certi_cd AS "자격증 코드"
    , certi_nm AS "자격증 이름"
    , issue_insti_nm "발행기관명"
 FROM tb_certi;
 
 
 --결합연산자(||)을 사용한 컬럼데이터 결합
 SELECT
    certi_nm || '(' || certi_cd || ') - ' || issue_insti_nm AS "자격증정보" 
 FROM tb_certi;
 
 --더미 테이블 (dual) : 단순 연산결과를 조회하고 싶을 때
 SELECT
    (3 + 7) * 5 / 10 AS "연산결과" 
 FROM dual;
 
 --WHERE조건문: 조회겨로가  행을 제한하는 조건절
 SELECT * FROM tb_emp;
 
 SELECT 
    emp_no,  emp_nm, addr
FROM tb_emp
WHERE sex_cd = 2;

--PK로 조건을 제한하면 무조건 단일행이 조회됩니다.
SELECT
    emp_no, emp_nm, tel_no
FROM tb_emp
WHERE emp_no = 1000000005;


--비교 연산자(-, <>, <,  =<. >, =>)
--  SQL 비교연산자 (BETWEEN, IN, LIKE)
SELECT
    emp_no, emp_nm, birth_de
FROM tb_emp
WHERE    birth_de >- '19900110' AND birth_de <='19991231';

--BETWEEN연산자(비교연산자 예문과 같은 결과값)
SELECT
    emp_no, emp_nm, birth_de
FROM tb_emp
WHERE    birth_de BETWEEN '19900110' AND '19991231';


--IN 연산자
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = '100004'
    OR dept_cd = '100006';
    
--in으로 쓰면 더 편하다
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd IN ('100004', '100006');


--LIKE 연산자
--와일드카드 매칭 - %: 1글자 이상 포함, _: 딱 1글자 포함

--이%로 시작하는
SELECT 
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '이%';

--%심으로 끝나는
SELECT 
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '%심';

--이__ 이ㅇㅇ인 애들
SELECT 
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '이__';

SELECT
    emp_nm, addr, tel_no
FROM tb_emp
WHERE addr LIKE '%수원%';       --WHERE addr = '수원'(x), 수원이 포함된 조건을 달아야 한다 -> LIKE

-- 성씨가 김씨이면서, 부서가 100003, 100004, 100006번 중에 하나이면서, 
-- 90년대생인 사원의 사번, 이름, 생일, 부서코드를 조회
SELECT
    emp_no, emp_nm, birth_de, dept_cd
FROM tb_emp
WHERE emp_nm LIKE '김__'
 AND dept_cd IN ('100003, 100004, 100006')
 AND birth_de BETWEEN '19900101' AND '19991231';


--NULL값 조회(is null로 써야 한다. = NULL 아님!!)
SELECT
    emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no IS NULL; --NULL은 IS NULL로만 비교.

-- NULL이 아닌 값 조회
SELECT
    emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no IS NOT NULL;


--부정 비교연산자
SELECT 
    emp_no, emp_nm, sex_cd, dept_cd
FROM tb_emp
WHERE emp_nm LIKE '이%' 
    AND sex_cd <> 1;    --AND sex_cd != 1도 되지만 보통 <> 자주 사용.