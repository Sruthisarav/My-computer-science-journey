-- Qn1
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER';
-- Qn2
SELECT id,stadium,team1,team2
  FROM game
    WHERE game.id = 1012;
-- Qn3
SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON (game.id=goal.matchid) AND teamid = 'GER';
-- Qn4
SELECT team1, team2, player FROM game
  JOIN goal
    ON goal.player LIKE 'Mario%' AND (game.id=goal.matchid);
-- Qn5
SELECT player, teamid, coach, gtime FROM goal 
  JOIN eteam
    ON teamid=id
 WHERE gtime<=10;
-- Qn6
SELECT mdate, teamname FROM game
  JOIN eteam 
    ON (team1=eteam.id) AND eteam.coach = 'Fernando Santos';
-- Qn7
SELECT player FROM goal
  JOIN game
    ON game.stadium = 'National Stadium, Warsaw' AND game.id=goal.matchid;
-- Qn8
SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id 
    WHERE (team1='GER' OR team2='GER') AND teamid != 'GER';
-- Qn9
SELECT teamname, COUNT(*)
  FROM eteam JOIN goal ON id=teamid
 GROUP BY teamname;
-- Qn10
SELECT stadium, COUNT(teamid)
  FROM game JOIN goal ON id = matchid
    GROUP BY stadium;
-- Qn11
SELECT matchid,mdate, COUNT(teamid)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
    GROUP BY matchid, mdate;
-- Qn12
SELECT matchid, mdate, COUNT(teamid)
  FROM game JOIN goal ON matchid = id
  WHERE (teamid = 'GER')
    GROUP BY matchid, mdate;
-- Qn13
SELECT mdate,
  team1, SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) AS score1,
  team2, SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) AS score2
  FROM game LEFT JOIN goal ON matchid = id
  GROUP BY team1, mdate, team2, matchid
  ORDER BY mdate, matchid, team1, team2;
