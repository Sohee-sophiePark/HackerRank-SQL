/* 
Julia conducted a  days of learning SQL contest. The start date of the contest was March 01, 2016 and the end date was March 15, 2016.

Write a query to print total number of unique hackers who made at least  submission each day (starting on the first day of the contest), and find the hacker_id and name of the hacker who made maximum number of submissions each day. If more than one such hacker has a maximum number of submissions, print the lowest hacker_id. The query should print this information for each day of the contest, sorted by the date.

Input Format

The following tables hold contest data:

Hackers: The hacker_id is the id of the hacker, and name is the name of the hacker.

Submissions: The submission_date is the date of the submission, submission_id is the id of the submission, hacker_id is the id of the hacker who made the submission, and score is the score of the submission. 

Sample Input

For the following sample input, assume that the end date of the contest was March 06, 2016.

Hackers Table:  Submissions Table: 

Sample Output

2016-03-01 4 20703 Angela
2016-03-02 2 79722 Michael
2016-03-03 2 20703 Angela
2016-03-04 2 20703 Angela
2016-03-05 1 36396 Frank
2016-03-06 1 20703 Angela
Explanation
*/
WITH uniqHackerSubmissionCount AS
(
    select submission_date, hacker_id, count(submission_id) subCount
    from submissions 
    group by submission_date, hacker_id
), rank AS (
    select submission_date, hacker_id
    , ROW_NUMBER() OVER (PARTITION BY submission_date ORDER BY subCount desc, hacker_id) rowNum
    from uniqHackerSubmissionCount 
), maxSubmission AS (
    select * from rank
    where rowNum = 1
), uniqHackerCount AS(
    select u1.submission_date currDate, u2.submission_date prevDate, u1.hacker_id
    from uniqHackerSubmissionCount u1 left join uniqHackerSubmissionCount u2
    on (u1.submission_date = dateadd(day, 1, u2.submission_date)) and u1.hacker_id = u2.hacker_id
), serialSub AS (
    select DENSE_RANK() over (ORDER BY currDate) currRow
    , DENSE_RANK() over (PARTITION BY hacker_id ORDER BY prevDate) prevRow
    , * from uniqHackerCount
), serialCount AS (
    select currDate, hacker_id
    from serialSub
    where currRow = prevRow
    group by currDate, hacker_id
)
, totalCount AS (
    select currDate, count(hacker_id) tot
    from serialCount
    group by currDate
)
select tc.*, m.hacker_id, h.name from totalCount tc
left join maxSubmission m
on tc.currDate = m.submission_date 
left join hackers h
on m.hacker_id = h.hacker_id