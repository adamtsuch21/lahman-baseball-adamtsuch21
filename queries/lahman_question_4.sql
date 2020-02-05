/*
    QUESTION ::
        * Using the fielding table, group players into 
		  three groups based on their position: label 
		  players with position OF as "Outfield", those
		  with position "SS", "1B", "2B", and "3B" as 
		  "Infield", and those with position "P" or "C"
		  as "Battery". Determine the number of putouts
		  made by each of these three groups in 2016.

    SOURCES ::
        * fielding table

    DIMENSIONS ::
        * sort_pos

    FACTS ::
        * total_po

    FILTERS ::
        * Only need putouts from the year 2016.

    DESCRIPTION ::
        * First I did a case when statement to sort
		  every position into 'Outfield', 'Infield',
		  and 'Battery'. Then I summed all of putouts
		  to get the total putouts. Then I filtered
		  where the yearid was 2016 to get only the
		  putouts from 2016. Then I grouped by the new
		  sorted positions to get the total putouts for
		  each position.

    ANSWER ::
        * Infield: 58934
		  Battery: 41424
		  Outfield: 29560

*/

SELECT CASE WHEN pos = 'OF' THEN 'Outfield'
			WHEN pos = 'SS' THEN 'Infield'
			WHEN pos = '1B' THEN 'Infield'
			WHEN pos = '2B' THEN 'Infield'
			WHEN pos = '3B' THEN 'Infield'
			WHEN pos = 'P'  THEN 'Battery'
			WHEN pos = 'C'  THEN 'Battery'
			END AS sort_pos,
		SUM(po) AS total_po
FROM fielding
WHERE yearid = 2016
GROUP BY sort_pos
ORDER BY total_po DESC;