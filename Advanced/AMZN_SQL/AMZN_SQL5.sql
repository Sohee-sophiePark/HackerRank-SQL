-- ORDER_TBL has four columns namely 
-- ORDER_DAY, ORDER_ID, PRODUCT_ID, QUANTITY, PRICE

DROP TABLE ORDER_TBL
GO
CREATE TABLE ORDER_TBL
(
    ORDER_DAY DATE,
    ORDER_ID NVARCHAR(25),
    PRODUCT_ID NVARCHAR(25),
    QUANTITY INT,
    PRICE INT
)

INSERT INTO ORDER_TBL
VALUES
('2015-05-01', 'ODR1', 'PROD1', 5, 5),
('2015-05-01', 'ODR2', 'PROD2', 2, 10),
('2015-05-01', 'ODR3', 'PROD3', 10, 25),
('2015-05-01', 'ODR4', 'PROD1', 20, 5),
('2015-05-02', 'ODR5', 'PROD3', 5, 25),
('2015-05-02', 'ODR6', 'PROD4', 6, 20),
('2015-05-02', 'ODR7', 'PROD1', 2, 5),
('2015-05-02', 'ODR8', 'PROD5', 1, 50),
('2015-05-02', 'ODR9', 'PROD6', 2, 50),
('2015-05-02', 'ODR10', 'PROD2', 4, 10)


--Q1. Write a SQL Query to get all products that got sold on both the days 
-- and the number of TIMES the product is sold ** careful which amount is asked
-- get the products sold on both days
WITH totalQTYTab AS (
    SELECT PRODUCT_ID, ORDER_DAY uniqOrderDay, COUNT(ORDER_ID) totalOrder
    FROM
    ORDER_TBL
    GROUP BY PRODUCT_ID, ORDER_DAY
)
SELECT PRODUCT_ID, SUM(totalOrder)
FROM
totalQTYTab
GROUP BY PRODUCT_ID
HAVING COUNT(uniqOrderDay) > 1 

-- Distinct
SELECT PRODUCT_ID, COUNT(ORDER_ID), COUNT(DISTINCT ORDER_DAY) uniqDay
FROM ORDER_TBL
GROUP BY PRODUCT_ID 
HAVING COUNT(DISTINCT ORDER_DAY) > 1


--Q2. Write a SQL Query to get products that was ordered 
-- on 02-May-2015 but not on 01-May-2015
WITH countDayPerProd AS
(
    SELECT PRODUCT_ID, ORDER_DAY
    FROM ORDER_TBL
    -- WHERE ORDER_DAY IN ('2015-05-01', '2015-05-02') -- currnet scenario not necessary
    GROUP BY PRODUCT_ID, ORDER_DAY    
), prodSoldOnSignleDay AS
(
    SELECT PRODUCT_ID
    FROM
    countDayPerProd
    GROUP BY PRODUCT_ID
    HAVING COUNT(*) = 1
)
SELECT 
*
FROM
countDayPerProd c
INNER JOIN prodSoldOnSignleDay p
on c.PRODUCT_ID = p.PRODUCT_ID
where order_day = '2015-05-02'



--Q3. 