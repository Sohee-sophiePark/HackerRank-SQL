-- Given two tables write a sQL query to join these tables (Table1, Table2) 
-- get the output as finalTable


CREATE TABLE Table1
(
    Name Varchar(10),
    Value INT
)

CREATE TABLE Table2
(
    Name Varchar(10),
    Value INT
)

CREATE TABLE finTab
(
    Name Varchar(10),
    Value INT    
)

INSERT INTO Table1
VALUES 
('X', 1),
('X', 2),
("Y", 1)

INSERT INTO Table2
VALUES 
('X', 3),
('X', 4),
("Y", 2)

INSERT INTO finTab
VALUES 
('X', 3),
('X', 4),
('X', 5),
("Y", 2),
("Y", 3)


SELECT *
FROM Table1 t1
LEFT JOIN Table2 t2
ON t1.Name = t2.Name