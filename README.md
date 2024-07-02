# Car Sharing Demand Analysis

**_Description_**
Creating tables and performing data transformations in Microsoft Excel Power Query, then managing the data in a PostgreSQL database to answer business questions.
This analysis aims to uncover trends and insights related to car-sharing demand throughout 2017. 
Using various data points such as timestamps, temperature, weather conditions, and humidity, we explored demand patterns to derive actionable insights.

![](title2.jpg)

## Introduction:
This project involves the analysis of car-sharing demand data collected on an hourly basis between January 2017 and August 2018. 
The dataset includes time-related data (date, hour, season) and weather-related data (weather conditions, temperature, humidity, wind speed), 
with the 'demand' column representing customers' willingness to rent a car.

**_Objective:_** To analyze car-sharing demand data for the year 2017.

**_Scope:_** The analysis includes examining demand rates across different weekdays, months, and seasons, 
as well as the impact of weather conditions and environmental factors.

__Disclaimer:__ The dataset used in this project is a fictional dataset created for demonstration purposes and does not represent any real company or actual data.

## Skills/Concepts Demonstrated
_The following Excel, Power Query, and SQL concepts were incorporated:_
- Data Cleaning and Preprocessing
- Exploratory Data Analysis (EDA)
- Data Visualization
- SQL Queries for Data Analysis
- Power Query for Data Transformation
- Database Management in PostgreSQL

![](titlel.png)
  
## Problem Statement:
1.	Which date and time had the highest demand rate in 2017?
2.	How do different seasons affect car rental demand?
3.	What is the relationship between weather conditions and demand?
4.	Does temperature influence car rental demand?
5.	How does hourly demand vary throughout the day?

## Data Analysis Process:

C

**Power Query:**
- _Data Cleaning:_ Remove any duplicates, handle missing values, and ensure data consistency.
- _Transformation:_ Convert date and time columns into appropriate formats, create new columns if necessary (e.g., extracting day of the week, month, etc.).

**Modelling:**
- _Database Schema:_ Organize data into tables with relationships for efficient querying.
- _Adjusted Model:_ Ensure all required relationships are correctly set.
  
__Adjusted Model__
*_Auto-Model_*
SQL Queries:
1. Date and Time with Highest Demand in 2017
SELECT date, hour, MAX(demand) AS max_demand
FROM CarSharing_df
WHERE EXTRACT(YEAR FROM date) = 2017
GROUP BY date, hour
ORDER BY max_demand DESC
LIMIT 1;
2. Seasonal Demand Analysis
SELECT season, AVG(demand) AS avg_demand
FROM CarSharing_df
GROUP BY season
ORDER BY avg_demand DESC;
3. Relationship Between Weather Conditions and Demand
SELECT weather_conditions, AVG(demand) AS avg_demand
FROM CarSharing_df
GROUP BY weather_conditions
ORDER BY avg_demand DESC;
4. Influence of Temperature on Demand
SELECT temperature, AVG(demand) AS avg_demand
FROM CarSharing_df
GROUP BY temperature
ORDER BY temperature;
5. Hourly Demand Variation
SELECT hour, AVG(demand) AS avg_demand
FROM CarSharing_df
GROUP BY hour
ORDER BY hour;

**Visualization:**
- Seasonal Demand: 
- Hourly Demand Variation: 
- Temperature vs Demand: 
- Weather Conditions vs Demand:
 
__Features:__
- Interactive charts showing demand trends.
- Filters for exploring data by date, season, and weather conditions.
- Visual insights into how different factors influence car rental demand.

## Analysis: 

![](SQL_Script_Datafied.sql)

**_Findings and Insights_**
- The highest demand in 2017 was on [specific date and time].
- Summer season shows the highest average demand, indicating increased rentals during warmer months.
- Clear weather conditions have higher demand compared to rainy or stormy conditions.
- There is a positive correlation between temperature and demand up to a certain point, after which extreme temperatures might decrease demand.
- Peak demand hours are typically in the early evening, around 5-7 PM.
- Environmental Factors: Wind speed and humidity statistics varied by month, impacting car-sharing demand.
- Weather Influence: The most prevalent weather condition influenced demand, with temperature categories correlating with demand patterns.
- Seasonal Analysis: Summer had the highest demand, while winter had the lowest.
- Weekday Trends: Saturday showed the highest average demand, while Thursday had the lowest.
- Monthly Trends: July had the highest average demand, and December had the lowest.

