/*
    QUESTION ::
        Find the name and height of the shortest player in the database.
		How many games did he play in? 
		What is the name of the team for which he played?

    SOURCES ::
        * people, appearances

    DIMENSIONS ::
        * namefirst, namelast, height, g_all, teamid

    FACTS ::
        * the name and height are in the people table.
		* the games played and teamid are in the appearances table.
		* people and appearances can be joined on playerid.

    FILTERS ::
        * None

    DESCRIPTION ::
        * To get the name and height I need the people table,
		and to get the games played and teamid I need the appearances table.
		So I joined the two tables (selecting namefirst, namelast, height,
		g_all as games_played, and teamid) on the playerid,
		and ordered by height to have the showest player on top,
		and did a limit to only show the top result.

    ANSWER ::
        Name: Eddie Gaedel
		Height: 43 inches
		Games Played: 1
		Team: SLA
		

*/

SELECT namefirst, namelast, height, g_all AS games_played,
teamid
FROM people AS p
JOIN appearances AS app
ON p.playerid = app.playerid
ORDER BY height
LIMIT 1;
