

--CYCLIST BIKE-SHARE CASE STUDY
--In this case srudy, I analyzed data from a Cyclist Bike-Share company for the year 2023. The stakeholders wanted to know how their members use there bike services and how casual members can be converted to annual members.

--SKILLS COVERED  : --Data combination, exploration, cleaning and formating.
--CONCEPTS COVERED: --Creating a table and inserting data to it.
					--Union all.
					--COUNT and COUNT DISTINCT.
					--DATEDIFF and DATENAME.
					--ALTER and UPDATE TABLE.
					--CTE.
					--MAX, MIN and AVG.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Data combination

--Combining all the 11 months data tables into a single table for the year 2023 from January to November


CREATE TABLE trip_data(
ride_id nvarchar(255),
rideable_type nvarchar(255),
started_at datetime,
ended_at datetime,
start_station_name nvarchar(255),
start_station_id nvarchar(255),
end_station_name nvarchar(255),
end_station_id nvarchar(255),
start_lat float,
start_lng float,
end_lat float,
end_lng float,
member_casual nvarchar(255),
)

--Inserting values into the created table

INSERT INTO trip_data 
Select* From ['202301-divvy-tripdata$']
UNION ALL
Select* From ['202302-divvy-tripdata$']
UNION ALL
Select ride_id, rideable_type, started_at, ended_at, start_station_name, CAST(start_station_id as nvarchar(255)), end_station_name, end_station_id,
start_lat, start_lng, end_lat, end_lng, member_casual
From ['202303-divvy-tripdata$']
UNION ALL
Select* From ['202304-divvy-tripdata$']
UNION ALL
Select ride_id, rideable_type, started_at, ended_at, start_station_name, CAST(start_station_id as nvarchar(255)), end_station_name,
CAST(end_station_id as nvarchar(255)), start_lat, start_lng, end_lat, end_lng, member_casual
From ['202305-divvy-tripdata$']
UNION ALL
Select* From ['202306-divvy-tripdata$']
UNION ALL
Select* From ['202307-divvy-tripdata$']
UNION ALL
Select* From ['202308-divvy-tripdata$']
UNION ALL
Select* From ['202309-divvy-tripdata$']
UNION ALL
Select* From ['202310-divvy-tripdata$']
UNION ALL
Select* From ['202311-divvy-tripdata$']


Select*
From trip_data

------------------------------------------------------------------------------------------------------------------------------------------------------

--DATA EXPLORATION

--Checking for nulls in every column

Select COUNT(*)-COUNT(ride_id) as ride_id,
COUNT(*)-COUNT(rideable_type) as rideable_type,
COUNT(*)-COUNT(started_at) as started_at,
COUNT(*)-COUNT(ended_at) as end_at,
COUNT(*)-COUNT(start_station_name) as start_station_name,
COUNT(*)-COUNT(start_station_id) as start_station_id,
COUNT(*)-COUNT(end_station_name) as end_station_name,
COUNT(*)-COUNT(end_station_id) as end_station_id,
COUNT(*)-COUNT(start_lat) as start_lat,
COUNT(*)-COUNT(start_lng) as start_lng,
COUNT(*)-COUNT(end_lat) as end_lat,
COUNT(*)-COUNT(end_lng) as end_lng,
COUNT(*)-COUNT(member_casual) as member_casual
From trip_data

--checking for duplicate rows using ride_id as the key

Select COUNT(ride_id)-COUNT(DISTINCT ride_id) as Duplicate_rows
From trip_data


--Checking the total number of rows that we have

Select COUNT(ride_id) as Number_of_rows
From trip_data


--Getting number of trips that lasted more than a day
--Our time_difference will be in minutes

Select started_at, ended_at, DATEDIFF(minute, started_at, ended_at) as time_difference
From trip_data
Where DATEDIFF(minute, started_at, ended_at) > 1440;

--Getting number of trips that lasted less than a minute

Select started_at, ended_at, DATEDIFF(minute, started_at, ended_at) as time_difference
From trip_data
Where DATEDIFF(minute, started_at, ended_at) < 1;

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--DATA CLEANING

--Getting the time difference excluding the ones > 24 and < 1 minute

Select started_at, ended_at, DATEDIFF(minute, started_at, ended_at) as ride_length
From trip_data
Where DATEDIFF(minute, started_at, ended_at) <= 1440 AND DATEDIFF(minute, started_at, ended_at) >= 1;

---Getting the month when the ride happened

Select started_at, DATENAME(month, started_at) as month_of_ride
From trip_data

---Getting the day when the ride happened

Select started_at, DATENAME(weekday, started_at) as day_of_ride
From trip_data

---Getting hour of the day that the ride started

Select started_at, DATENAME(hour, started_at) as hour_of_the_day
From trip_data

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--DATA FORMATING
--Adding ride_length, month_of_ride and day_of_ride to our table

