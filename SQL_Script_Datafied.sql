
CREATE TABLE CarSharing_df (
	id int,	
	timestamp timestamp,	
	season varchar,
	holiday varchar, 
	workingday varchar,	
	humidity int,
	windspeed decimal(10, 2),
	demand decimal(10, 2),
	temp_category varchar,
	Weather_Code int

);

CREATE TABLE temperature (
temp_category varchar,
	temp_feel decimal(10, 2),
	temp decimal(10, 2)
);

CREATE TABLE weather (
weather varchar,
	Weather_Code int

);

CREATE TABLE time (
timestamp timestamp,
	time_hour time,
	time_weekday_name varchar,
	time_month varchar

);


COPY CarSharing_df FROM 
'C:\Program Files\PostgreSQL\16\data\SQLs\CarSharing_df.csv' 
delimiter ',' csv header;


COPY temperature FROM 
'C:\Program Files\PostgreSQL\16\data\SQLs\temperature.csv' 
delimiter ',' csv header;


COPY weather FROM 
'C:\Program Files\PostgreSQL\16\data\SQLs\weather.csv' 
delimiter ',' csv header;


COPY time FROM 
'C:\Program Files\PostgreSQL\16\data\SQLs\time.csv' 
delimiter ',' csv header;


SELECT * FROM carsharing_df;

SELECT * FROM weather;

SELECT * FROM temperature;

SELECT * FROM time;


/* 
(a) Which date and time had the highest demand rate in 2017?
*/

SELECT timestamp, demand 
FROM CarSharing_df
WHERE EXTRACT(YEAR FROM timestamp) = 2017
ORDER BY demand DESC 
LIMIT 1;


/*
(b) Which weekday, month, and season had 
the highest and lowest average demand rates throughout 2017?
*/


---Weekday with Highest and Lowest Average Demand

-- highest average demand
SELECT time_weekday_name, AVG(demand) AS avg_demand
FROM CarSharing_df 
INNER JOIN time ON CarSharing_df.timestamp = time.timestamp
WHERE EXTRACT(YEAR FROM CarSharing_df.timestamp) = 2017
GROUP BY time_weekday_name
ORDER BY avg_demand DESC
LIMIT 1;

-- lowest average demand
SELECT time_weekday_name, AVG(demand) AS avg_demand
FROM CarSharing_df 
INNER JOIN time ON CarSharing_df.timestamp = time.timestamp
WHERE EXTRACT(YEAR FROM CarSharing_df.timestamp) = 2017
GROUP BY time_weekday_name
ORDER BY avg_demand
LIMIT 1;


--Month with Highest and Lowest Average Demand

-- highest average demand
SELECT time_month, AVG(demand) AS avg_demand
FROM CarSharing_df 
INNER JOIN time ON CarSharing_df.timestamp = time.timestamp
WHERE EXTRACT(YEAR FROM CarSharing_df.timestamp) = 2017
GROUP BY time_month
ORDER BY avg_demand DESC
LIMIT 1;

-- lowest average demand
SELECT time_month, AVG(demand) AS avg_demand
FROM CarSharing_df 
INNER JOIN time ON CarSharing_df.timestamp = time.timestamp
WHERE EXTRACT(YEAR FROM CarSharing_df.timestamp) = 2017
GROUP BY time_month
ORDER BY avg_demand
LIMIT 1;

--Season with Highest and Lowest Average Demand

-- highest average demand
SELECT season, AVG(demand) AS avg_demand
FROM CarSharing_df 
INNER JOIN time ON CarSharing_df.timestamp = time.timestamp
WHERE EXTRACT(YEAR FROM CarSharing_df.timestamp) = 2017
GROUP BY season
ORDER BY avg_demand DESC
LIMIT 1;

-- lowest average demand
SELECT season, AVG(demand) AS avg_demand
FROM CarSharing_df 
INNER JOIN time ON CarSharing_df.timestamp = time.timestamp
WHERE EXTRACT(YEAR FROM CarSharing_df.timestamp) = 2017
GROUP BY season
ORDER BY avg_demand
LIMIT 1;


/*
(c) For the weekday selected in (b), what was the average demand rate 
at different hours of that weekday throughout 2017?
*/

-- Highest/Lowest Average Demand for each hour on the selected weekday in 2017

--Highest Average Demand weekday = 'Saturday'
SELECT 
    time_hour, 
    AVG(demand) AS avg_demand
FROM 
    CarSharing_df
INNER JOIN 
    time 
    ON CarSharing_df.timestamp = time.timestamp
WHERE 
    EXTRACT(YEAR FROM CarSharing_df.timestamp) = 2017
    AND time_weekday_name = 'Saturday'
GROUP BY 
    time_hour
ORDER BY 
    time_hour;  
	
-- Lowest Average Demand = 'Thursday'

SELECT 
    time_hour, 
    AVG(demand) AS avg_demand
FROM 
    CarSharing_df
INNER JOIN 
    time 
    ON CarSharing_df.timestamp = time.timestamp
WHERE 
    EXTRACT(YEAR FROM CarSharing_df.timestamp) = 2017
    AND time_weekday_name = 'Thursday'  
GROUP BY 
    time_hour
ORDER BY 
    time_hour; 




/*
(d) What was the weather like in 2017? Was it mostly cold, mild, or hot? 
Which weather condition was the most prevalent in 2017?
*/
	
-- Most Prevalent Weather Condition
SELECT 
    temperature.temp_category,
    COUNT(*) AS frequency
FROM 
    CarSharing_df
INNER JOIN 
    temperature 
    ON CarSharing_df.temp_category = temperature.temp_category
WHERE 
    EXTRACT(YEAR FROM CarSharing_df.timestamp) = 2017
GROUP BY 
    temperature.temp_category  
ORDER BY 
    frequency DESC;


/*
(e) What was the average, highest, 
and lowest wind speed and humidity for each month in 2017?
*/

-- Average, highest & lowest wind speed & humidity for each month in 2017
SELECT 
    time.time_month AS month,  
    AVG(CarSharing_df.windspeed) AS avg_windspeed,  
    MAX(CarSharing_df.windspeed) AS max_windspeed,  
    MIN(CarSharing_df.windspeed) AS min_windspeed, 
    AVG(CarSharing_df.humidity) AS avg_humidity,  
    MAX(CarSharing_df.humidity) AS max_humidity,  
    MIN(CarSharing_df.humidity) AS min_humidity   
FROM 
    CarSharing_df
INNER JOIN 
    time 
    ON CarSharing_df.timestamp = time.timestamp
WHERE 
    EXTRACT(YEAR FROM CarSharing_df.timestamp) = 2017 
GROUP BY 
    time.time_month  
ORDER BY 
    time.time_month; 



