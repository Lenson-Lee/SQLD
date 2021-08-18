

--DML : 데이터 조작어
-- SELECT, INSERT, UPDATE, DELETE



-- 데이터 삽입
INSERT INTO BOARD
    (BNO, TITLE, CONTENT, WRITER, REG_DATE)
VALUES
    (1, '안녕', '재밌는 내용입니다.', '마이콜', SYSDATE);

-- NOT NULL 제약조건에 걸림(TITLE)
INSERT INTO BOARD
    (BNO, CONTENT, WRITER, REG_DATE)
VALUES
    (2, '재밌는 내용입니다.','마이콜', SYSDATE);
    
--PK 제약조건으로 글번호 중복
INSERT INTO BOARD
    (BNO, TITLE, WRITER, REG_DATE)
VALUES
    (1, '새로운 글이야','도우너', SYSDATE);
    
INSERT INTO BOARD
    (BNO, TITLE, WRITER, REG_DATE)
VALUES
    (2, '새로운 글이야','도우너', SYSDATE);
    
--테이블의 모든 컬럼을 순서대로 채울 경우 컬럼지정을 생략 가능
INSERT INTO BOARD
VALUES
    (3, '3번글','글내용벱벱','둘리', SYSDATE);
    
SELECT * FROM BOARD;

--세이브기능
COMMIT;
