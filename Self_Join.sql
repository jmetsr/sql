-- SQL Zoo Self Joins
1.
SELECT
  COUNT(id)
FROM
  stops;

2.
SELECT
  id
FROM
  stops
WHERE
  name = 'Craiglockhart';

3.
SELECT
  id,name
FROM
  stops JOIN route ON route.stop = stops.id
WHERE
  num = 4

4.
SELECT
  company, num, COUNT(*)
FROM
  route
WHERE
  stop=149 OR stop=53
GROUP BY
  company, num
HAVING
COUNT(*) = 2;

5.
SELECT
  a.company,
  a.num,
  a.stop,
  b.stop
FROM
  route a
JOIN
  route b
ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop= (SELECT
          id
          FROM
          stops
          WHERE
          name = 'Craiglockhart'
          )
      AND
      b.stop = (SELECT
          id
          FROM
          stops
          WHERE
          name = 'London Road' );

6.
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name = 'London Road'

7.
SELECT DISTINCT
  a.company, a.num
FROM
  route AS a
JOIN
  route AS b
ON
  (a.company=b.company AND a.num=b.num)
WHERE
  a.stop = 115
AND
  b.stop = 137;

8.
SELECT DISTINCT
  a.company,
  a.num
FROM
  route a
JOIN
  route b
ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop= (SELECT
          id
          FROM
          stops
          WHERE
          name = 'Craiglockhart'
          )
      AND
      b.stop = (SELECT
          id
          FROM
          stops
          WHERE
          name = 'Tollcross' );

9.
SELECT
  name,
  company,
  num
FROM
  route
JOIN
  stops
ON
  route.stop = stops.id
WHERE
route.num IN(
          SELECT DISTINCT
            num
          FROM
            stops
          JOIN
            route ON route.stop = stops.id
          WHERE
              stops.name = 'Craiglockhart'
            )
AND
route.company IN (
          SELECT DISTINCT
            company
          FROM
            stops
          JOIN
            route ON route.stop = stops.id
          WHERE
              stops.name = 'Craiglockhart'
            )
            ORDER BY CAST(num AS int)

10.
SELECT
  a.num,
  a.company,
  s.name,
  b.num,
  b.company
FROM

  (stops AS c JOIN route AS a ON a.stop = c.id
  JOIN stops AS s ON a.stop = s.id
  JOIN route AS b ON b.stop = s.id
  JOIN stops AS x ON b.stop = x.id)

  WHERE
  c.name = 'Craiglockhart'
  AND
  x.name = 'Sighthill'

