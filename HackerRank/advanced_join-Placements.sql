/*
You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name. Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). Packages contains two columns: ID and Salary (offered salary in $ thousands per month).



Write a query to output the names of those students whose best friends got offered a higher salary than them. Names must be ordered by the salary amount offered to the best friends. It is guaranteed that no two students got same salary offer.

Sample Input



Sample Output

Samantha
Julia
Scarlet

Explanation

See the following table:



Now,

Samantha's best friend got offered a higher salary than her at 11.55
Julia's best friend got offered a higher salary than her at 12.12
Scarlet's best friend got offered a higher salary than her at 15.2
Ashley's best friend did NOT get offered a higher salary than her
The name output, when ordered by the salary offered to their friends, will be:

Samantha
Julia
Scarlet

*/

/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/

-- three tables 
--  Students, Friends and Packages
-- Students: ID / Name
-- Friends: ID / Friend_ID (only Best)
-- Packages: ID / Salary ($thousand per Month)
-- whose best frineds got offered a hight salary than them

with bfTab as (
    select s.ID ID, s.Name Name
    , f.Friend_ID fID, stu.Name fName
    from Students s
    left join Friends f
    on s.ID = f.ID
    left join Students stu
    on f.Friend_ID = stu.ID
), salTab as (
    select b.ID, b.Name, fID, fName, p.salary salary, fp.salary fSalary 
    from bfTab b
    left join Packages p
    on b.id = p.id 
    left join Packages fp
    on b.fID = fp.ID
)
select Name
from salTab
where salary < fSalary
order by fSalary
