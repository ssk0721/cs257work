/* List of all teams and years with total payrolls above $150 million, ordered by total payroll */

SELECT team, teamyear, winpercentage, roundmade, payrollamount FROM salaries WHERE payrollamount>=150000000 AND positiongroup = 'TotalPayroll' ORDER BY payrollamount DESC;

/* List of all teams' average total payroll spending per year, along with their average win percentage per year. Ordered by highest average total payroll */

SELECT team, AVG(winpercentage) AS avgwinpercentage, AVG(payrollamount) AS avgtotalpayroll FROM salaries WHERE positiongroup = 'TotalPayroll' GROUP BY team ORDER BY avgtotalpayroll DESC;

/* List of all teams that have made the world series, the number of times they have made the world series, the number of times they have won the world series, and the position group they have spent the most on during the years they made the world series. Ordered by the amount of times they have won the world series. */

WITH get_max_position_spending AS (SELECT team, teamyearID, positiongroup, MAX(totalpayroll) AS largestearner, roundmade FROM salaries WHERE positiongroup != 'TotalPayroll' GROUP BY positiongroup, teamyearID)


SELECT team, COUNT(DISTINCT CASE WHEN roundmade >= 4 THEN teamyearID ELSE NULL END) AS madeworldseries, COUNT(DISTINCT CASE WHEN roundmade == 5 THEN teamyearID ELSE NULL END) AS wonworldseries, positiongroup, largestearner, GROUP BY team HAVING madeworldseries >=1