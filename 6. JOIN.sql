

-- 조인 기초
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp;

SELECT
    dept_cd, dept_nm
FROM tb_dept;   --이렇게 두 개의 테이블을 두 번 조회하지 않고 한번에 나타낼 수 있는 법 : join

--===========
--2개의 테이블 조인
SELECT
    --출처를 알리기 위해 셀렉트 앞에 출처.테이블명 식으로 적음
    --tb_emp.emp_no 이렇게 원본을 쓰면 너무 복잡해보임.
    E.emp_no
    , E.emp_nm
    , E.dept_cd
    , D.dept_nm
FROM tb_emp E, tb_dept D   --별칭 E, D(보통 귀찮아서 한글자로 정함)을 통해 SELECT절을 간편하게 작성 가능
WHERE E.dept_cd = D.dept_cd --join 조건 원하는 값만을 출력하도록. 없으면 join시에 모든 경우의 테이블을 읽는다(카테시안곱)
;

--자격증 정보 테이블
SELECT * FROM tb_certi;

--사원이 취득한 자격증 정보 테이블
SELECT * FROM tb_emp_certi; --tb_emp의 이름과 같이 보고싶다면?

SELECT
    E.emp_no, E.emp_nm,
    EC.certi_cd, EC.acqu_de
FROM tb_emp E, tb_emp_certi EC
WHERE E.emp_no = EC.emp_no  --어디에 매칭되는 정보만 필요한지, 조인 조건 꼭 걸어야한다.
;

SELECT
    c.certi_cd, c.certi_nm, c.issue_insti_nm
    , ec.acqu_de, ec.emp_no
FROM tb_certi C, tb_emp_certi EC
WHERE C.certi_cd = EC.certi_cd;

--3개 테이블 조인
SELECT
    a.emp_no, a.emp_nm, b.certi_cd, b.certi_nm, c.acqu_de
FROM tb_emp A, tb_certi B, tb_emp_certi C
WHERE A.emp_no = C.emp_no
    AND B.certi_cd = C.certi_cd
;
    
SELECT
    a.emp_no, a.emp_nm, b.certi_cd, b.certi_nm, c.acqu_de
FROM tb_emp A, tb_certi B, tb_emp_certi C
WHERE A.emp_no = C.emp_no
    AND B.certi_cd = C.certi_cd
    AND A.emp_nm LIKE '이%'
    AND C.acqu_de BETWEEN '20190101' AND '20191231'
ORDER BY C.acqu_de;


CREATE TABLE TEST_A(
    id NUMBER(10) PRIMARY KEY
    , content VARCHAR2(200)
);

CREATE TABLE TEST_B(
    b_id NUMBER(10) PRIMARY KEY
    , reply VARCHAR2(100)
    , a_id NUMBER(10)
);

INSERT INTO TEST_A VALUES (1,'aaa');
INSERT INTO TEST_A VALUES (2,'bbb');
INSERT INTO TEST_A VALUES (3,'ccc');

INSERT INTO TEST_B VALUES(1, 'ㄱㄱㄱ',1);
INSERT INTO TEST_B VALUES(2, 'ㄴㄴㄴ',1);
INSERT INTO TEST_B VALUES(3, 'ㄷㄷㄷ',2);
INSERT INTO TEST_B VALUES(4, 'ㄹㄹㄹ',3);
COMMIT;

SELECT*FROM TEST_A;
SELECT*FROM TEST_B;

SELECT
    A.id, A.content, B.b_id, B.reply
FROM TEST_A A, TEST_B B
WHERE A.id = B.a_id;



--# INNER JOIN
--1. 2개 이상의 테이블이 공통된 컬럼에 의해 논리적으로 결합되는 조인기법이다.
--2. WHERE절에 사용된 컬럼들이 동등연산자(=)에 의해 조인된다.

SELECT
    E.emp_no, E.emp_nm, E.addr, E.dept_cd, D.dept_nm
