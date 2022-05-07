-- Problem Statement
/*
Transaction_tbl Table has F columns CustID, TranID, TranAmt, and TranDate.
User has to display all these fields along with maximum TransAmt 
for each CustID and ratio of TransAmt and maximum TransAmt for each transaction.
*/

-- 1. get maximum amount of transaction Amount to each Customer
-- 2. get each ratio to max tras amount to each customer

DROP Table Transaction_tbl
CREATE TABLE Transaction_tbl(
    CustID INT,
    TransID INT,
    TranAmt DECIMAL(18, 2),
    TransDate DATE
)

INSERT INTO Transaction_tbl
VALUES
(1001, 20001, 10000, '2020-04-25'),
(1001, 20002, 15000, '2020-04-25'),
(1001, 20003, 80000, '2020-04-25'),
(1001, 28004, 20000, '2020-04-25'),
(1002, 30001, 7000, '2020-04-25'),
(1002, 30002, 15000, '2020-04-25'),
(1002, 30003, 22000, '2020-04-25')

-- 1. Using Window Function
-- Get the max value group by custID
-- get the propertion of each transaction amount over it
-- single select when using window function
SELECT CustID
, TransID
, CAST(TranAmt/max(TranAmt) OVER (PARTITION BY CustID) as Decimal(10, 3)), TranAmt, max(TranAmt) OVER (PARTITION BY CustID) maxAmount
FROM
Transaction_tbl 

-- 2. Using SubQuery
-- subquery to get max
-- inner join on custId
-- get ratio
SELECT tr.CustID, tr.TranAmt, mx.maxAmt, CAST(tr.TranAmt/mx.maxAmt AS DECIMAL(10, 2)) ratio
FROM Transaction_tbl tr
INNER JOIN
(
    SELECT CustId, MAX(TranAmt) maxAmt
    FROM Transaction_tbl
    GROUP BY CustID
) mx 
ON tr.CustID = mx.CustID

-- 3. Using CTE
WITH maxTran AS
(
    SELECT CustID, MAX(TranAmt) maxAmt
    FROM Transaction_tbl
    GROUP BY CustID
)
SELECT t.CustID, t.TranAmt, m.maxAmt, CAST(t.TranAmt/m.maxAmt AS DECIMAL(10, 2))
FROM maxTran m INNER JOIN Transaction_tbl t
ON m.CustID = t.CustID 