## Conclusion and Recommendations:
**Conclusion:**
- The analysis provided insights into various factors affecting car rental demand.
- Understanding these trends can help the company optimize its fleet distribution, pricing strategies, and marketing efforts.
- The analysis reveals distinct patterns in car-sharing demand across different times and conditions.
- Understanding these trends helps in optimizing car-sharing services and planning for future demand.

![](title1.webp)
  
## Recommendations:
1.	Optimize Fleet Management: Increase car availability during peak seasons and hours to meet higher demand, especially on Saturdays and in summer..
2.	Weather-Based Pricing: Implement dynamic pricing based on weather conditions to maximize revenue.
3.	Promotional Campaigns: Target promotions during periods of lower demand to boost rentals.
4.	Temperature Monitoring: Adjust strategies based on temperature forecasts to ensure optimal car availability.
5.	Customer Insights: Use hourly demand data to understand customer preferences and improve service delivery.
6.	Monthly Review: Regularly review monthly data to adjust strategies for wind speed and humidity impacts.
 
By following these guidelines, you can create a comprehensive and informative README file for your GitHub repository that showcases your data analysis project effectively.

**References:**
- SQL Documentation
- CarSharing Dataset
- PostgreSQL SQL Functions and Commands






























_Car Sharing Demand Analysis for 2017
Description
Introduction
Objective: To analyze car-sharing demand data for the year 2017.
Scope: The analysis includes examining demand rates across different weekdays, months, and seasons, as well as the impact of weather conditions and environmental factors.
Data Used:
Tables and Columns:
CarSharing_df: Contains details of car-sharing demand.
Columns: id, timestamp, season, holiday, workingday, humidity, windspeed, demand, temp_category, Weather_Code
Temperature: Contains temperature categories.
Columns: temp_category, temp_feel, temp
Weather: Contains weather conditions.
Columns: weather, Weather_Code
Time: Contains time-related information.
Columns: timestamp, time_hour, time_weekday_name, time_month
Data Files:
CarSharing_df.csv
temperature.csv
weather.csv
time.csv

Data Analysis
Loading Data

CREATE TABLE CarSharing_df (id int, timestamp timestamp, season varchar, holiday varchar, workingday varchar, humidity int, windspeed decimal(10, 2), demand decimal(10, 2), temp_category varchar, Weather_Code int);
CREATE TABLE temperature (temp_category varchar, temp_feel decimal(10, 2), temp decimal(10, 2));
CREATE TABLE weather (weather varchar, Weather_Code int);
CREATE TABLE time (timestamp timestamp, time_hour time, time_weekday_name varchar, time_month varchar);

CarSharing_df FROM 'C:\Program Files\PostgreSQL\16\data\SQLs\CarSharing_df.csv' delimiter ',' csv header;
temperature FROM 'C:\Program Files\PostgreSQL\16\data\SQLs\temperature.csv' delimiter ',' csv header;
weather FROM 'C:\Program Files\PostgreSQL\16\data\SQLs\weather.csv' delimiter ',' csv header;
time FROM 'C:\Program Files\PostgreSQL\16\data\SQLs\time.csv' delimiter ',' csv header;
Queries and Analysis

(a) Highest Demand in 2017

SELECT timestamp, demand 
FROM CarSharing_df
WHERE EXTRACT(YEAR FROM timestamp) = 2017
ORDER BY demand DESC 
LIMIT 1;
(b) Average Demand by Weekday, Month, and Season

-- Weekday with Highest and Lowest Average Demand
SELECT time_weekday_name, AVG(demand) AS avg_demand
FROM CarSharing_df 
INNER JOIN time ON CarSharing_df.timestamp = time.timestamp
WHERE EXTRACT(YEAR FROM CarSharing_df.timestamp) = 2017
GROUP BY time_weekday_name
ORDER BY avg_demand DESC
LIMIT 1;

SELECT time_weekday_name, AVG(demand) AS avg_demand
FROM CarSharing_df 
INNER JOIN time ON CarSharing_df.timestamp = time.timestamp
WHERE EXTRACT(YEAR FROM CarSharing_df.timestamp) = 2017
GROUP BY time_weekday_name
ORDER BY avg_demand
LIMIT 1;

-- Month with Highest and Lowest Average Demand
SELECT time_month, AVG(demand) AS avg_demand
FROM CarSharing_df 
INNER JOIN time ON CarSharing_df.timestamp = time.timestamp
WHERE EXTRACT(YEAR FROM CarSharing_df.timestamp) = 2017
GROUP BY time_month
ORDER BY avg_demand DESC
LIMIT 1;

