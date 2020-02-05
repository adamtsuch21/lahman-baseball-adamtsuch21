/*
    QUESTION ::
        Find the name and height of the shortest player
		in the database. How many games did he play in? 
		What is the name of the team for which he played?

    SOURCES ::
        * people, appearances

    DIMENSIONS ::
        * namefirst, namelast, teamid, games_played

    FACTS ::
        * height
		
    FILTERS ::
        * Only show shortest player.

    DESCRIPTION ::
        * To get the name and height I need the people
		  table, and to get the games played and teamid
		  I need the appearances table. So I joined the
		  two tables (selecting namefirst, namelast, 
		  height, g_all as games_played, and teamid) on
		  the playerid, and ordered by height to have 
		  the shortest player on top, and did a limit
		  to only show the shortest player.

    ANSWER ::
        Name: Eddie Gaedel
		Height: 43 inches
		Games Played: 1
		Team: SLA
		

*/

SELECT namefirst AS first_name, namelast AS last_name, 
	   height AS height_in, g_all AS games_played, teamid AS team
FROM people AS p
JOIN appearances AS app
ON p.playerid = app.playerid
ORDER BY height_in
LIMIT 1;
	   