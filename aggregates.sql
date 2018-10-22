/*========================================================
 * Legal aggregates
 *========================================================*/

-- Only aggregate column without group by
SELECT MAX(Elevation)
FROM dbo.Mountain;

-- None aggregates column with a group by clause
SELECT Mountains,MAX(Elevation)
FROM dbo.Mountain
GROUP BY Mountains;

-- Multiple aggregate columns 
SELECT MAX(Elevation),MIN(Elevation),AVG(Elevation),SUM(Elevation),COUNT(Elevation)
FROM dbo.Mountain;

/*========================================================
 * Illegal aggregates
 *========================================================*/
-- Aggregates in a Where clause
SELECT *
FROM dbo.Mountain
WHERE Elevation = MAX(Elevation);

-- None aggregates column without a group by clause
SELECT Mountains,MAX(Elevation)
FROM dbo.Mountain;

-- Neste aggregate columns 
SELECT MAX(AVG(Elevation))
FROM dbo.Mountain;


/*========================================================
 * Statistics in SQL
 *========================================================*/
SELECT COUNT(*) AS Count_Every_Column,
   COUNT(Mountains) AS Count_Mountains,
   COUNT(DISTINCT Mountains) AS Count_Distinct_Mountains
FROM dbo.Mountain;


-- Distinct another form
SELECT Mountains
FROM dbo.Mountain
GROUP BY Mountains;

SELECT DISTINCT Mountains
FROM dbo.Mountain;
