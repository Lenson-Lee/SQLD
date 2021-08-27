-- 집합 연산자
-- ## UNION
-- 1. 합집합 연산의 의미입니다.
-- 2. 첫번째 쿼리와 두번째 쿼리의 중복정보는 한번만 보여줍니다.
-- 3. 첫번째 쿼리의 열의 개수와 타입이 두번째 쿼리의 열수와 타입과 동일해야 함.

-- join은 두 테이블을 좌우로 합치고 / 집합은 두 테이블을 (수직) 위 아래로 합친다. 그래서 열(가로 축)의 개수가 동일해야한다.
-- 이관심 씨가 두 번이 나온 이유는 사원번호가 달라서. 셋 다 같은 값이어야 두 개가 하나로 중복처리 된다.
-- 첫번째열로 자동으로 오름차  order by가 된다. 중복되는거 자동제거하고 정렬시킨다. => 성능상 부하가 있을 수밖에 없다.
--
SELECT emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION
SELECT emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231';

--사원번호가 없어 이관심 하나로 나온다.
SELECT emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION
SELECT emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231';


-- ## UNION ALL
-- 1. UNION과 같이 두 테이블로 수직으로 합쳐서 보여줍니다.
-- 2. UNION과는 달리 중복된 데이터도 한번 더 보여줍니다.
-- 3. 자동 정렬 기능을 지원하지 않아 성능상 유리합니다.


SELECT emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION ALL
SELECT emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231';

--중복제거가 되지 않는 부분이 union과 달라 시험에 잘나옴.
SELECT emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION ALL
SELECT emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231';


-- ## INTERSECT
-- 1. 첫번째 쿼리와 두번째 쿼리에서 중복된 행만을 출력합니다.
-- 2. 교집합의 의미입니다.

SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE C.certi_nm = 'SQLD'
INTERSECT   --교집합.
SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE A.addr LIKE '%용인%';

--intersect 안써도 이렇게 쓰면 더 간단해서 실무에선 intersect 잘 안쓴다. 교집합인 점만 알아두자.
SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE A.addr LIKE '%용인%'
    AND C.certi_nm = 'SQLD'
;

-- ## MINUS(EXCEPT) 
-- 1. 두번째 쿼리에는 없고 첫번째 쿼리에만 있는 데이터를 보여줍니다.
-- 2. 차집합의 개념입니다.

SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE dept_cd = '100001'
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE dept_cd = '100004'
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE sex_cd = '1'
;



-- 계층형 질의
SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "조직인원",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    A.direct_manager_emp_no,
    CONNECT_BY_ISLEAF
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
START WITH A.direct_manager_emp_no IS NULL
CONNECT BY PRIOR A.emp_no = A.direct_manager_emp_no;

SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "조직인원",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    a.direct_manager_emp_no
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
START WITH A.direct_manager_emp_no = '1000000037'
CONNECT BY A.emp_no = PRIOR A.direct_manager_emp_no;