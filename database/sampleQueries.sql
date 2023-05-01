/* List of all teams and years with total payrolls above $150 million, along with their win percentage for that year, the round they made, and the payroll amount. ordered by total payroll */

SELECT team, teamyear, winpercentage, roundmade, payrollamount 
FROM salaries 
WHERE payrollamount>=150000000 AND positiongroup = 'TotalPayroll' 
ORDER BY payrollamount DESC;

/* List of all teams' average total payroll spending per year, along with their average win percentage per year. Ordered by highest average total payroll */

SELECT team, ROUND(AVG(winpercentage), 3) AS avgwinpercentage, ROUND(AVG(payrollamount), 2) AS avgtotalpayroll 
FROM salaries 
WHERE positiongroup = 'TotalPayroll' 
GROUP BY team 
ORDER BY avgtotalpayroll DESC;

/* List of all teams that have made the world series, the number of times they have made the world series, the number of times they have won the world series, the position group they have spent the most on during the years they made the world series, . Ordered by the amount of times they have won the world series. */


WITH get_teams_made_world_series AS (SELECT team, teamyear, teamyearID, positiongroup, payrollamount, roundmade 
    FROM salaries
    WHERE positiongroup != 'TotalPayroll' AND roundmade >=4
    GROUP BY team, teamyearID, positiongroup, roundmade, teamyear, payrollamount, roundmade),
    get_per_position_payroll AS (SELECT team, positiongroup, SUM(payrollamount) AS totalpayrollposition, COUNT(DISTINCT CASE WHEN roundmade >= 4 THEN teamyearID ELSE NULL END) AS madeworldseries, COUNT(DISTINCT CASE WHEN roundmade = 5 THEN teamyearID ELSE NULL END) AS wonworldseries
    FROM get_teams_made_world_series
    GROUP BY team, positiongroup),
    get_rankings_position_payroll AS (SELECT team, positiongroup, madeworldseries, wonworldseries, RANK() OVER (PARTITION BY team ORDER BY totalpayrollposition DESC) AS payroll_rank, totalpayrollposition
    FROM get_per_position_payroll)
    

SELECT team, madeworldseries, wonworldseries, positiongroup AS HighestPositionGroupEarner, totalpayrollposition AS MoneyEarned
FROM get_rankings_position_payroll
WHERE payroll_rank = 1
ORDER BY madeworldseries DESC


