CREATE TABLE substrings (
    "id" INTEGER,
    "substring" TEXT NOT NULL,
    PRIMARY KEY("id")
);


INSERT INTO substrings (substring)
SELECT SUBSTR(sentence, 98, 4) FROM sentences WHERE id = 14;

INSERT INTO substrings (substring)
SELECT SUBSTR(sentence, 3, 5) FROM sentences WHERE id = 114;

INSERT INTO substrings (substring)
SELECT SUBSTR(sentence, 72, 9) FROM sentences WHERE id = 618;

INSERT INTO substrings (substring)
SELECT SUBSTR(sentence, 7, 3) FROM sentences WHERE id = 630;

INSERT INTO substrings (substring)
SELECT SUBSTR(sentence, 12, 5) FROM sentences WHERE id = 932;

INSERT INTO substrings (substring)
SELECT SUBSTR(sentence, 50, 7) FROM sentences WHERE id = 2230;

INSERT INTO substrings (substring)
SELECT SUBSTR(sentence, 44, 10) FROM sentences WHERE id = 2346;

INSERT INTO substrings (substring)
SELECT SUBSTR(sentence, 14, 5) FROM sentences WHERE id = 3041;


CREATE VIEW "message" AS
    SELECT substring AS "phrase" FROM substrings;
