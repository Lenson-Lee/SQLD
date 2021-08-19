

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

--데이터 수정
UPDATE BOARD
SET writer = '수정된 철수'
WHERE bno = 2;  

UPDATE BOARD
SET CONTENT = '수정된 내용 벱벱'
WHERE bno = 2;

UPDATE BOARD
SET TITLE = '수정된 제목이야'
    , CONTENT = '수정수정수정'
WHERE bno = 1;

--UPDATE절에서 WHERE가 생략되면 전체수정되므로 주의

UPDATE BOARD
SET CONTENT = '메롱';

--데이터 삭제
DELETE FROM BOARD
WHERE bno = 2;

ROLLBACK;


COMMIT;

INSERT INTO BOARD
    (BNO, TITLE, CONTENT, WRITER, REG_DATE)
VALUES
    (4, '임시테스트', '메롱', '빅테스트', SYSDATE);
    
SELECT * FROM BOARD

--최종커밋 시점으로 이동.
ROLLBACK;

INSERT INTO BOARD
    (BNO, TITLE, CONTENT, WRITER, REG_DATE)
VALUES
    (5, '임시테스트', '메롱', '빅테스트', SYSDATE);
INSERT INTO BOARD
    (BNO, TITLE, CONTENT, WRITER, REG_DATE)
VALUES
    (6, '임시테스트', '메롱', '빅테스트', SYSDATE);
INSERT INTO BOARD
    (BNO, TITLE, CONTENT, WRITER, REG_DATE)
VALUES
    (7, '임시테스트', '메롱', '빅테스트', SYSDATE);


--전체 데이터 삭제
--WHERE절을 생략한 DELETE절 (ROLLBACK가능)
DELETE FROM BOARD;

SELECT * FROM BOARD;
--커밋 이전 시점으로 롤백. 커밋하면 롤백 불가.
ROLLBACK;

COMMIT;

--2. TRUNCATE TABLE을 사용한 방법 (ROLLBACK 불가능/ 테이블 구조는 삭제되지 않음)
--휴지통 비우기같은 개념 실무에서 사용 금지
TRUNCATE TABLE BOARD;

--3. DROP TABLE (ROLLBACK 불가능 / 테이블 구조도 삭제)
--실무에서 사용 금지
DROP TABLE BOARD;