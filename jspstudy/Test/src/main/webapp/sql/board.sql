DROP SEQUENCE BOARD_SEQ;
CREATE SEQUENCE BOARD_SEQ NOCACHE;

DROP TABLE BOARD;
CREATE TABLE BOARD(
    BOARD_NO NUMBER           NOT NULL,
    WRITER VARCHAR2(20 BYTE)    NOT NULL,
    TITLE VARCHAR2(20 BYTE),
    CONTENT VARCHAR(100 BYTE),
    CREATE_DATE DATE,
    CONSTRAINT PK_BOARD PRIMARY KEY(BOARD_NO)
);