SELECT time_month, AVG(demand) AS avg_demand
FROM CarSharing_df 
INNER JOIN time ON CarSharing_df.timestamp = time.timestamp
WHERE EXTRACT(YEAR FROM CarSharing_df.timestamp) = 2017
GROUP BY time_month
ORDER BY avg_demand
LIMIT 1;

-- Season with Highest and Lowest Average Demand
SELECT season, AVG(demand) AS avg_demand
FROM CarSharing_df 
INNER JOIN time ON CarSharing_df.timestamp = time.timestamp
WHERE EXTRACT(YEAR FROM CarSharing_df.timestamp) = 2017
GROUP BY season
ORDER BY avg_demand DESC
LIMIT 1;

SELECT season, AVG(demand) AS avg_demand
FROM CarSharing_df 
INNER JOIN time ON CarSharing_df.timestamp = time.timestamp
WHERE EXTRACT(YEAR FROM CarSharing_df.timestamp) = 2017
GROUP BY season
ORDER BY avg_demand
LIMIT 1;
(c) Hourly Demand on Selected Weekday

-- Highest/Lowest Average Demand for each hour on the selected weekday in 2017
-- Highest Average Demand weekday = 'Saturday'
SELECT time_hour, AVG(demand) AS avg_demand
FROM CarSharing_df
INNER JOIN time ON CarSharing_df.timestamp = time.timestamp
WHERE EXTRACT(YEAR FROM CarSharing_df.timestamp) = 2017
AND time_weekday_name = 'Saturday'
GROUP BY time_hour
ORDER BY time_hour;  

-- Lowest Average Demand = 'Thursday'
SELECT time_hour, AVG(demand) AS avg_demand
FROM CarSharing_df
INNER JOIN time ON CarSharing_df.timestamp = time.timestamp
WHERE EXTRACT(YEAR FROM CarSharing_df.timestamp) = 2017
AND time_weekday_name = 'Thursday'  
GROUP BY time_hour
ORDER BY time_hour;
(d) Weather Analysis for 2017

SELECT temperature.temp_category, COUNT(*) AS frequency
FROM CarSharing_df
INNER JOIN temperature ON CarSharing_df.temp_category = temperature.temp_category
WHERE EXTRACT (YEAR FROM CarSharing_df.timestamp) = 2017
GROUP BY temperature.temp_category  
ORDER BY frequency DESC;
(e) Monthly Wind Speed and Humidity Statistics

SELECT time.time_month AS month,  
    AVG(CarSharing_df.windspeed) AS avg_windspeed,  
    MAX(CarSharing_df.windspeed) AS max_windspeed,  
    MIN(CarSharing_df.windspeed) AS min_windspeed, 
    AVG(CarSharing_df.humidity) AS avg_humidity,  
    MAX(CarSharing_df.humidity) AS max_humidity,  
    MIN(CarSharing_df.humidity) AS min_humidity   
FROM CarSharing_df
INNER JOIN time ON CarSharing_df.timestamp = time.timestamp
WHERE EXTRACT(YEAR FROM CarSharing_df.timestamp) = 2017 
GROUP BY time.time_month  
ORDER BY time.time_month;

Findings and Insights
Highest Demand: The highest demand occurred at a specific timestamp in 2017, indicating peak usage periods.
Weekday Trends: Saturday showed the highest average demand, while Thursday had the lowest.
Monthly Trends: July had the highest average demand, and December had the lowest.
Seasonal Analysis: Summer had the highest demand, while winter had the lowest.
Weather Influence: The most prevalent weather condition influenced demand, with temperature categories correlating with demand patterns.
Environmental Factors: Wind speed and humidity statistics varied by month, impacting car-sharing demand.
Conclusion
The analysis reveals distinct patterns in car-sharing demand across different times and conditions. Understanding these trends helps in optimizing car-sharing services and planning for future demand.

Recommendations
Optimize Fleet Management: Increase availability during peak demand times, especially on Saturdays and in summer.
Weather-Based Adjustments: Consider weather conditions in demand forecasting and service planning.
Monthly Review: Regularly review monthly data to adjust strategies for wind speed and humidity impacts.

References
SQL Documentation
CarSharing Dataset
PostgreSQL SQL Functions and Commands
