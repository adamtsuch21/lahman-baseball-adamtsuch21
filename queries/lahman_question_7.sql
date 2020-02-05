/*
    QUESTION ::
        * From 1970 – 2016, what is the largest number 
		of wins for a team that did not win the world 
		series? What is the smallest number of wins for
		a team that did win the world series? Doing this
		will probably result in an unusually small number
		of wins for a world series champion – determine 
		why this is the case. Then redo your query, 
		excluding the problem year. How often from 
		1970 – 2016 was it the case that a team with 
		the most wins also won the world series? 
		What percentage of the time?

    SOURCES ::
        * teams

    DIMENSIONS ::
        * team, wins, year

    FACTS ::
        * MIN(w), MAX(w), ws_win_pct

    FILTERS ::
        * only seasons from 1970 to 2016.

    DESCRIPTION ::
        * To find the max wins with no WS, I filtered
		  for teams with wswin of 'N', years between
		  1970 and 2016, and used a having clause where
		  w = max(w).
		* For min win with WS, I filter for teams with
		  wswin of 'Y', same year filter as first question,
		  but filtered out 1981 (due to strike). Also used
		  a having clause where w = min(w).
		* For percentage of teams with most wins and WS win,
		  I created a subquery to filter for teams who had
		  the most wins in each season. I then inner joined
		  that subquery with the original teams table so I
		  could add the wswin column. I made that another
		  subquery, then in the outer query I calculated the
		  percentage by counting where the wswin was 'Y'
		  and dividing by the number of seasons (46,
		  disregarding 1994 where their was no WS) and
		  multiplying by 100.

    ANSWER ::
        * max wins with no WS: SEA 2001, 116 wins
		* min wins with WS win: SLN 2006, 83 wins
		* LAN had min wins with WS win in 1981, 
		  but there was a players strike so the 
		  season length was reduced.
		* # of teams with most wins who won WS: 12
		* Pct where team with most wins won WS: 26%

*/

--Team with most wins and no WS
SELECT teamid AS team, w AS wins, yearid AS year
FROM teams
WHERE wswin = 'N'
AND yearid BETWEEN 1970 AND 2016
GROUP BY teamid, w, yearid
HAVING w = MAX(w)
ORDER BY wins DESC
LIMIT 1;

--Team with least wins and won WS
SELECT teamid AS team, w AS wins, yearid AS year
FROM teams
WHERE wswin = 'Y'
AND yearid BETWEEN 1970 AND 2016
AND yearid != 1981
GROUP BY teamid, w, yearid
HAVING w = MIN(w)
ORDER BY wins
LIMIT 1;

--Percentage of time team with most wins won WS
SELECT ROUND(
			 CAST(
				  CAST(
					   COUNT(sub.wswin) AS float
				      )/
			           CAST(46 AS float) AS numeric
			      ), 2
             ) * 100 AS ws_win_pct
FROM(
	SELECT DISTINCT ON (t1.yearid) t1.yearid, w, wswin, 
	teamid
	FROM teams AS t1
	INNER JOIN(
		       SELECT DISTINCT yearid, MAX(w) AS wins
		       FROM teams
		       WHERE yearid BETWEEN 1970 AND 2016
	           GROUP BY yearid
	           ORDER BY yearid
		      ) AS t2
    ON t1.yearid = t2.yearid
    AND t1.w = t2.wins
    WHERE wswin IS NOT NULL
	) AS sub
WHERE wswin = 'Y';
