-- Qn1
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia');
-- Qn2
SELECT name FROM world
  WHERE continent = 'Europe' AND gdp/population > 
    (SELECT gdp/population FROM world
      WHERE name = 'United Kingdom');
-- Qn3
SELECT name, continent FROM world
  WHERE continent IN 
    (SELECT continent fROM world
      WHERE name IN ('Argentina', 'Australia'))
    ORDER BY name;
-- Qn4
SELECT name, population FROM world
  WHERE population >
    (SELECT population FROM world
      WHERE name = 'Canada') AND population <
    (SELECT population FROM world
      WHERE name = 'Poland');
-- Qn5
SELECT name, concat(ROUND(population*100/
  (SELECT population FROM world
    WHERE name = 'Germany')),'%') FROM world
  WHERE continent = 'Europe';
-- Qn6
SELECT name FROM world
  WHERE GDP >
    (SELECT MAX(GDP) FROM world
      WHERE continent = 'Europe');
-- Qn7
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0);
-- Qn8
SELECT continent, name FROM world x
  WHERE name <= ALL
    (SELECT name FROM world y
        WHERE y.continent=x.continent);
