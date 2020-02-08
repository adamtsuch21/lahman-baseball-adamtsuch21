/*
    QUESTION ::
        * Using the attendance figures from the homegames table,
		  find the teams and parks which had the top 5 average
		  attendance per game in 2016 (where average attendance
		  is defined as total attendance divided by number of 
		  games). Only consider parks where there were at least
		  10 games played. Report the park name, team name, and
		  average attendance. Repeat for the lowest 5 average 
		  attendance.

    SOURCES ::
        * homegames, parks

    DIMENSIONS ::
        * park_name, team

    FACTS ::
        * avg_att

    FILTERS ::
        * Only parks that played at least 10 games in 2016.

    DESCRIPTION ::
        For the parks with the highest attendance, I joined the
		homegames table with the parks table (on parks) to get
		the park_name. I then did a where statement to filter for
		only parks where 10 or more games were played for the year
		2016. I then calculated avg_att(attendance/games) and
		ordered by avg_att in descending order with a limit of 5.
		For the parks with the lowest attendance, I did the same 
		thing but ordered avg_att in ascending order.
    
    ANSWER ::
        * Top 5 highest attendance:
			1. Dodger Stadium, 45719.90 avg_att
			2. Busch Stadium III, 42524.57 avg_att
			3. Rogers Centre, 41877.77 avg_att
			4. AT&T Park, 41546.37 avg_att
			5. Wrigley Field, 39906.42 avg_att
			
		  Top 5 lowest attendance:
			1. Tropicana Field, 15878.56 avg_att
			2. Oakland-Alameda County Coliseum, 18784.02 avg_att
			3. Progressive Field, 19650.21 avg_att
			4. Marlins Park, 21405.21 avg_att
			5. U.S. Cellular Field, 21559.17 avg_att

*/

--Parks with highest avg_att
WITH most_att AS(
				 SELECT team, park_name, 
       					ROUND(
		     				  CAST(
			      					attendance::float/games::float 
								    AS numeric
		         				   ), 2
		                     ) AS avg_att,
						 'Highest Attendance Top 5' AS att_rank
                 FROM homegames AS hg
				 JOIN parks AS p
	   			 ON hg.park = p.park
				 WHERE games >= 10
				 	AND year = 2016
  				 GROUP BY team, park_name, attendance, games
				 ORDER BY avg_att DESC
				 LIMIT 5
				),
least_att AS(
			 SELECT team, park_name, 
       				ROUND(
		     			  CAST(
			      			   attendance::float/games::float
							   AS numeric
		         			  ), 2
		     			 ) AS avg_att,
				    'Lowest Attendance Top 5' AS att_rank
			 FROM homegames AS hg
		     JOIN parks AS p
		     ON hg.park = p.park
			 WHERE games >= 10
				AND year = 2016
			GROUP BY team, park_name, attendance, games
			ORDER BY avg_att
			LIMIT 5
			)
SELECT team, park_name, avg_att, att_rank
FROM most_att
UNION ALL
SELECT team, park_name, avg_att, att_rank
FROM least_att;
