/*
    QUESTION ::
        * Find all players in the database who played 
		  at Vanderbilt University. Create a list 
		  showing each player’s first and last names as
		  well as the total salary they earned in the 
		  major leagues. Sort this list in descending 
		  order by the total salary earned. Which 
		  Vanderbilt player earned the most money in 
		  the majors?
		
    SOURCES ::
        * schoools, collegeplaying, people, salaries

    DIMENSIONS ::
        * playerid, firstname, lastname

    FACTS ::
        * total_salary
    FILTERS ::
        * schoolid = 'vandy'

    DESCRIPTION ::
        * First I had to join schools and 
		  collegeplaying on schoolid to match playerid 
		  with their schools. Then I joined people on 
		  playerid to get the firstname, lastname of 
		  those players. Then I joined salaries on 
		  playerid to get the salaries of those players
		  (using SUM to get the total_salary for each 
		  player and selecting distinct player_ids). 
		  I then filtered to only show players with a 
		  schoolid of 'vandy' for Vanderbilt University.
		  I then grouped by playerid, firstname, and 
		  lastname and ordered by total_salary in 
		  descending order to have the player with the 
		  highest total_salary on top.

    ANSWER ::
        David Price

*/

SELECT DISTINCT p.playerid, namefirst AS firstname,
       namelast AS lastname, SUM(salary) as total_salary
FROM schools AS sch
JOIN collegeplaying AS cp
ON sch.schoolid = cp.schoolid
JOIN people AS p
ON cp.playerid = p.playerid
JOIN salaries AS s
ON p.playerid = s.playerid
WHERE sch.schoolid = 'vandy'
GROUP BY p.playerid, firstname, lastname
ORDER BY total_salary DESC;