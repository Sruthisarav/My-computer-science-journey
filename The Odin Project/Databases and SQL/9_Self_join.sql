-- Qn1
SELECT COUNT(id) FROM stops;
-- Qn2
SELECT id FROM stops
  WHERE name = 'Craiglockhart';
-- Qn3
SELECT stops.id, stops.name FROM stops
  JOIN route
    ON route.stop = stops.id
  WHERE route.num = 4 AND route.company = 'LRT';
-- Qn4
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) = 2;
-- Qn5
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop = 149;
-- Qn6
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name = 'London Road';
-- Qn7
SELECT DISTINCT a.company, a.num FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Haymarket' AND stopb.name = 'Leith';
-- Qn8
SELECT DISTINCT a.company, a.num FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name = 'Tollcross';
-- Qn9
SELECT DISTINCT stopb.name, a.company, a.num FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND a.company = 'LRT';
-- Qn10
SELECT DISTINCT a.num, a.company, stopb.name, d.num, d.company FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num) 
  JOIN (route c JOIN route d ON c.company = d.company AND c.num= d.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
  JOIN stops stopc ON (c.stop=stopc.id)
  JOIN stops stopd ON (d.stop=stopd.id)
WHERE stopa.name='Craiglockhart' AND stopb.name = stopc.name AND stopd.name = 'Lochend';