WITH temp AS (
SELECT
-- *
ResellerName
, ProductLine
, OrderFrequency
, ROW_NUMBER() OVER (PARTITION BY ProductLine ORDER BY AnnualRevenue) rowNum
-- row_number() generate unique number
FROM dbo.DimReseller
)
SELECT *
FROM temp
WHERE rowNum = 2