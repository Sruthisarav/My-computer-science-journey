-- Qn1
SELECT name FROM world
  WHERE name LIKE 'Y%';
-- Qn2
SELECT name FROM world
  WHERE name LIKE '%y';
-- Qn3
SELECT name FROM world
  WHERE name LIKE '%x%';
-- Qn4
SELECT name FROM world
  WHERE name LIKE '%land';
-- Qn5
SELECT name FROM world
  WHERE name LIKE 'C%' AND name LIKE '%ia';
-- Qn6
SELECT name FROM world
  WHERE name LIKE '%oo%';
-- Qn7
SELECT name FROM world
  WHERE name LIKE '%a%a%a%';
-- Qn8
SELECT name FROM world
 WHERE name LIKE '_t%'
ORDER BY name;
-- Qn9
SELECT name FROM world
 WHERE name LIKE '%o__o%';
-- Qn10
SELECT name FROM world
 WHERE name LIKE '____';
-- Qn11
SELECT name
  FROM world
 WHERE name = capital;
-- Qn12
SELECT name
  FROM world
 WHERE capital LIKE '%city';
-- Qn13
SELECT capital, name FROM world
    WHERE capital LIKE concat('%',name,'%');
-- Qn14
SELECT capital, name FROM world
  WHERE capital LIKE concat(name, '_%');
-- Qn15
SELECT name, REPLACE(capital, name, '') AS extension FROM world
  WHERE capital LIKE concat(name, '_%');