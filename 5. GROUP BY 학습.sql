

-- # GROUP BY, HAVING
-- 1. 집계함수
SELECT
    COUNT(emp_no) AS "총 사원수"
    , MAX(birth_de) AS "가장 어린 사람" --1999 vs 1920 일 때 맥스가 어리기 때문.
    , MIN(birth_de) AS "가장 나이 많은 사람"
FROM tb_emp;


SELECT
    COUNT(*), -- * 하면 null도 같이 세지만, COUNT(특정대상) 시에는 NULL제외하고 센다.
    COUNT(direct_manager_emp_no) --김회장이 null이라 빼고 셌다.
FROM tb_emp;


--2. GROUP BY: 테이블 내에서 그룹화 할 때
-- ex) 부서별로 가장 어린사람의 생년월일, 가장 나이많은 사람의 생년월일, 부서별 직원 수를 알고 싶음
SELECT emp_nm, birth_de, dept_cd
FROM tb_emp
ORDER BY dept_cd; --ORDER BY(정렬) : ASC- 오름차(기본값) // DESC(내림차)

SELECT
    dept_cd
    , COUNT(*) AS "부서별 직원 수"
    , MAX(birth_de) AS "부서 막내"
    , MIN(birth_de) AS "부서 연장자"
FROM tb_emp
GROUP BY dept_cd
ORDER BY dept_cd;


--HAVING절: 그룹화된 결과에서 조건을 걸어 행 수를 제한
--HAVING은 보통GROUP BY 앞/뒤에 쓴다.
--HAVING은 그룹화 한 후에 / WHERE은 그룹화 하기 전에. 나중에 자세히.
SELECT
    dept_cd
    , COUNT(*) AS "부서별 직원 수"
    , MAX(birth_de) AS "부서 막내"
    , MIN(birth_de) AS "부서 연장자"
FROM tb_emp
GROUP BY dept_cd
HAVING COUNT(*) >= 2 -- 2개 이상인 것만
ORDER BY dept_cd;


-- '사원별로'(=group) 급여를 제일 많이 받은 액수, 제일 적게 받은 액수, 평균액수 조회
SELECT * FROM tb_sal_his
ORDER BY emp_no, pay_de; --emp_no로 정렬한 후 같은 값들끼리는 pay_de로 재정렬

SELECT
    emp_no
    , MAX(pay_amt) AS "최고 수령액"
    , MIN(pay_amt) AS "최저 수령액"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999,99') AS "평균 수령액"
FROM tb_sal_his
GROUP BY emp_no
ORDER BY emp_no;


--평균 급여가 470 이상인 사원만 조회하고 싶음. 그 밑에는 관심없음 -> 그룹화 '이후'에 정해야한다. => having
SELECT
    emp_no
    , MAX(pay_amt) AS "최고 수령액"
    , MIN(pay_amt) AS "최저 수령액"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999,99') AS "평균 수령액"
FROM tb_sal_his
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no;


-- 2019년 1년간 평균 급여가 450 이상인 사원만 조회하고 싶음.
-- 통계내기 전(그룹화 하기 전)에 해야하는 조건 -> where절로 조건.
SELECT
    emp_no
    , MAX(pay_amt) AS "최고 수령액"
    , MIN(pay_amt) AS "최저 수령액"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999,99') AS "평균 수령액"
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no;


-- 2019년 1년간 사원별 연봉을 추가 조회
SELECT
    emp_no
    , MAX(pay_amt) AS "최고 수령액"
    , MIN(pay_amt) AS "최저 수령액"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999,99') AS "평균 수령액"
     , TO_CHAR(ROUND(SUM(pay_amt)), 'L999,999,999,99') AS "연봉"
   -- , ROUND(AVG(pay_amt)) * 12 AS "총 수령액"
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no;



-- 정렬 ORDER BY
-- ASC : 오름차순(기본값) // DESC: 내림차순
-- **항상 select절의 맨 마지막 줄에 위치해야 한다**
SELECT emp_no, emp_nm, addr
FROM tb_emp
ORDER BY emp_no DESC;

-- 오름차로 한다면?
SELECT emp_no, emp_nm, addr
FROM tb_emp
ORDER BY emp_no;


--이름 내림차순 (홍, 최, 이...김)
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
ORDER BY eno DESC; --컬럼명 enp_nm대신 별칭 eno사용 가능