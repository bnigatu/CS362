/*==============================================================================
 * Q1
 * Display Lakes that are present in a country that do not have any rivers. 
 *==============================================================================*/
-- hint use geo_Lake and geo_River tables
/* A1 */

-- Method 1
SELECT *
FROM dbo.geo_Lake AS l
WHERE NOT EXISTS (SELECT 1
		  FROM dbo.geo_River AS r
		  WHERE r.Country = l.Country);

-- Method 2
SELECT *
FROM dbo.geo_Lake AS l
WHERE l.Country NOT IN (SELECT r.Country
						FROM dbo.geo_River AS r);

-- Method 3
SELECT *
FROM dbo.geo_Lake AS l
WHERE l.Country <> ALL (SELECT r.Country
						FROM dbo.geo_River AS r);

/*==============================================================================
 * Q2
 * Display cities from English speaking countries that has to top 5 population size
 *==============================================================================*/
-- hint use City and Language tables, you may use TOP function
/* A2 */
-- Method 1
SELECT TOP 5 City.[Name], City.Country,City.[Population]
FROM CITY 
WHERE Country IN (SELECT Country
				  FROM dbo.[LANGUAGE]
				  WHERE  [LANGUAGE].NAME = 'English' AND
						 City.Country = [LANGUAGE].Country)
ORDER BY [Population] DESC


/*==============================================================================
 * Q3
 * Display cities in USA that exists in two or more stats. 
 *==============================================================================*/
-- hint use City table
/* A3 */
-- Method 1
SELECT *
FROM dbo.City
WHERE Country = 'USA' AND
	  1<(SELECT COUNT(*)
	     FROM City AS cnt
		 WHERE cnt.Name = City.Name);
-- Method 2
SELECT *
FROM dbo.City 
WHERE Country = 'USA' AND
	  City.Name IN ( SELECT cnt.Name
					 FROM City AS cnt
					 WHERE cnt.Name = City.Name AND
					 cnt.Province <> City.Province);

/*==============================================================================
 * Q4 
 * Display the top 5 Islands in the world that has the largest Area size
 *==============================================================================*/
-- hint use Island table and make sure to exclude Islands that has NULL area size
/* A4 */
SELECT [Name]
      ,Islands
      ,Area
      ,Elevation   
FROM dbo.Island as i1
WHERE 5 > ( SELECT COUNT(*)  
			  FROM dbo.Island as i2
			  WHERE i1.Area < i2.Area)
	  AND i1.Area is not null
ORDER BY Area DESC;


/*==============================================================================
 * Q5
 * You are working on the next G8-20 summit and taked to find countries, 
 * whose economy is between 8th - 20th largest economy in the world.
 *==============================================================================*/
-- hint use dbo.Economy Table and a subquery
/* A5 */
--Method1
SELECT *
FROM dbo.Economy
WHERE  (SELECT COUNT(Country) as cnt
		  FROM dbo.Economy AS e
		  WHERE Economy.GDP < e.GDP and
		  e.GDP is not null 			
		) between 7 and 19
		and Economy.GDP is not null
ORDER BY GDP DESC;
-- Method 2
SELECT *
FROM dbo.Economy
ORDER BY GDP DESC
OFFSET 7 ROWS
FETCH NEXT 13 ROWS ONLY;
						











