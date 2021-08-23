-- sqld 2-1강 40p
-- # 문자열 비교

-- CHAR타입끼리의 비교
DROP TABLE CHAR_COMPARE;
CREATE TABLE CHAR_COMPARE (
    sn CHAR(10),
    char_4 CHAR(4),
    char_6 CHAR(6)
);

INSERT INTO char_compare VALUES ('101', 'SQLD', 'SQLD');
INSERT INTO char_compare VALUES ('102', 'SQLD', 'SQLA');

COMMIT;

SELECT * FROM char_compare;

SELECT 
    --(선택한것의 ''(공백)을 '+'로 바꾸기
    REPLACE(char_4, ' ', '+') AS char_4,
    REPLACE(char_6, ' ', '+') AS char_6
FROM char_compare;

SELECT 
    REPLACE(char_4, ' ', '+') AS char_4,
    REPLACE(char_6, ' ', '+') AS char_6
FROM char_compare
WHERE sn = '101'
    AND char_4 = char_6
;

SELECT 
    REPLACE(char_4, ' ', '+') AS char_4,
    REPLACE(char_6, ' ', '+') AS char_6
FROM char_compare
WHERE sn = '102'
    AND char_4 > char_6
;

SELECT * FROM char_compare;

-- 한쪽이 VARCHAR타입일 경우의 비교
DROP TABLE VARCHAR_COMPARE;
CREATE TABLE VARCHAR_COMPARE (
    sn CHAR(10),
    char_4 CHAR(4),
    varchar_6 VARCHAR2(6)
);

INSERT INTO varchar_compare VALUES ('101', 'SQLD', 'SQLD  ');
INSERT INTO varchar_compare VALUES ('102', 'SQLD', 'SQLA  ');--의도적으로 공백'  '이 있는걸 알 수 있음
COMMIT;

SELECT * FROM varchar_compare;

SELECT 
    REPLACE(char_4, ' ', '+') AS char_4,
    REPLACE(varchar_6, ' ', '+') AS varchar_6
FROM varchar_compare
WHERE sn = '101'
    AND char_4 = varchar_6 --조건에 맞지 않아서 표가 나오지 않음
    --> var char는 공백의 유무에 따라 값이 달라지고 char는 공백 상관없이 값만 본다.
;

-- 상수문자열과의 비교
-- 
SELECT 
    REPLACE(char_4, ' ', '+') AS char_4,
    REPLACE(varchar_6, ' ', '+') AS varchar_6
FROM varchar_compare
WHERE sn = '101'
    AND char_4 = 'SQLD    ' -- char타입이라 공백을 무시함.
;

SELECT 
    REPLACE(char_4, ' ', '+') AS char_4,
    REPLACE(varchar_6, ' ', '+') AS varchar_6
FROM varchar_compare
WHERE sn = '101'
    AND varchar_6 = 'SQLD' 
;

-- ==============================================

-- # 단일행 함수
-- ## 문자열 함수
SELECT 
    LOWER('Hello WORLD'),  -- 전부 소문자로 변환
    UPPER('hello World'),  -- 전부 대문자로 변환
    INITCAP('abcdef')      -- 첫글자만 대문자로 나머지는 소문자로 변환
FROM dual;

SELECT
    ASCII('A'), -- 문자를 아스키코드로
    CHR(65)     -- 아스키코드를 문자로
FROM dual;

SELECT 
    CONCAT('SQL', 'Developer'),   -- 문자열을 결합
    SUBSTR('SQL Developer', 3, 3), -- 문자열 자름 3번부터 3개자름 (코딩과 달리 첫글자가 1번!!) 공백이 포함된다.
    LENGTH('HELLO WORLD'),         -- 문자열의 길이
    TRIM('    HI   ')              -- 좌우 공백 제거
FROM dual;

SELECT 
    RPAD('Steve', 10, '-'), -- 오른쪽에 주어진 문자를 채움
    LPAD('Steve  ', 10, '*'),  -- 왼쪽에 주어진 문자를 채움
    --REPLACE('Java Programmer', 'Java', 'BigData') AS "REPLACE" -- 문자를 변경(원본,제거할 것, 변경할 것)
    REPLACE('Java Programmer', 'Java')AS "REPLACE" -- 문자를 제거
FROM dual;

-- ## 숫자형 함수
SELECT 
    MOD(27, 5) AS MOD, -- 나머지 값 반환
    CEIL(38.678) AS ceil, -- 올림값 반환
    FLOOR(38.678) AS floor, -- 내림값 반환
    ROUND(38.678, 2) AS round, -- 자리수까지 반올림
    TRUNC(38.678, 2) AS trunc  -- 자리수 이하를 절삭
    , ABS(-20) AS abs -- 절대값(-,+ 없는 정수만 있다)
    , SIGN(50) AS sign -- 0보다 작으면 -1, 0보다 크면 1, 0이면 0
FROM dual;

-- ## 날짜형 함수

-- 현재 날짜를 조회
SELECT SYSDATE
FROM dual;

SELECT SYSTIMESTAMP -- 시간도 적힘
FROM dual;

-- 날짜 연산
-- 날짜 + 숫자 = 날짜  => 일(DAY) 수를 날짜에 더함
-- 날짜 - 숫자 = 날짜  => 날짜에서 일 수를 뺌
-- 날짜 - 날짜 = 일수  => 어떤 날짜에서 다른 날짜를 뺀 일수
-- 날짜 + 숫자/24 = 날짜  => 날짜에 시간을 더함

SELECT 
    SYSDATE AS "현재 시간",
    SYSDATE - 1 AS "SYSDATE - 1",
    (SYSDATE + 10) - SYSDATE AS "날짜 - 날짜", 
    SYSDATE - (1/24) AS "1시간 차감", -- 하루 24시간의 1 -> 1시간 1/24 (4/24를 1/6로 약분하면 가독성이 떨어진다 그냥 쓰기)
    SYSDATE - (1/24/60) * 100 AS "100분 차감", --(24분의 1(한시간) / 60 = 1분 --> 1분 * 100 = 100분
    SYSDATE - (1/24/60/60) * 30 AS "30초 차감"
FROM dual;


-- ## 변환 함수
SELECT * FROM char_compare
WHERE sn = 101;

-- 날짜를 문자로 변환 (TO_CHAR함수)
-- 날짜 포맷형식: Y - 연도, MM - 두자리 월, D - 일수
-- 시간 포맷형식: HH12 - 시(1~12), HH24 (0-23), MI - 분, SS - 초
SELECT
    SYSDATE,
    TO_CHAR(SYSDATE, 'MM - DD') AS "월 - 일",
    TO_CHAR(SYSDATE, 'YYYY/MM/DD') AS "연/월/일",
    TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일"') AS "날짜 - 한글포함",
    TO_CHAR(SYSDATE + (1/24) * 6, 'YY/MM/DD HH24:MI:SS') AS "날짜와 시간",
    TO_CHAR(SYSDATE, 'YY/MM/DD AM HH12:MI:SS') AS "날짜와 시간2"
FROM dual;

-- 숫자를 문자로 변환
-- 숫자 포맷 형식 -  $: 달러표시, L: 지역화폐기호
SELECT
    TO_CHAR(9512 * 1.33, '$999,999.99') AS "달러",
    TO_CHAR(1350000, '999,999,999L') AS "원화"
FROM dual;

-- 문자를 숫자로 변환
SELECT 
    TO_NUMBER('$5,500', '$999,999') - 4000 AS "계산결과"
FROM dual;


-- CASE표현과 DECODE함수
SELECT 
    sal_cd, sal_nm,
    CASE WHEN sal_cd = '100001' THEN '기본급여'
         WHEN sal_cd = '100002' THEN '보너스급여'
         ELSE '기타'
         END sal_name   --조건식
FROM tb_sal;

SELECT
    sal_cd,
    DECODE(sal_cd, '100001', '기본급여', '100002', '보너스급여', '기타') AS sal_name --case 압축
FROM tb_sal;

-- # 널 관련 함수
-- NVL(expr1, expr2)
-- expr1: Null을 가질 수 있는 값이나 표현식
-- expr2: expr1이 Null일 경우 대체할 값
SELECT 
    emp_no,
    emp_nm,
    NVL(direct_manager_emp_no, '최상위관리자') AS 관리자
FROM tb_emp;

SELECT 
    --MAX(emp_nm), --MAX는 공집합을 뱉은다..?
    NVL(MAX(emp_nm), '존재안함') AS emp_nm
FROM tb_emp
WHERE emp_nm = '박찬호';

-- NVL2(expr1, expr2, expr3)
-- expr1의 값이 Null이 아니면 expr2를 반환, Null이면 expr3를 반환
SELECT 
    emp_nm,
    NVL2(direct_manager_emp_no, '일반사원', '널,회장님') AS 직위
FROM tb_emp;

-- NULLIF(expr1, expr2)
-- 두 값이 같으면 NULL리턴, 다르면 expr1 리턴
SELECT
    NULLIF('박찬호', '박찬호')
FROM dual;

SELECT
    NULLIF('박찬호', '박지성')
FROM dual;

-- COALESCE(expr1, ...)
-- 많은 표현식 중 Null이 아닌 값이 최초로 발견되면 해당 값을 리턴
SELECT 
    COALESCE(NULL, NULL, 3000, 4000)
FROM dual;

SELECT 
    COALESCE(NULL, 5000, NULL, 2000)
FROM dual;

SELECT 
    COALESCE(7000, NULL, NULL, 8000)
FROM dual;