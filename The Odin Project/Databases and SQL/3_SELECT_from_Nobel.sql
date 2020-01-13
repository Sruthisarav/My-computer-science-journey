-- Qn1
SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950;
-- Qn2
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature';
-- Qn3
SELECT yr, subject FROM nobel
 WHERE winner = 'Albert Einstein';
-- Qn4
SELECT winner FROM nobel
 WHERE subject = 'Peace' AND yr >= 2000;
-- Qn5
SELECT yr, subject, winner FROM nobel
 WHERE subject = 'Literature' AND (yr >= 1980 AND yr <= 1989);
-- Qn6
SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter', 'Barack Obama');
-- Qn7
SELECT winner FROM nobel
 WHERE winner LIKE 'John%';
-- Qn8
SELECT * FROM nobel 
 WHERE (subject = 'Physics' AND yr = 1980) OR (subject = 'Chemistry' AND yr = 1984);
-- Qn9
SELECT * FROM nobel
 WHERE subject != 'Chemistry' AND subject != 'Medicine' AND yr = 1980;
-- Qn10
SELECT * FROM nobel
 WHERE (subject = 'Medicine' AND yr < 1910) OR (subject = 'Literature' AND yr >= 2004);
-- Qn11
SELECT * FROM nobel
 WHERE winner = 'PETER GRÜNBERG';
-- Qn12
SELECT * FROM nobel
 WHERE winner = 'EUGENE O''NEILL';
-- Qn13
SELECT winner, yr, subject FROM nobel
 WHERE winner LIKE 'Sir%' ORDER BY yr DESC;
-- Qn14
SELECT winner, subject
  FROM nobel
 WHERE yr=1984
 ORDER BY subject IN ('Physics','Chemistry'), subject, winner;
