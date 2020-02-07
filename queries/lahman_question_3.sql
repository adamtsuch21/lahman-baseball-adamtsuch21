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
        * collegeplaying, people, salaries

    DIMENSIONS ::
        * playerid, firstname, lastname

    FACTS ::
        * total_salary
		
    FILTERS ::
        * schoolid = 'vandy'

    DESCRIPTION ::
        * First I created a subquery where I calculated the
		  total salary for each playerid from salaries. I then
		  joined that subquery with the collegeplaying table
		  to get the schoolid for each playerid, and people
		  to get the first and last name for each playerid.
		  I then filtered for a schoolid of 'vandy' and ordered
		  it by total salary in descending order.

    ANSWER ::
        David Price

*/

SELECT player_id, first_name, last_name, 
	   CONCAT('$', total_sal::text) AS total_sal
FROM(
	 SELECT DISTINCT s.playerid AS player_id, 
					 	 p.namefirst AS first_name,
	   				 	 p.namelast AS last_name, 
					 	 ROUND(total_sal,2) AS total_sal
	 FROM(
		  SELECT playerid, 
		         SUM(CAST(salary AS integer)) AS total_sal
		  FROM salaries
	      GROUP BY playerid
	      ORDER BY total_sal DESC
	     ) AS s
	 JOIN collegeplaying AS cp
	 ON s.playerid = cp.playerid
	 JOIN people AS p
	 ON cp.playerid = p.playerid
	 WHERE cp.schoolid = 'vandy'
	 ORDER BY total_sal DESC
	) AS sub;



