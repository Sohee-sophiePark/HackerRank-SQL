/*
Samantha interviews many candidates from different colleges using coding challenges and contests. Write a query to print the contest_id, hacker_id, name, and the sums of total_submissions, total_accepted_submissions, total_views, and total_unique_views for each contest sorted by contest_id. Exclude the contest from the result if all four sums are .

Note: A specific contest can be used to screen candidates at more than one college, but each college only holds  screening contest.


 Enter your query here.
 Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
 */
-- First figure the relationship between tables
-- Contests : colleges one to many
-- colleges : challenges one to many
-- views - duplicates on challenges
-- submissions - duplicates on challenges
--(agg values and left join on challeges)

SELECT
    c.contest_id,
    c.hacker_id,
    c.name,
    sum_total_submissions,
    sum_total_accepted_submissions,
    sum_total_views,
    sum_total_unique_views
FROM
    Contests c
    INNER JOIN (
        SELECT
            c.contest_id contest_id,
            sum(sub.total_submissions) sum_total_submissions,
            sum(sub.total_accepted_submissions) sum_total_accepted_submissions,
            sum(v.total_views) sum_total_views,
            sum(v.total_unique_views) sum_total_unique_views
        FROM
            Contests c
            INNER JOIN Colleges col ON c.contest_id = col.contest_id
            INNER JOIN Challenges ch ON ch.college_id = col.college_id
            LEFT JOIN (
                SELECT
                    challenge_id,
                    SUM(total_views) total_views,
                    SUM(total_unique_views) total_unique_views
                FROM
                    View_Stats
                GROUP BY
                    challenge_id
            ) v ON ch.challenge_id = v.challenge_id
            LEFT JOIN (
                SELECT
                    challenge_id,
                    sum(total_submissions) total_submissions,
                    sum(total_accepted_submissions) total_accepted_submissions
                FROM
                    Submission_Stats
                GROUP BY
                    challenge_id
            ) sub ON ch.challenge_id = sub.challenge_id
        GROUP BY
            c.contest_id
    ) col ON c.contest_id = col.contest_id
WHERE
    (
        sum_total_submissions + sum_total_accepted_submissions + sum_total_views + sum_total_unique_views > 0
    )
ORDER BY
    c.contest_id