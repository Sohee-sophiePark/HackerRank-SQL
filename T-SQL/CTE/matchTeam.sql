-- Given Table 'Team', only single match between each countries

DROP TABLE Team
GO 
CREATE TABLE Team(TeamName varchar(20));

INSERT INTO Team
VALUES ('A'), ('B'), ('C'), ('D');


WITH matchedTeam AS
(
    SELECT TeamName, ROW_NUMBER() OVER (ORDER BY TeamName) as rowNum
    FROM Team
)
SELECT m1.TeamName, m2.TeamName
FROM
matchedTeam m1 INNER JOIN matchedTeam m2
ON m1.TeamName <> m2.TeamName and m1.rowNum < m2.rowNum
ORDER BY m1.TeamName