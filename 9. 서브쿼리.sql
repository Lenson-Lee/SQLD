

-- # 단일행 서브쿼리
-- 서브쿼리의 조회 결과가 1건 이하인 경우

-- 부서번호가 100004번인 부서의 모든 사원정보 조회
SELECT
 *
FROM tb_emp
WHERE dept_cd = '100004'
;

-- 이나라가 속해있는 부서의 모든 사원정보 조회
SELECT
 *
FROM tb_emp
WHERE dept_cd = (SELECT dept_cd FROM tb_emp WHERE emp_nm = '이나라')
;


-- 20200525에 받은 급여가 회사의 20200525일 전체 평균 급여보다 높은 사원들의 사원정보 조회

SELECT 
    A.emp_no, A.emp_nm
    , B.pay_de, B.pay_amt
FROM tb_emp A 
JOIN tb_sal_his B
ON A.emp_no = B.emp_no
WHERE B.pay_de = '20200525'
        AND B.pay_amt >= (
                                            SELECT 
                                                AVG(pay_amt)
                                            FROM tb_sal_his
                                            WHERE pay_de = '20200525'
                                        )
ORDER BY A.emp_no, B.pay_de
;


-- 회사 5월 급여평균
SELECT 
    AVG(pay_amt)
FROM tb_sal_his
WHERE pay_de = '20200525'
;



-- # 다중 행 서브쿼리 
-- 서브쿼리의 조회 건수가 여러 행인 것

-- 한국데이터베이스진흥원에서 발급한 자격증을 가지고 있는
-- 사원의 사원번호와 사원이름과 자격증 개수를 조회

SELECT * FROM tb_certi WHERE issue_insti_nm = '한국데이터베이스진흥원';


SELECT 
    A.emp_no, B.emp_nm, COUNT(A.certi_cd)
FROM tb_emp_certi A
JOIN tb_emp B
ON A.emp_no = B.emp_no
WHERE A.certi_cd IN (SELECT certi_cd FROM tb_certi WHERE issue_insti_nm = '한국데이터베이스진흥원')
GROUP BY A.emp_no, B.emp_nm
ORDER BY A.emp_no
;











