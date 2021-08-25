

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
WHERE A.id = B.a_id