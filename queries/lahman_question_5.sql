/*
    QUESTION ::
        * Find the average number of strikeouts per 
		  game by decade since 1920. Round the numbers 
		  you report to 2 decimal places. Do the same
		  for home runs per game. Do you see any trends?

    SOURCES ::
        * teams

    DIMENSIONS ::
        * decade

    FACTS ::
        * so_pg, hr_pg

    FILTERS ::
        * Only years greater than 1920

    DESCRIPTION ::
        * First I did a case when statement to group
		  every yearid by decade. Then I divided the
		  average of strikeouts by the average games
		  to get the average strikeouts per game.
		  I did the same with average homeruns to get
		  average homeruns per game. I then grouped it
		  and ordered it by decade.
		  

    ANSWER ::
        * There seems to be a general trend upward 
		  from early decades to later decades for 
		  both strikeouts and homeruns. Homeruns
		  more than doubled from the 1920s to 2010s,
		  and strikeouts more than tripled.

*/

SELECT 
    CASE WHEN yearid BETWEEN 1920 AND 1929 THEN '1920s'
		 WHEN yearid BETWEEN 1930 AND 1939 THEN '1930s'
		 WHEN yearid BETWEEN 1940 AND 1949 THEN '1940s'
		 WHEN yearid BETWEEN 1950 AND 1959 THEN '1950s'
		 WHEN yearid BETWEEN 1960 AND 1969 THEN '1960s'
		 WHEN yearid BETWEEN 1970 AND 1979 THEN '1970s'
		 WHEN yearid BETWEEN 1980 AND 1989 THEN '1980s'
		 WHEN yearid BETWEEN 1990 AND 1999 THEN '1990s'
		 WHEN yearid BETWEEN 2000 AND 2009 THEN '2000s'
		 WHEN yearid BETWEEN 2010 AND 2019 THEN '2010s'
		 END AS decade,
	ROUND(AVG(so)/AVG(g),2) AS so_pg,
	ROUND(AVG(hr)/AVG(g),2) AS hr_pg     
FROM teams
WHERE yearid >= 1920
GROUP BY decade
ORDER BY decade;