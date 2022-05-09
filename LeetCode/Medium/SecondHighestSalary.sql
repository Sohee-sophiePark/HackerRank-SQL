/*
Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key column for this table.
Each row of this table contains information about the salary of an employee.
 
Write an SQL query to report the second highest salary from the Employee table.
If there is no second highest salary, the query should report null.
The query result format is in the following example.


Example 1:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| null                |
+---------------------+

*/

SELECT top(1) e.salary SecondHighestSalary 
FROM
(
SELECT salary , DENSE_RANK() OVER (ORDER BY Salary desc) rnk
FROM 
EMployee 
) e
RIGHT JOIN 
(SELECT 1 as rnk UNION ALL SELECT 2) r
ON e.rnk = r.rnk
where r.rnk = 2


/*
Success
Details 
Runtime: 656 ms, faster than 76.34% of MS SQL Server online submissions for Second Highest Salary.
Memory Usage: 0B, less than 100.00% of MS SQL Server online submissions for Second Highest Salary.
Next challenges:
*/