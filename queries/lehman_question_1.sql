/*
    QUESTION ::
       * What range of years does the provided database cover?
	   
    SOURCES ::
        * pitching, batting, fielding
		
    DIMENSIONS ::
        * yearid

    FACTS ::
        * the main tables from the database are pitching, batting, and
		fielding

    FILTERS ::
        * grab only distinct years

    DESCRIPTION ::
        * To find the lowest yearid, I selected the distinct yearids
		from the pitching, batting,and fielding tables,
		then I did a union to combine them together,
		and ordered it with the lowest yearid on top,
		with only the top result being shown.
		I then repeat the same for the highest yearid,
		but ordered it in descending order to show the
		highest yearid on top.

    ANSWER ::
        1871-2016

*/

--Shows lowest yearid from pitching, batting, and fielding tables
SELECT DISTINCT yearid
FROM pitching
UNION ALL
SELECT DISTINCT yearid
FROM batting
UNION ALL
SELECT DISTINCT yearid
FROM fielding
ORDER BY yearid
LIMIT 1;

--Shows highest yearid from pitching, batting, and fielding tables
SELECT DISTINCT yearid
FROM pitching
UNION ALL
SELECT DISTINCT yearid
FROM batting
UNION ALL
SELECT DISTINCT yearid
FROM fielding
ORDER BY yearid DESC
LIMIT 1;