FROM tb_emp E, tb_dept D   --별칭으로 써도 똑같다.
WHERE E.dept_cd = D.dept_cd
    AND addr LIKE '%용인%'
ORDER BY E.emp_no;

--join 할 때 select * 하면 똑같은 값이 겹쳐서 나오는등 하니까 where로 꼭 필요한 값만 부르기


-- # NATURAL JOIN
-- 1. NATURAL JOIN은 동일한 이름을 갖는 컬럼들에 대해 자동 조인하는 기법입니다.
-- 2. 즉, 자동으로 2개 이상의 테이블에서 같은 이름을 가진 컬럼을 찾아 INNER조인을 수행합니다.
-- 3. 이 때 조인되는 동일 이름의 컬럼은 데이터 타입이 같아야 하며, ALIAS나 테이블명을 붙일 수 없습니다.
        --vachar(2)면 둘 다 vachar(2)여야 한다.
-- 4. SELECT * 문법을 사용하면, 공통 컬럼으로 자동 조인하며 결과집합에서 한번만 표기됩니다.

SELECT
    E.emp_no, E.emp_nm, E.addr, dept_cd, D.dept_nm
FROM tb_emp E NATURAL JOIN tb_dept D    --두 테이블에 자동적으로 같은 이름의 컬럼을 합쳐준다.=> dept_cd는 식별자 필요없음
;
SELECT
    *
FROM tb_emp E NATURAL JOIN tb_dept D;

--간편한건 NATURAL JOIN이지만 지금은 테이블 두 개를 가지고 해서 괜찮지만 컬럼명이 다를 때는 별칭 필요해서 곤란?


-- # USING절 조인
-- 1. NATURAL조인에서는 자동으로 이름이 일치하는 모든 컬럼에 대해 조인이
--    일어나지만 USING을 사용하면 원하는 컬럼에 대해서만 선택적으로 조인이 가능합니다.
-- 2. USING절에서도 조인 컬럼에 대해 ALIAS나 테이블명을 붙일 수 없습니다.

SELECT
    E.emp_no, E.emp_nm, E.addr, dept_cd, D.dept_nm
FROM tb_emp E JOIN tb_dept D USING (dept_cd);
-- 참조하는게 두 개 이상 겹칠땐 (aa, bb)라고 쓰면 된다. 조건은 컬럼명이 서로 같아야한다.


-- # JOIN ON절
-- 1. 조인 조건 서술부(ON절)와 일반 조건 서술부(WHERE절)를 분리해서 작성하는 방법입니다.
-- 2. ON절을 사용하면 JOIN이후에 논리 연산이나 서브쿼리와 같은 추가 서술을 할 수 있습니다.

--innerjoin과 같지만 생김새만 다르다.
SELECT 
    A.emp_no, A.emp_nm, D.dept_nm, B.acqu_de, B.certi_cd, C.certi_nm
FROM tb_emp A, tb_emp_certi B, tb_certi C, tb_dept D
WHERE A.emp_no = B.emp_no
    AND B.certi_cd = C.certi_cd
    AND A.dept_cd = D.dept_cd;

--==다른방법?
SELECT 
    A.emp_no, A.emp_nm, D.dept_nm, B.acqu_de, B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C
ON B.certi_cd = C.certi_cd
JOIN tb_dept D
ON A.dept_cd = D.dept_cd;


SELECT 
    E.emp_no, E.emp_nm, E.addr, E.dept_cd, D.dept_nm
FROM tb_emp E
JOIN tb_dept D
ON E.dept_cd = D.dept_cd
--조인 조건은 from 과where 사이에 쓴다.
WHERE addr LIKE '%용인%'
ORDER BY E.emp_no

--중요하다. 작성순서
-- SELECT [DISTINCT] { 열이름 .... } 
-- FROM  테이블 또는 뷰 이름
-- JOIN  테이블 또는 뷰 이름
-- ON    조인 조건
-- WHERE 조회 조건
-- GROUP BY  열을 그룹화 / -- HAVING    그룹화 조건
-- ORDER BY  정렬할 열 [ASC | DESC];

