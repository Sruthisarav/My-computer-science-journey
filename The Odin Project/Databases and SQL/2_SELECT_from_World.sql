-- Qn1
SELECT name, continent, population FROM world;
--Qn2
SELECT name FROM world
WHERE population >= 200000000;
-- Qn3
SELECT name, gdp/population FROM world
WHERE population >= 200000000;
-- Qn4
SELECT name, population/1000000 FROM world
WHERE continent = 'South America';
-- Qn5
SELECT name, population FROM world
WHERE name IN ('France', 'Germany', 'Italy');
-- Qn6
SELECT name FROM world
WHERE name LIKE '%United%';
-- Qn7
SELECT name, population, area FROM world
WHERE area > 3000000 OR population > 250000000;
-- Qn8
SELECT name, population, area FROM world
WHERE area > 3000000 XOR population > 250000000;
-- Qn9
SELECT name, ROUND(population/1000000, 2), ROUND(GDP/1000000000, 2) FROM world
WHERE continent = 'South America';
-- Qn10
SELECT name, ROUND(GDP/population, -3) FROM world
WHERE GDP >= 1000000000000;
-- Qn11
SELECT name, capital
  FROM world
 WHERE LENGTH(name) = LENGTH(capital);
-- Qn12
SELECT name, capital
  FROM world
 WHERE name <> capital AND LEFT(name,1) = LEFT(capital,1);
-- Qn13
SELECT name
   FROM world
WHERE name LIKE '%a%' AND name LIKE '%e%' AND name LIKE '%i%' AND name LIKE '%o%' AND name LIKE '%u%'
  AND name NOT LIKE '% %';