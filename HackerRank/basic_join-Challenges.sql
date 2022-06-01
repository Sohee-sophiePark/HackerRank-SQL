/*
Julia asked her students to create some coding challenges. Write a query to print the hacker_id, name, and the total number of challenges created by each student. Sort your results by the total number of challenges in descending order. If more than one student created the same number of challenges, then sort the result by hacker_id. If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.

Input Format

The following tables contain challenge data:

Hackers: The hacker_id is the id of the hacker, and name is the name of the hacker. 

Challenges: The challenge_id is the id of the challenge, and hacker_id is the id of the student who created the challenge. 
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/
-- hacker_id / name / total number of challenges by each student
-- select  hacker_id, challenge_id, count(*) from challenges
-- group by hacker_id, challenge_id 
-- sort by total number of challenges descending order -> hacekr id ascending 

-- get the count per hacker_id

-- 1. get count of challenges by hacker
WITH countTab AS (
    select ch.hacker_id, h.name, count(challenge_id) chCount
    from challenges ch
    inner join hackers h
    on ch.hacker_id = h.hacker_id
    group by ch.hacker_id, h.name
), rankTab AS ( -- 2. get dense_rank over the counts
    select countTab.*, dense_rank() OVER (order by chCount desc) rank from countTab
), noMaxDup AS ( -- 3. get duplicates without the first rank
    select rank, count(*) rankCount
    from rankTab
    where rank <> 1
    group by rank
    having count(*) > 1
)
select hacker_id, name, chCount as challenges_created from rankTab
where rank not in (select rank from noMaxDup) -- 4. exclude the duplcates except for the first rank
order by 3 desc, hacker_id -- 5. sort count in descending order then sort hacker_id in ascending order


