-- Qn1
SELECT name FROM teacher
  WHERE dept IS NULL;
-- Qn2
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id);
-- Qn3
SELECT teacher.name, dept.name
  FROM teacher LEFT JOIN dept
    ON (teacher.dept=dept.id);
-- Qn4
SELECT teacher.name, dept.name
  FROM teacher RIGHT JOIN dept
    ON (teacher.dept=dept.id);
-- Qn5
SELECT name, COALESCE(mobile,'07986 444 2266') FROM teacher;
-- Qn6
SELECT teacher.name, COALESCE (dept.name, 'None') FROM teacher
  LEFT JOIN dept
    ON teacher.dept = dept.id;
-- Qn7
SELECT COUNT(name), COUNT(mobile) FROM teacher;
-- Qn8
SELECT dept.name, COUNT(teacher.name) FROM teacher
  RIGHT JOIN dept
    ON teacher.dept = dept.id
  GROUP BY dept.name;
-- Qn9
SELECT name, CASE WHEN dept = 1 THEN 'Sci' WHEN dept = 2 THEN 'Sci' ELSE 'Art' END
  FROM teacher;
-- Qn 10
SELECT name, CASE WHEN dept = 1 THEN 'Sci' WHEN dept = 2 THEN 'Sci' WHEN dept = 3 then 'Art' ELSE 'None' END
  FROM teacher;