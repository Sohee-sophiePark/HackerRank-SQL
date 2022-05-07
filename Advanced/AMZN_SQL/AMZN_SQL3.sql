-- Problem Statement
-- Student Table has three columns Student_Name, Total_Marks and Year. 
-- User has to write a SQL query to display Studnet_Name, Totla_Marks,
-- Year, Prev_Yr_Marks for those whose Total_Marks are greater than 
-- or equal to the previous year

DROP TABLE Student
GO
CREATE TABLE Student(
    Student_Name NVARCHAR(25),
    Total_Marks INT,
    Year INT
)

INSERT INTO Student
VALUES
('Rahul', 90, 2010),
('Sanjay', 80, 2010),
('Mohan', 70, 2010),
('Rahul', 90, 2011),
('Sanjay', 85, 2011),
('Mohan', 65, 2011),
('Rahul', 80, 2012),
('Sanjay', 80, 2012),
('Mohan', 90, 2012)


-- ROW_NUMBER
WITH stuYear AS (
    SELECT  *, ROW_NUMBER() OVER (PARTITION BY Student_Name ORDER BY Year) Stu_Year
    FROM
    Student
) 
SELECT sy1.Student_Name
, sy2.[Year] sy2Year
, sy2.Total_Marks sy2TotMarks
, sy1.[Year] sy1Year
, sy1.Total_Marks sy1TotMarks
, sy2.Total_Marks-sy1.Total_Marks diffTotMarks
FROM stuYear sy1
INNER JOIN stuYear sy2
ON sy1.Student_Name = sy2.Student_Name
AND sy2.Stu_Year - sy1.Stu_Year = 1
AND sy2.Total_Marks >= sy1.Total_Marks
ORDER BY sy1.Total_Marks DESC


-- LAG
WITH lagTab AS(
    SELECT *, LAG(Total_Marks) OVER (PARTITION BY Student_Name ORDER BY Year) PreYr_Marks
    FROM 
    Student
)
SELECT *
FROM lagTab
where Total_Marks - PreYr_Marks >= 0 
