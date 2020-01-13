-- Qn1
SELECT id, title
 FROM movie
 WHERE yr=1962;
-- Qn2
SELECT yr FROM movie
  WHERE title = 'Citizen Kane';
-- Qn3
SELECT id, title, yr FROM movie
  WHERE title LIKE '%Star Trek%'
  ORDER BY yr;
-- Qn4
SELECT id FROM actor
  WHERE name = 'Glenn Close';
-- Qn5
SELECT id FROM movie
  WHERE title = 'Casablanca';
-- Qn6
SELECT actor.name FROM actor
  LEFT JOIN casting
    ON casting.actorid = actor.id
  WHERE casting.movieid = 11768;
-- Qn7
SELECT actor.name FROM actor
  LEFT JOIN casting
    ON casting.actorid = actor.id
  WHERE casting.movieid = (SELECT id FROM movie WHERE title = 'Alien');
-- Qn 8
SELECT title FROM movie
  LEFT JOIN casting
    ON casting.movieid = id
  WHERE casting.actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford');
-- Qn9
SELECT title FROM movie
  LEFT JOIN casting
    ON casting.movieid = id
  WHERE casting.actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford') AND
    casting.ord != 1;
-- Qn10
SELECT title, actors.name FROM movie
  LEFT JOIN 
    (SELECT actor.name, casting.movieid FROM actor
      LEFT JOIN casting
        ON casting.actorid = actor.id AND casting.ord = 1) AS actors
    ON movie.id = actors.movieid
  WHERE yr = 1962 AND actors.name IS NOT NULL;
-- Qn11
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;
-- Qn12
SELECT DISTINCT movie.title, actor.name FROM movie
  JOIN casting 
    ON movie.id=movieid AND casting.ord = 1
      JOIN actor ON actorid=actor.id
  WHERE movie.id IN (SELECT movieid FROM casting
    WHERE actorid IN (
      SELECT id FROM actor
        WHERE name='Julie Andrews'));
-- Qn13
SELECT name FROM actor
  JOIN casting 
    ON casting.actorid = actor.id
  WHERE ord = 1
  GROUP BY name
  HAVING COUNT(*) > 30;
-- Qn14
SELECT title, COUNT(actorid) FROM casting
  JOIN movie
    ON casting.movieid = movie.id
  WHERE yr = 1978
  GROUP BY title
  ORDER BY COUNT(casting.actorid) DESC, title;