-- Qn1
SELECT SUM(population) FROM world;
-- Qn2
SELECT DISTINCT continent FROM world;
-- Qn3
SELECT SUM(GDP) FROM world
  WHERE continent = 'Africa';
-- Qn4
SELECT COUNT(name) FROM world
  WHERE area >= 1000000;
-- Qn5
SELECT SUM(population) FROM world
  WHERE name IN ('Estonia', 'Latvia', 'Lithuania');
-- Qn6
SELECT continent, COUNT(name) FROM world 
  GROUP BY continent;
-- Qn7
SELECT continent, COUNT(name) FROM world
  WHERE population >= 10000000 
    GROUP BY continent;
-- Qn8
SELECT continent FROM world
  GROUP BY continent
    HAVING SUM(population) >= 100000000;
