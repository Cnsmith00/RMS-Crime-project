
/*Changing dataset title to define key city characteristic*/ 
ALTER TABLE rms_crime_incidents
RENAME TO Det_crime_incidents;

/*Dataset Inspection for errors/column removal cases*/
SELECT *
FROM det_crime_incidents;

/*Drops personally identifiable information and irrelevant columns*/
ALTER TABLE Det_crime_incidents
DROP address,
DROP state_offense_code,
DROP arrest_charge,
DROP council_district;

/*Changing reserved word column titles*/
ALTER TABLE Det_crime_incidents
CHANGE COLUMN year year_time int;

/*Organizes records in ascending order*/
SELECT * 
FROM Det_crime_incidents
ORDER BY year_time ASC;

/* 1. What is the year range for this Detroit crime dataset?*/
SELECT MIN(year_time) AS earliestyear, MAX(year_time) AS latestyear
FROM Det_crime_incidents;

/*2. What are the top categories of crime? Most to least*/
SELECT offense_category, COUNT(*) AS total_offense_count
FROM Det_crime_incidents
GROUP BY offense_category
ORDER BY total_offense_count DESC;

/*3. What are the top 5 categories of crime in 2020?*/
SELECT year_time, offense_category, COUNT(*) AS offenses_per_year
FROM Det_crime_incidents
GROUP BY offense_category, year_time
ORDER BY year_time DESC;

/*4. What are the 3 least categories of crime?*/
SELECT offense_category, COUNT(*) AS num_of_crimes
FROM Det_crime_incidents
GROUP BY offense_category
ORDER BY num_of_crimes ASC
LIMIT 3;

/*5. What years have the most crime incidents? List most to least.*/
SELECT year_time, COUNT(*) AS total_offenses
FROM Det_crime_incidents
GROUP BY year_time
ORDER BY total_offenses DESC;

/*6. How many of each offense occurred each year?*/
SELECT year_time, offense_category, COUNT(*) AS crime_incidents
FROM Det_crime_incidents
GROUP BY year_time, offense_category
ORDER BY year_time DESC, crime_incidents DESC;

/*7. What zip codes are most dangerous based on crime incidents? Most dangerous to least.*/
SELECT zip_code, COUNT(*) AS crime_incidents
FROM Det_crime_incidents
GROUP BY zip_code
ORDER BY crime_incidents DESC;

/*8. How many assault cases were in the Warrendale neighborhoods?*/ 
SELECT neighborhood, COUNT(*) AS assault_incidents
FROM Det_crime_incidents
WHERE neighborhood = 'Warrendale' and offense_category = 'ASSAULT'
GROUP BY neighborhood
ORDER BY assault_incidents DESC;

/*9. Number of crime incidents in each neighborhood per year 2001-2022*/
SELECT year_time, neighborhood, COUNT(*) AS crime_incidents
FROM Det_crime_incidents
WHERE year_time BETWEEN '2001' and '2022'
GROUP BY year_time, neighborhood
ORDER BY neighborhood ASC, year_time DESC, crime_incidents DESC;

/*10. What is the most common crime in the neighborhood Warrendale Detroit? Most to least.*/
SELECT neighborhood, offense_category, COUNT(*) AS neighborhood_crime_incident
FROM Det_crime_incidents
WHERE neighborhood = 'Warrendale'
GROUP BY offense_category
ORDER BY neighborhood_crime_incident DESC;

/*11. Which neighborhoods had the most robbery incidents? Most to least.*/
SELECT neighborhood, COUNT(*) AS robbery_incidents
FROM Det_crime_incidents
WHERE offense_category = 'robbery'
GROUP BY neighborhood
ORDER BY robbery_incidents DESC;

/*12. What day of week does crime occur most?*/
SELECT day_of_week, COUNT(*) AS crime_incidents
FROM Det_crime_incidents
WHERE year_time BETWEEN 2001 AND 2022
GROUP BY day_of_week
ORDER BY crime_incidents DESC;

/*13. What day of week does crime occur most? */
SELECT day_of_week, COUNT(*) AS crime_incidents
FROM Det_crime_incidents
WHERE year_time BETWEEN 2001 AND 2022
GROUP BY day_of_week
ORDER BY crime_incidents DESC;

/*14. What is the percentage breakdown of offenses by category? */
SELECT offense_category,
    COUNT(*) AS count,
    COUNT(*) / (SELECT COUNT(*) FROM det_crime_incidents) AS ratio
FROM (
    SELECT offense_category
    FROM det_crime_incidents
       UNION ALL
    SELECT offense_category
    FROM det_crime_incidents
    ) t
GROUP BY offense_category
ORDER BY count DESC;

/*15. Which squad car area has the highest number of crime incident occurences?*/
SELECT scout_car_area, COUNT(*) as crime_incidents
FROM Det_crime_incidents
GROUP BY scout_car_area
ORDER BY crime_incidents DESC;

/*16. What times do most crimes occur?*/
SELECT hour_of_day, COUNT(*) as crime_incidents
FROM Det_crime_incidents
GROUP BY hour_of_day
ORDER BY crime_incidents DESC;


