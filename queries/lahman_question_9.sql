/*
    QUESTION ::
        * Which managers have won the TSN Manager of the Year award
		in both the National League (NL) and the American League 
		(AL)? Give their full name and the teams that they were 
		managing when they won the award.

    SOURCES ::
        * awardsmanagers, people, managers

    DIMENSIONS ::
        * player_id, first_name, last_name, nl_award_team
		  al_award_team

    FACTS ::
        * None.

    FILTERS ::
        * managers who have won MotY in both AL and NL

    DESCRIPTION ::
        * First I made a cte that joined the awardsmanagers,
		  people, and managers tables (on playerid for 
		  people and playerid and yearid for managers) to get
		  the managers names and their teams. I then filtered
		  for the TSN MotY award and for the NL league, and ordered
		  by year. I made another cte doing the same thing, 
		  but filtering for the AL league. I then joined the two
		  ctes together on playerid, and selected distinct
		  playerids, first and last name, NL team and AL team.

    ANSWER ::
        * Name: Davey Johnson 
		  NL Team: WAS 
		  AL Team: BAL
		* Name: Jim Leyland
		  NL Team: PIT
		  AL Team: DET

*/

WITH nl AS(
	       SELECT am1.yearid, am1.playerid, p1.namefirst, 
		   p1.namelast, am1.awardid, am1.lgid, m1.teamid
           FROM awardsmanagers AS am1
	       JOIN people AS p1
	       ON am1.playerid = p1.playerid
	       JOIN managers AS m1
	       ON p1.playerid = m1.playerid
		   AND am1.yearid = m1.yearid
	       WHERE am1.awardid = 'TSN Manager of the Year'
	            AND am1.lgid = 'NL'
		   ORDER BY am1.yearid
	       ),
	  al AS(	
	        SELECT am2.yearid, am2.playerid, p2.namefirst, 
		   p2.namelast, am2.awardid, am2.lgid, m2.teamid
           FROM awardsmanagers AS am2
	       JOIN people AS p2
	       ON am2.playerid = p2.playerid
	       JOIN managers AS m2
	       ON p2.playerid = m2.playerid
		   AND am2.yearid = m2.yearid
	       WHERE am2.awardid = 'TSN Manager of the Year'
	            AND am2.lgid = 'AL'
		   ORDER BY am2.yearid
		    )
SELECT  DISTINCT ON(n.playerid) n.playerid AS player_id, 
                   n.namefirst AS first_name, 
				   n.namelast AS last_name,
                   n.teamid AS nl_award_team, 
				   a.teamid AS al_award_team
FROM nl AS n
INNER JOIN al AS a
ON n.playerid = a.playerid;