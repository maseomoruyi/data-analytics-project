-- Let's explore my chosen dataset!
SELECT *
FROM project.health;

-- Counting how many countries were involved in the dataset
SELECT COUNT(country)
FROM project.health;

-- Finding out the average life expectancy of developing vs developed countries
SELECT status, ROUND(AVG(life_expectancy),2) AS Avg_Life_Expectancy
FROM project.health
GROUP BY status;

-- SUBQUERY: To find out the average life expectancy of each countries in comparison to general life expectancy in 2015
-- The result is shown in descending order so that the highest life expectancy is at the top and lowest at the bottom
-- Result shows that 'Slovenia' has the highest life expectancy (88) in average 
SELECT country, ROUND(AVG(life_expectancy),2) AS Average_Life_Expectancy, 
(SELECT ROUND(AVG(life_expectancy),2)
FROM project.health
WHERE year = 2015)
FROM project.health
WHERE year = 2015
GROUP BY country
ORDER BY AVG(life_expectancy) DESC;

-- The reverse 'ASC' shows that 'Sierra Leone' has the overall lowest life expectancy (51) over the years 
SELECT country, ROUND(AVG(life_expectancy),2) AS Average_Life_Expectancy, 
(SELECT ROUND(AVG(life_expectancy),2)
FROM project.health
WHERE year = 2015)
FROM project.health
WHERE year = 2015
GROUP BY country
ORDER BY AVG(life_expectancy) ASC;

-- Find top 10 countries with highest life expectancy in 2015
SELECT country, life_expectancy, status
FROM project.health
WHERE year = 2015
ORDER BY life_expectancy DESC
LIMIT 10;

-- Find top 10 countries with the lowest life expectancy in 2015
SELECT country, life_expectancy, status
FROM project.health
WHERE year = 2015
ORDER BY life_expectancy ASC
LIMIT 10;

-- Lets explore Chile as it came up as one of the Top 10 countries with a high life_expectancy, despite being a 'developing' country
-- We could easily filter for 'Chile' by using the WHERE syntax but I would want to explore using the 'LIKE' syntax
-- To narrow down the search for Chile, we can find countries that start with a letter 'C' and ends with letter 'e'
SELECT * 
FROM project.health
WHERE country LIKE 'C%e';

-- Finding sum of infant death in developing countries 
SELECT SUM(infant_deaths)
FROM project.health
WHERE status = 'developing';

-- Finding sum of infant death in developed countries 
SELECT SUM(infant_deaths)
FROM project.health
WHERE status = 'developed';

-- Showing the percentage of infant death in each country in comparison to to total number of infact death
-- I have decided to look at the country, life expectancy, year, status of the country in comparison with the % of infant death
-- I decided to order by '5' DESC so i can see the country with the highest % of the total infant death across my dataset
SELECT country, life_expectancy, year, status,(infant_deaths / (SELECT SUM(infant_deaths) FROM project.health) * 100) AS '% of Infant Death'
FROM project.health
ORDER BY 5 DESC;

-- Showing the percentage of adult mortality in each country in comparison to to total number of adult mortality
-- Interesting finding that the top countries with higher % of adult mortality with a pretty low life expectancy are african countries
SELECT country, life_expectancy, year, status,(adult_mortality / (SELECT SUM(adult_mortality) FROM project.health) * 100) AS '% of Adult Mortality'
FROM project.health
ORDER BY 5 DESC;

-- Creating groupings for BMI with CASE WHEN function to see the effect of bmi, measles and HIV_AIDS on life_expectancy
SELECT country, life_expectancy, measles, HIV_AIDS, CASE
WHEN bmi < 18.5 THEN 'Underweight'
WHEN bmi BETWEEN 18.5 AND 24.9 THEN 'Healthy'
WHEN bmi BETWEEN 25 AND 29.9 THEN 'Overweight'
WHEN bmi BETWEEN 30 AND 39.9 THEN 'Obese'
ELSE 'Morbidly Obese'
END AS 'BMI Range'
FROM project.health
WHERE year = 2015
ORDER BY 2 ASC;


