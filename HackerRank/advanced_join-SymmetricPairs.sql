/*
You are given a table, Functions, containing two columns: X and Y.


Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.

Write a query to output all such symmetric pairs in ascending order by the value of X. List the rows such that X1 ≤ Y1.

Sample Input


Sample Output

20 20
20 21
22 23

*/

/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/


WITH sameXY AS(
select * from Functions
where x = y
), sameSymXY AS (
select *
    from sameXY
    group by x, y
    having count(*) > 1
), symXY AS (
    select f1.x, f1.y 
    from Functions f1
    inner join Functions f2
    on f1.x = f2.y and f1.y = f2.x 
    where f1.x <= f1.y and f1.x <> f1.y
), finTab as (
select * from sameSymXY
union all
select * from symXY
)
select * from
finTab
order by x



