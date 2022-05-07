-- Q2. Given below table Emp as Input which has two columns 'Group' and 'Sequence',
--  Write a SQL query to find the maximum and minimum values of continuous 'Sequence' in each 'Group'

DROP TABLE tab
GO
CREATE TABLE tab(
    GroupName NVARCHAR(20),
    seq INT
)


INSERT INTO tab
VALUES
('A', 1),
('A', 2),
('A', 3),
('A', 5),
('A', 6),
('A', 8),
('A', 9),
('B', 11),
('C', 1),
('C', 2),
('C', 3)
GO

-- get seq group by getting the difference between row_number()
WITH seqGroupTab AS(
    select GroupName 
    , seq 
    , seq-ROW_NUMBER() OVER (PARTITION BY GroupName ORDER BY seq) seqGrp
    , ROW_NUMBER() OVER (ORDER BY GroupName) rowNum
FROM tab
)
SELECT GroupName,  MIN(seq) minSeq, MAX(seq) maxSeq
FROM
seqGroupTab
GROUP BY GroupName, seqGrp
ORDER BY GroupName, seqGrp




WITH tempTab AS(
    SELECT GroupName, seq, ROW_NUMBER() OVER (PARTITION BY GroupName ORDER BY seq) rowNum
    FROM tab
),
minusTab AS(
    SELECT GroupName, seq, rowNum, seq - rowNum as seqGroup 
    FROM tempTab
), 
seqGroupTab AS(
    SELECT GroupName, seqGroup,  min(seq) minSeq, max(seq) maxSeq
    FROM minusTab
    GROUP BY GroupName, seqGroup
)
SELECT GroupName, minSeq, maxSeq
FROM seqGroupTab
ORDER BY GroupName


-- Can be implemented with subquery
SELECT GroupName, min(seq), max(Seq)
FROM
(
    SELECT 
    groupName, seq, 
    ROW_NUMBER() OVER (PARTITION BY GroupName ORDER BY seq) as groupRnk,
    seq-ROW_NUMBER() OVER (PARTITION BY GroupName ORDER BY seq) as groupedSeq
    FROM tab
) as sub
GROUP BY groupName, groupedSeq
ORDER BY groupName



