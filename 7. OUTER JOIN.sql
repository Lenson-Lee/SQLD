-- OUTER JOIN 실습환경 세팅
INSERT INTO tb_dept VALUES ('100014', '4차산업혁명팀', '999999');
INSERT INTO tb_dept VALUES ('100015', '포스트코로나팀', '999999');
COMMIT;

SELECT * FROM tb_dept;

ALTER TABLE tb_emp DROP CONSTRAINT fk_tb_emp01;

INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
                    final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000041', '이순신', '19811201', '1', '경기도 용인시 수지구 죽전1동 435', '010-5656-7878',
        NULL, '006', '003', '114-554-223433', '000000', 'N');

INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
                    final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000042', '정약용', '19820402', '1', '경기도 고양시 덕양구 화정동 231', '010-4054-6547',
        NULL, '004', '001', '110-223-553453', '000000', 'Y');

INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
                    final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000043', '박지원', '19850611', '1', '경기도 수원시 팔달구 매탄동 553', '010-1254-1116',
        NULL, '004', '001', '100-233-664234', '000000', 'N');
        
INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
            final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000044', '장보고', '19870102', '1', '경기도 성남시 분당구 정자동 776', '010-1215-8784',
        NULL, '004', '002', '180-345-556634', '000000', 'Y');
        
INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
            final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000045', '김종서', '19880824', '1', '경기도 고양시 일산서구 백석동 474', '010-3687-1245',
        NULL, '004', '002', '325-344-45345', '000000', 'Y');
        
COMMIT;
    
 
SELECT * FROM tb_emp ORDER BY emp_no DESC;
SELECT emp_no, emp_nm, dept_cd FROM tb_emp ORDER BY emp_no DESC;
-- dept_cd가 0000인 사람들은 매칭이 되지 않아서 innerjoin에서 제외되버렸다. => outer join


SELECT * FROM tb_dept;

-- # OUTER JOIN
-- 1. 조인 조건을 만족하지 않는 행들도 조회할 때 사용하는 조인기법입니다.
-- 2. OUTER조인 연산자 기호는 (+)기호입니다.
-- 3. INNER조인은 조인 조건을 만족하지 않으면 해당 행을 조회하지 않습니다
--   그러나 OUTER JOIN은 방향(LEFT, RIGHT, FULL)에 맞게 조건에 매칭되지 
--   않는 행들도 모두 NULL로 처리해서 조회합니다.

-- # LEFT OUTER JOIN
-- 조인되는 왼쪽 테이블은 모두 조회하고, 오른쪽 테이블은 조인조건에 매칭된 것만 조회합니다.

-- # RIGHT OUTER JOIN
-- 조인되는 오른쪽 테이블은 모두 조회하고, 왼쪽 테이블은 조인조건에 매칭된 것만 조회합니다.

-- 나는 사원정보는 일단 다 보고 싶은데 혹시 부서테이블에서 부서코드가 매칭되면
-- 보너스로 부서이름도 찍어줘라

SELECT
    A.emp_no, A.emp_nm, A.dept_cd, B.dept_nm
FROM tb_emp A, tb_dept B    --LEFT= tb_emp, RIGHT= tb_dept(보너스느낌으로.)    (+)가 붙지 않은 쪽은 다 보여준다.
WHERE A.dept_cd = B.dept_cd(+);

--JOIN ON!
SELECT
    A.emp_no, A.emp_nm, A.dept_cd, B.dept_nm
FROM tb_emp A JOIN tb_dept B    
ON A.dept_cd = B.dept_cd(+);

--(+)가 헷갈려서 싫다면!
SELECT
    A.emp_no, A.emp_nm, A.dept_cd, B.dept_nm
FROM tb_emp A 
LEFT OUTER JOIN tb_dept B    --왼쪽은 전부 다 내보내고 오른쪽은 그냥 조인처럼?
ON A.dept_cd = B.dept_cd;
--OUTER는 생략 가능.
SELECT
    A.emp_no, A.emp_nm, A.dept_cd, B.dept_nm
FROM tb_emp A 
LEFT JOIN tb_dept B    --왼쪽은 전부 다 내보내고 오른쪽은 그냥 조인처럼?
ON A.dept_cd = B.dept_cd;


--RIGHT OUTER JOIN
SELECT
    A.emp_no, A.emp_nm, A.dept_cd, B.dept_nm
FROM tb_emp A, tb_dept B    
WHERE A.dept_cd(+) = B.dept_cd; --dept_cd를 A테이블꺼를 불러와서 널이다. b로 바꾸면 뜬다.

SELECT
    A.emp_no, A.emp_nm, A.dept_cd, B.dept_nm
FROM tb_emp A
JOIN tb_dept B    
ON A.dept_cd(+) = B.dept_cd;

SELECT
    A.emp_no, A.emp_nm, A.dept_cd, B.dept_nm
FROM tb_emp A
RIGHT JOIN tb_dept B    
ON A.dept_cd = B.dept_cd;


--FULL OUTER JOIN(FULL JOIN)
SELECT
    A.emp_no, A.emp_nm, A.dept_cd, B.dept_nm
FROM tb_emp A
FULL JOIN tb_dept B    
ON A.dept_cd = B.dept_cd;


--SELF JOIN
--1. 자기 자신의 테이블을 조인하는 개념.
--2. 자기 테이블의 컬럼들을 매칭하여 조회하는 기법.

--다이렉트매니저넘버와 사원 넘버가 동일하면 '상사정보'로 가져오기
--테이블을 보면 김회장의 사원번호가 이경오의 상사번호로 이경오의 상사가 김회장이 된다.

SELECT
    A.emp_no, A.emp_nm, A.direct_manager_emp_no
    , B.emp_nm AS 상사정보
FROM tb_emp A, tb_emp B --하나는 자기자신, 하나는 조인할 대상의 정보라고 생각하기
WHERE A.direct_manager_emp_no = B.emp_no;



DELETE FROM tb_dept WHERE dept_cd IN ('100014', '100015');

DELETE FROM tb_emp WHERE emp_no IN ('1000000041', '1000000042', '1000000043', '1000000044', '1000000045');

COMMIT;

ALTER TABLE tb_emp 
ADD CONSTRAINT fk_tb_emp01 
FOREIGN KEY (dept_cd) 
REFERENCES tb_dept (dept_cd);