-- Emp_Details Table has four columns EmpID, Gender, EmailId and DeptID.
-- User has to write a SQL query to derive another column called
-- Email_List to display all EmailId concatenated with semicolon associated
-- with a each Dept_Id as shown below in output Table

DROP TABLE Emp_Details 
CREATE TABLE Emp_Details 
(
    EmpID INT,
    Gender CHAR(1),
    EmailID NVARCHAR(25),
    DeptID INT
)

INSERT INTO Emp_Details
VALUES
(1001, 'M', 'YYYYY@gmaix.com', 104),
(1002, 'M', 'ZZZ@gmaix.com', 103),
(1003, 'F', 'AAAAA@gmaix.com', 102),
(1004, 'F', 'PP@gmaix.com', 104),
(1005, 'M', 'CCCC@yahu.com', 101),
(1006, 'M', 'DDDDD@yahu.com', 100),
(1007, 'F', 'E@yahu.com', 102),
(1008, 'M', 'M@yahu.com', 102),
(1009, 'F', 'SS@yahu.com', 100)


--STRING_AGG
SELECT DeptID, STRING_AGG(EmailID, ';') Email_List 
FROM
Emp_Details
GROUP BY
DeptID


-- STRING_AGG
-- WITHIN GROUP (ORDER BY)
SELECT DeptID, STRING_AGG(EmailID, ';') WITHIN GROUP (ORDER BY EmailID) Email_List 
FROM
Emp_Details
GROUP BY
DeptID
