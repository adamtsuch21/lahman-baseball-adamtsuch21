/*
    QUESTION ::
        * Find the player who had the most success 
		  stealing bases in 2016, where success is 
		  measured as the percentage of stolen base
		  attempts which are successful. (A stolen 
		  base attempt results either in a stolen 
		  base or being caught stealing.) Consider
		  only players who attempted at least 20 
		  stolen bases.

    SOURCES ::
        * people, batting

    DIMENSIONS ::
        * namefirst, namelast

    FACTS ::
        * sb_pct

    FILTERS ::
        * Only for year 2016.
		* Only players  with at least 20 steals.

    DESCRIPTION ::
        * I selected the stolen bases and caught
		  stealing columns from the batting table, and
		  then calculated the stolen base attempts and
		  stolen base success percentage based off of
		  those columns. I also selected the namefirst
		  and namelast columns from the people table
		  and joined the two tables on the playerid.
		  I filtered for only the yearid of 2016 and at
		  least 20 stolen base attempts, and ordered by
		  stolen base percentage in descending order.

    ANSWER ::
        Name: Chris Owings
		sb_pct: 91.30 %

*/

SELECT namefirst AS first_name, namelast AS last_name,
	       sb AS stl_b, cs AS c_stl, sb+cs AS stl_b_att,
		   ROUND(
			     CAST(
					  (
					   CAST(sb AS float) /
		              (CAST(sb + cs AS float)) * 100
					  ) AS numeric
				     ),2
		         ) AS stl_b_pct
FROM batting AS batt
JOIN people AS p
ON batt.playerid = p.playerid
WHERE yearid = 2016
      AND sb + cs >= 20
ORDER BY stl_b_pct DESC
LIMIT 1;