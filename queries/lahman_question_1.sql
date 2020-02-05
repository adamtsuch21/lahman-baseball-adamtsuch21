/*
    QUESTION ::
       * What range of years does the provided database
	     cover?
	   
    SOURCES ::
        * pitching, batting, fielding
		
    DIMENSIONS ::
        * None

    FACTS ::
        * min_year, max_year

    FILTERS ::
        * None

    DESCRIPTION ::
        * Unioned pitching, batting, and fielding 
		  together and found the min and max year
		  for each. I placed that in a subquery
		  and then in the main query found the 
		  overall min and max year from all 3 tables.

    ANSWER ::
        1871-2016

*/

SELECT MIN(min_year) AS first_year, 
	   MAX(max_year) AS last_year
FROM(
	SELECT MIN(yearid) AS min_year,
		   MAX(yearid) AS max_year
	FROM pitching
    UNION ALL
    SELECT MIN(yearid) AS min_year,
		   MAX(yearid) AS max_year
    FROM batting
    UNION ALL
    SELECT MIN(yearid) AS min_year,
		   MAX(yearid) AS max_year
    FROM fielding
	) AS year_union;