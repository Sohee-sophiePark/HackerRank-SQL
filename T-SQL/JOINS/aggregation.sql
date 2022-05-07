-- Q5. Write a SQL Query to print the department-wise employee with Second highest Salary.
-- Write using rang and without rank function

DROP TABLE Dept
CREATE TABLE Dept(
    DepId INT NOT NULL PRIMARY KEY,
    DepName NVARCHAR(20)
)

DROP TABLE Emp
CREATE TABLE Emp(
    EmpId INT NOT NULL PRIMARY KEY,
    EMPName NVARCHAR(50),
    DepID INT,
    Salary FLOAT
)



INSERT INTO Dept
VALUES 
(1, 'HR'),
(2, 'Tech'),
(3, 'Operations')



INSERT INTO Emp
VALUES
(1, 'Emp1', 3, 100),
(2, 'Emp2', 2, 500),
(3, 'Emp3', 3, 200),
(4, 'Emp4', 1, 450),
(5, 'Emp5', 2, 400),
(6, 'Emp6', 1, 500),
(7, 'Emp7', 2, 300)


WITH secSalEmp(DepName, EMPName, rank) AS
(
    SELECT DepName, EMPName, RANK() OVER (PARTITION BY e.DepID ORDER BY Salary Desc) rank
    FROM Emp e
    INNER JOIN Dept d
    ON d.DepId = e.DepID
)
SELECT DepName, EMPName, rank
FROM secSalEmp
where rank = 2