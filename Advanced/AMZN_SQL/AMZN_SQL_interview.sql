-- Get the availabity of language of book is more than 50% of the whole availabity

DROP TABLE books
CREATE TABLE books
(
    BookName NVARCHAR(25),
    Lang NVARCHAR(25),
    -- Genre NVARCHAR(25)
)


INSERT INTO books
VALUES
('A', 'English'),
('A', 'French'),
('A', 'French'),
('B', 'English'),
('A', 'Mandrin'),
('B', 'Spanish'),
('C', 'English'),
('C', 'Mandrin')


-- distinct 
-- maybe expensive
WITH uniqLangTab AS(
    SELECT BookName, COUNT(distinct Lang) uniqLangPerBook,
    (
        SELECT COUNT(DISTINCT Lang) 
        FROM
        Books
    ) uniqTotLangPerAll
    FROM
    Books
    GROUP BY BookName
), ratio AS (
    SELECT BookName, uniqLangPerBook, uniqTotLangPerAll, CAST(uniqLangPerBook*1.00/uniqTotLangPerAll*1.00*100.00 AS Decimal(10, 2)) perc
    FROM
    uniqLangTab
)
SELECT *
FROM
ratio
WHERE perc >= 50



-- group by aggregation to get distinct values
WITH uniqTotLang AS(
    SELECT Lang
    FROM books
    group by Lang
), bookLang AS(
    SELECT 
    BookName,Lang
    FROM books
    group by BookName, Lang
), ratio AS(
    SELECT BookName, COUNT(*) uniqLang, 
    (
        SELECT 
        COUNT(*) 
        FROM 
        uniqTotLang
    ) UniqTot_Lang
    FROM 
    bookLang
    GROUP BY BookName
)
    SELECT bookName, uniqLang, UniqTot_Lang
    , CAST(uniqLang AS DECIMAL(10, 2))/CAST(UniqTot_Lang AS DECIMAL(10, 2))*100 over50
    -- , CAST(uniqLang/UniqTot_Lang AS DECIMAL(10, 2)) --*100 over50
    FROM
    ratio
    WHERE CAST(uniqLang AS DECIMAL(10, 2))/CAST(UniqTot_Lang AS DECIMAL(10, 2))*100 >= 50