--ride_length
ALTER TABLE trip_data
Add ride_length int;

UPDATE trip_data
Set ride_length = DATEDIFF(minute, started_at, ended_at)

--month_of_ride
ALTER TABLE trip_data
ADD month_of_ride nvarchar(255);

UPDATE trip_data
Set month_of_ride = DATENAME(month, started_at)

--day_of_ride
ALTER TABLE trip_data
ADD day_of_ride nvarchar(255);

UPDATE trip_data
Set day_of_ride = DATENAME(weekday, started_at)

--hour_of_the_day

ALTER TABLE trip_data
ADD hour_of_the_day int;

UPDATE trip_data
Set hour_of_the_day = DATENAME(hour, started_at)

-------------------------------------------------------------------------------------------
--Deleting the one row which was a duplicate

WITH CTE as
(Select ROW_NUMBER() OVER(PARTITION BY ride_id ORDER BY ride_id) as row_num
From trip_data)
DELETE FROM CTE WHERE row_num > 1

Select*
From trip_data

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
--Creating a new table with clean data

DROP TABLE IF EXISTS yearly_bike_data

CREATE TABLE yearly_bike_data(
ride_id nvarchar(255),
rideable_type nvarchar(255),
started_at datetime,
ended_at datetime,
start_station_name nvarchar(255),
start_station_id nvarchar(255),
end_station_name nvarchar(255),
end_station_id nvarchar(255),
start_lat float,
start_lng float,
end_lat float,
end_lng float,
member_casual nvarchar(255),
ride_length int,
month_of_ride nvarchar(255),
day_of_ride nvarchar(255),
hour_of_the_day int
)

INSERT INTO yearly_bike_data 
Select *
From trip_data
Where start_station_name IS NOT NULL AND 
	  start_station_id IS NOT NULL AND
	  end_station_name IS NOT NULL AND
	  end_station_id IS NOT NULL AND
	  end_lat IS NOT NULL AND
	  end_lng IS NOT NULL AND
	  ride_length >= 1 AND ride_length <=1440 

-------------------------------------------------------------------------------------------------------------------------

Select* 
From yearly_bike_data

--We now have a clean data that we can do analysis on
----------------------------------------------------------------------------------------------------------------------

--DATA ANALYSIS

Select*
From yearly_bike_data

--------
--Number of rides made for the 11 months

Select COUNT(ride_id) as total_rides
From yearly_bike_data

--Number of casual and members that used their bike for the 11 months

Select member_casual, COUNT(ride_id) as total_rides
From yearly_bike_data
Group by member_casual
Order by member_casual DESC


--Distribution of member_casual rides per month

Select month_of_ride, member_casual, COUNT(ride_id) as total_rides
From yearly_bike_data
Group by month_of_ride, member_casual
Order by month_of_ride


--Distribution of member_casual rides per day

Select day_of_ride, member_casual, COUNT(ride_id) as total_rides
From yearly_bike_data
Group by day_of_ride, member_casual
Order by day_of_ride

--Distribution of riders per hour

Select member_casual, hour_of_the_day, AVG(ride_length) as avg_ride_length
From yearly_bike_data
Group by hour_of_the_day, member_casual
Order by hour_of_the_day


--Average ride_length for member_casual per day

Select day_of_ride, member_casual, AVG(ride_length) as avg_ride_length
From yearly_bike_data
Group by day_of_ride, member_casual
Order by day_of_ride


--Average ride_length for member_casual per month

Select month_of_ride, member_casual, AVG(ride_length) as avg_ride_length
From yearly_bike_data
Group by month_of_ride, member_casual
Order by month_of_ride

--average ride length for riders per hour

Select hour_of_the_day, member_casual, AVG(ride_length) as avg_ride_length
From yearly_bike_data
Group by hour_of_the_day, member_casual
Order by member_casual DESC

--starting station location

Select start_station_name, member_casual, AVG(start_lat) as start_lat, AVG(start_lng) as start_lng,
COUNT(ride_id) as total_rides
From yearly_bike_data
Group by start_station_name, member_casual

--ending station locations

Select end_station_name, member_casual, AVG(end_lat) as end_lat, AVG(end_lng) as start_lng,
COUNT(ride_id) as total_rides
From yearly_bike_data
Group by end_station_name, member_casual

------Day with max ride_length

Select day_of_ride, MAX(ride_length) as max_ride_length
From yearly_bike_data
Group by day_of_ride
Order by max_ride_length DESC

--Min ride_length

Select MIN(ride_length) as min_ride_length
From yearly_bike_data

--Max ride_length

Select MAX(ride_length) as max_ride_length
From yearly_bike_data
Where ride_length < 1440

--bike types used by members

Select rideable_type, member_casual, COUNT(member_casual) as riders
From yearly_bike_data
Group by rideable_type, member_casual
Order by rideable_type

------------------------------------------------------------------------------------------------------------------------



