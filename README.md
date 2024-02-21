**PROJECT SUMMARY**

I am assuming to be a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s 
future success depends on maximizing the number of annual memberships. Therefore, my team wants to understand how casual riders and annual members use Cyclistic bikes differently. 
From these insights, my team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve our recommendations, 
so they must be backed up with compelling data insights and professional data visualizations.


***Background***

Cyclistic is a bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic sets itself apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with disabilities and riders who can’t use a standard two-wheeled bike. The majority of riders opt for traditional bikes; about 8% of
riders use the assistive options. Cyclistic users are more likely to ride for leisure, but about 30% use them to commute to work each day.

Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments. What helped make these things possible was 
the flexibility of its pricing plans: single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers who purchase annual memberships are Cyclistic members.

Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the pricing flexibility helps Cyclistic attract more customers,
Moreno (the director of marketing and my manager) believes that maximizing the number of annual members will be key to future growth. Rather than creating a marketing campaign that
targets all new customers, Moreno believes there is a very good chance to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic program 
and have chosen Cyclistic for their mobility needs.

Moreno has set a clear goal: ***Design marketing strategies aimed at converting casual riders into annual members***. To do that, however, the marketing analyst team needs to 
better understand how annual members and casual riders differ, why casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are interested in analyzing the Cyclistic historical bike trip data to identify trends.



***Questions to answer***

- How do annual members and casual riders use Cyclistic bikes differently?
- Why would casual riders buy Cyclistic annual memberships?
- How can Cyclistic use digital media to influence casual riders to become members?

***Project Deliverables***

- *Data Analysis Report*: A comprehensive report analyzing the differences in behavior between annual members and casual riders based on Cyclistic historical bike trip data. This report will include insights into usage patterns, trip durations, popular routes, and frequency of bike usage for each user group.

- *Professional Data Visualizations*: A series of visually compelling data visualizations, including charts and graphs illustrating key findings from the analysis. These visualizations will provide stakeholders with clear and concise insights into the differences between annual members and casual riders, aiding in decision-making.

- *Marketing Strategy Recommendations*: A set of data-driven marketing strategy recommendations aimed at converting casual riders into annual members. These recommendations will be supported by the insights gained from the data analysis and will outline actionable steps for targeting casual riders through digital media and other marketing channels.


***Expected Results***

- *Identification of Usage Patterns*: The data analysis will reveal distinct usage patterns between annual members and casual riders, such as peak usage times, preferred bike types, and trip purposes. This will provide Cyclistic with valuable insights into the different needs and preferences of each user group.

- *Insights into Motivation for Membership*: By analyzing trip data and customer behavior, the project will uncover the reasons why casual riders may choose to purchase annual memberships. Understanding these motivations will enable Cyclistic to tailor marketing messages and incentives to effectively encourage conversion.

- *Optimized Digital Media Strategies*: The analysis will highlight opportunities for using digital media to influence casual riders to become members. By identifying the most effective channels, messaging, and targeting strategies, Cyclistic will be equipped to implement targeted digital marketing campaigns aimed at converting casual riders into annual members.


**DATA SOURCE**

I will use Cyclistic’s historical trip data to analyze and identify trends from Jan 2022 to Dec 2022 which can be downloaded from https://divvy-tripdata.s3.amazonaws.com/index.html.


**DATA ORGANIZATION**

I will be using SQL to explore, combine, organize, clean, clean, and analyze the dataset.

There are 11 CSV files with the naming convention of ```YYYY-MM-divvy-tripdata``` and each file contains data for one month.

This table provides a clear overview of the column names and their corresponding descriptions, making it easier for users to understand the dataset structure.


| Column Name       | Description                                                                   |
|-------------------|-------------------------------------------------------------------------------|
| ride_id           | Unique identifier for each ride                                               |
| rideable_type     | Type of bike used for the ride (e.g., electric bike, classic bike)            |
| started_at        | Date and time when the ride started                                           |
| ended_at          | Date and time when the ride ended                                             |
| start_station_name| Name of the station where the ride started                                    |
| start_station_id  | Unique identifier for the station where the ride started                      |
| end_station_name  | Name of the station where the ride ended                                      |
| end_station_id    | Unique identifier for the station where the ride ended                        |
| start_lat         | Latitude of the start station                                                  |
| start_lng         | Longitude of the start station                                                 |
| end_lat           | Latitude of the end station                                                    |
| end_lng           | Longitude of the end station                                                   |
| member_casual     | Indicates whether the rider is a member or a casual rider (member/casual)     |
| ride_length       | Duration of the ride in minutes                                                |
| month_of_ride     | Month when the ride took place                                                 |
| day_of_ride       | Day of the week when the ride took place                                       |
| hour_of_the_day   | Hour of the day when the ride started                                          |


**DATA COMBINATION**

The 11 CSV files were successfully uploaded to the SQL database and merged into a single table, ```trip_data```,  consolidating the yearly data. Utilizing the ```CREATE TABLE``` function, I created a table with 17 columns, specifying the data type that each column will hold to ensure accurate data representation and integrity within the database.

```CREATE TABLE trip_data(
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
```

After the ```trip_data``` table was created, data from the 11 CSV files was inserted into it using the ```UNION ALL``` function. This function combines the results of multiple ```SELECT``` statements into a single result set, retaining all rows from each ```SELECT``` statement and resulting in a combined dataset containing 5,495,803.

```
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
```

To resolve the inconsistency in data types between the ```station_station_id``` column stored as ```nvarchar(255)``` in the dataset and as ```float``` in tables 3 and 5, along with the
```end_station_id``` column in table 5, which prevented unioning with the rest of the tables, I utilized the ```CAST``` function.

The ```CAST``` function is used to convert an expression of one data type to another. In this context, I employed it to convert the float data type to ```nvarchar(255)```. 

**DATA EXPLORATION**

Before cleaning the data, I familiarized myself with the data to identify if there were any nulls and duplicates and to get an insight of the data stored in each column.

***Checking for Nulls***

In this code, the ```COUNT``` function is used to check for null values in each column of the ```trip_data``` table.
```
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
```
The following table shows the number of null values in each column.

| ride_id | rideable_type | started_at | end_at | start_station_name | start_station_id | end_station_name | end_station_id | start_lat | start_lng | end_lat | end_lng | member_casual |
|---------|---------------|------------|--------|--------------------|------------------|------------------|----------------|-----------|-----------|---------|---------|---------------|
|    0    |       0       |      0     |   0    |      840006        |      1241364     |      891278      |     1167777    |     0     |     0     |   6751  |   6751  |       0       |


Note that the ```end_lat``` and the ```end_lng``` columns have the same number of missing values. This may be due to missing information in the same row.

The null values that are in each column will be excluded from the new clean dataset that will be used for analysis.


***Checking for Duplicates***

As ```ride_id``` has no null values, I used it to check for duplicates.

```
Select COUNT(ride_id)-COUNT(DISTINCT ride_id) as Duplicate_rows
From trip_data
```
```COUNT(ride_id)``` function returns the total number of rows in the ```ride_id``` column and ```COUNT(DISTINCT ride_id)``` returns the count of unique values in the ```ride_id``` column by eliminating duplicate values.

| Duplicate_rows |
|----------------|
|       0        |

There are no duplicate rows in the data.

***Checking Types of Bikes***

There are 3 unique types of bikes(rideable_type) in our data.

| rideable_type |
|---------------|
| electric_bike |
| classic_bike  |
| docked_bike   |

***Trip Duration***

- Trips lasting under a minute are likely indicative of system errors or test rides rather than genuine user activity, providing little meaningful insight into user behavior. 

```
Select started_at, ended_at, DATEDIFF(minute, started_at, ended_at) as time_difference
From trip_data
Where DATEDIFF(minute, started_at, ended_at) < 1;
```

There are a total of ```86,315``` trips that lasted for less than a minute in the data set that will be dropped when creating the clean table for analysis.

- On the other hand, trips lasting more than a day are outliers that are unlikely to represent typical usage patterns, skewing the analysis and potentially leading to inaccurate conclusions.

```
Select started_at, ended_at, DATEDIFF(minute, started_at, ended_at) as time_difference
From trip_data
Where DATEDIFF(minute, started_at, ended_at) > 1440;
```
There are a total of ```6,154``` trips that lasted more than a day in the data set that will be dropped when creating the clean table for analysis.

- The ```started_at``` and ```ended_at``` show the start and end time of the trip in ```YYYY-MM-DD hh:mm: ss UTC``` format. A new column, ```ride_length``, which will be in minutes will be created to find the total trip duration. 

- Other columns ```day_of_ride```, ```hour_of_the_ride``` and ```month_of_ride``` will also be helpful in the analysis of trips at different times of the year.

***Type of Rider***

member_casual column has 2 unique values classifying the riders as either member or ccasual.

| member_casual |
|---------------|
|    3488296    |
|    2007507    |



**DATA CLEANING**

***Getting the time difference excluding the ones > 24 hours and < 1 minute***

I utilized the ```DATEDIFF``` function to calculate the length of each ride in minutes by subtracting the ```started_at``` timestamp from the ```ended_at``` timestamp.
Additionally, the ```WHERE``` clause filters the results to include only rides that lasted between 1 minute and 1440 minutes (24 hours), ensuring that only meaningful ride lengths are considered for analysis.

```
Select started_at, ended_at, DATEDIFF(minute, started_at, ended_at) as ride_length
From trip_data
Where DATEDIFF(minute, started_at, ended_at) <= 1440 AND DATEDIFF(minute, started_at, ended_at) >= 1;
```

***Getting the day and month when the trip was made***

The ```DATENAME``` function helped in extracting the ```day, month```, and ```hour of the day``` from the ```started_at``` timestamp by specifying 'day', 'month', and 'hour' as the datepart parameter.


- *Day*

```
Select started_at, DATENAME(weekday, started_at) as day_of_ride
From trip_data
```

- *Month*

```
Select started_at, DATENAME(month, started_at) as month_of_ride
From trip_data
```

- *Getting the hour of the day when the ride took place*

```
Select started_at, DATENAME(hour, started_at) as hour_of_the_day
From trip_data
```

**DATA FORMATTING**

***Adding ride_length, day_of_ride, month_of_ride and hour_of_the_day columns to the trip_data table***

The ```ALTER TABLE``` function was used to add four new columns ```(ride_length, day_of_ride, month_of_ride, hour_of_the_day)``` to the trip_data table, specifying their data types. 

Then, the ```UPDATE``` function was utilized to populate these new columns with data derived from existing columns.


- *ride_length*

```
ALTER TABLE trip_data
Add ride_length int;

UPDATE trip_data
Set ride_length = DATEDIFF(minute, started_at, ended_at)

```

- *day_of_ride*

```
ALTER TABLE trip_data
ADD day_of_ride nvarchar(255);

UPDATE trip_data
Set day_of_ride = DATENAME(weekday, started_at)
```

- *month_of_ride*

```
ALTER TABLE trip_data
ADD month_of_ride nvarchar(255);

UPDATE trip_data
Set month_of_ride = DATENAME(month, started_at)
```

- *hour_of_the_day*

```
ALTER TABLE trip_data
ADD hour_of_the_day int;

UPDATE trip_data
Set hour_of_the_day = DATENAME(hour, started_at)

```


***Creating a new table, with clean data***

After formatting the data, I created a new table, ```yearly_bike_data```, intended for analysis purposes. This table comprises clean data, including the new four columns, ride_length, day_of_ride, month_of_ride, hour_of_the_day, and excluding all null values, trips lasting more than a day, and trips lasting less than a minute. 

I adopt the practice of avoiding the deletion of data from the main table during project work to maintain data integrity. This ensures that critical information remains intact, allowing for further analysis without the risk of losing or altering essential columns in the main dataset.

```
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
```

I now had clean data ready for data analysis.


**DATA ANALYSIS**

For the first part of the analysis, the question that the data will be answering is;
***How do annual members and casual riders use Cyclistic bikes differently?***

***1. Number of rides made by member and casual riders***

This code retrieves data from the ```yearly_bike_data``` table, counts the number of riders for each combination of ```rideable_type``` and ```member_casual```, and then organizes the results by rideable_type.

```
Select rideable_type, member_casual, COUNT(member_casual) as riders
From yearly_bike_data
Group by rideable_type, member_casual
Order by rideable_type
```

| rideable_type | member_casual | riders  |
|---------------|---------------|---------|
| classic_bike  | member        | 1526173 |
| classic_bike  | casual        | 768586  |
| docked_bike   | casual        | 66123   |
| electric_bike | member        | 800675  |
| electric_bike | casual        | 495713  |


![226692931-ecd2eb32-ffce-481a-b3c2-a6c3b4f3ceb7](https://github.com/tabby1307/Cyclist_Bike_Share_Project/assets/112205355/c7fec0c2-1920-4836-ae05-395a343c7077)


*Summary of the ridership data*

- The members make up 59.7% of the total while the remaining 40.3% constitute casual riders. 
- Each bike-type chart shows a percentage of the total. 
- The most used bike is the classic bike followed by the electric bike. Docked bikes are used the least by casual riders.


***2. Total number of trips distributed by the months, days of the week, and hours of the day***

- *Months*

This code provides a breakdown of the ```total number of rides for each month```, categorized by member type (member or casual), allowing for analysis of ridership trends over time.

```
Select month_of_ride, member_casual, COUNT(ride_id) as total_rides
From yearly_bike_data
Group by month_of_ride, member_casual
Order by month_of_ride
```
 
| month_of_ride | member_casual | total_rides |
|---------------|---------------|-------------|
| January       | member        | 116,718     |
| January       | casual        | 29,276      |
| February      | member        | 114,895     |
| February      | casual        | 32,407      |
| March         | member        | 64,394      |
| March         | casual        | 22,221      |
| April         | member        | 209,412     |
| April         | casual        | 109,147     |
| May           | member        | 60,594      |
| May           | casual        | 49,141      |
| June          | member        | 311,311     |
| June          | casual        | 217,570     |
| July          | member        | 324,733     |
| July          | casual        | 242,893     |
| August        | member        | 347,064     |
| August        | casual        | 231,783     |
| September     | member        | 306,421     |
| September     | casual        | 195,284     |
| October       | member        | 270,642     |
| October       | casual        | 129,178     |
| November      | member        | 200,664     |
| November      | casual        | 71,522      |
                                 


![230122705-2f157258-e673-4fc5-bbed-88050b6aae68 (1)](https://github.com/tabby1307/Cyclist_Bike_Share_Project/assets/112205355/b4a02fe5-b3e3-4d72-8f16-ff81e99deac7)


*Summary of findings*

- January, February, and March represent winter months, characterized by lower ridership, while May, June, July, and August are summer months with higher ridership, especially among members who may use bikes for recreational purposes.

- Similarly, the transitional months of April, September, October, and November exhibit varying ridership levels as weather conditions shift between seasons.

- *Day of the week*

This code provides a breakdown of the ```total number of rides for each day of the week```, categorized by member type (member or casual).

```
Select day_of_ride, member_casual, COUNT(ride_id) as total_rides
From yearly_bike_data
Group by day_of_ride, member_casual
Order by day_of_ride
```

|   Day     | Member/Casual | Total Rides |
|-----------|---------------|-------------|
|  Monday   |     Member    |   323,981   |
|  Monday   |     Casual    |   151,888   |
|  Tuesday  |     Member    |   369,561   |
|  Tuesday  |     Casual    |   154,344   |
| Wednesday |     Member    |   367,526   |
| Wednesday |     Casual    |   154,872   |
|  Thursday |     Member    |   376,054   |
|  Thursday |     Casual    |   172,338   |
|   Friday  |     Member    |   333,650   |
|   Friday  |     Casual    |   200,435   |
| Saturday  |     Member    |   297,107   |
| Saturday  |     Casual    |   275,580   |
|   Sunday  |     Member    |   258,969   |
|   Sunday  |     Casual    |   220,965   |


![230122705-2f157258-e673-4fc5-bbed-88050b6aae68 (2)](https://github.com/tabby1307/Cyclist_Bike_Share_Project/assets/112205355/0adbb102-6910-4005-a75d-a89b3f4c4033)

*Summary of findings*

- Analyzing these patterns, I observed correlations between working hours and weekends. For instance, higher ridership among members is seen on weekdays such as Monday, Tuesday, and Thursday, suggesting regular commuting patterns. Conversely, weekends, especially Saturday and Sunday, exhibit higher ridership among casual riders, indicating leisure or recreational use.

- Additionally, midweek ridership remains relatively consistent, likely reflecting a mix of commuting and leisure activities.
  

- *Hour of the day*

This code provides insights into the ```total ride length in minutes for each hour of the day```, categorized by member type (member or casual)

```
Select member_casual, hour_of_the_day, SUM(ride_length) as avg_ride_length
From yearly_bike_data
Group by hour_of_the_day, member_casual
Order by hour_of_the_day
```
| member_casual | hour_of_the_day | avg_ride_length |
|---------------|-----------------|-----------------|
| member        | 0               | 2,381,666       |
| casual        | 0               | 4,631,300       |
| casual        | 1               | 2,994,250       |
| member        | 1               | 1,426,800       |
| casual        | 2               | 1,749,500       |
| member        | 2               | 811,640         |
| casual        | 3               | 884,270         |
| member        | 3               | 53,602          |
| member        | 4               | 60,002          |
| casual        | 4               | 59,672          |
| member        | 5               | 227,652         |
| casual        | 5               | 107,336         |
| member        | 6               | 748,576         |
| casual        | 6               | 317,655         |
| casual        | 7               | 512,600         |
| member        | 7               | 1,449,456       |
| member        | 8               | 1,806,208       |
| casual        | 8               | 788,931         |
| member        | 9               | 1,204,355       |
| casual        | 9               | 1,080,780       |
| member        | 10              | 1,159,493       |
| casual        | 10              | 1,595,868       |
| member        | 11              | 1,390,488       |
| casual        | 11              | 2,076,460       |
| casual        | 12              | 2,372,439       |
| member        | 12              | 1,571,765       |
| member        | 13              | 1,538,764       |
| casual        | 13              | 2,437,417       |
| casual        | 14              | 2,533,929       |
| member        | 14              | 1,616,663       |
| casual        | 15              | 2,594,506       |
| member        | 15              | 1,974,082       |
| casual        | 16              | 2,728,103       |
| member        | 16              | 2,739,253       |
| casual        | 17              | 2,832,455       |
| member        | 17              | 3,323,517       |
| casual        | 18              | 2,405,145       |
| member        | 18              | 2,592,766       |
| member        |


![230122935-8d0889c3-f0ff-43ce-94ab-393f2e230bee](https://github.com/tabby1307/Cyclist_Bike_Share_Project/assets/112205355/4d613822-4077-4ef2-9fad-3756d3607274)


*Summary of findings*

- Analysis of the patterns reveals differences in riding behavior between members and casual riders throughout the day.

- Casual riders tend to have longer average ride lengths during the late morning to early evening hours, potentially indicating leisurely or recreational use, while members exhibit longer average ride lengths during peak commuting hours in the morning around 6 am TO 8 am, and evening around 4 pm to 8 pm.



***3. Average trip duration for members and casuals per month, day of the week, and hour of the day***

- *Day* 

This code provides insights into the ```average ride length for each day of the week```, categorized by member type (member or casual).

```
Select day_of_ride, member_casual, AVG(ride_length) as avg_ride_length
From yearly_bike_data
Group by day_of_ride, member_casual
Order by day_of_ride
```
| day_of_ride | member_casual | avg_ride_length |
|-------------|---------------|-----------------|
| Monday      | member        | 11              |
| Monday      | casual        | 22              |
| Tuesday     | member        | 11              |
| Tuesday     | casual        | 20              |
| Wednesday   | member        | 11              |
| Wednesday   | casual        | 19              |
| Thursday    | member        | 11              |
| Thursday    | casual        | 20              |
| Friday      | member        | 12              |
| Friday      | casual        | 22              |
| Saturday    | member        | 13              |
| Saturday    | casual        | 26              |
| Sunday      | member        | 13              |
| Sunday      | casual        | 26              |


![230164787-3ea46ee9-aa5f-486b-9dd1-8f43dfce8e1c (2)](https://github.com/tabby1307/Cyclist_Bike_Share_Project/assets/112205355/9f1adcc0-71be-465a-ac45-aba549060f8c)


- *Month*

This code provides insights into the ```average ride length for each month```, categorized by member type (member or casual).

```
Select month_of_ride, member_casual, AVG(ride_length) as avg_ride_length
From yearly_bike_data
Group by month_of_ride, member_casual
Order by month_of_ride
```

| month_of_ride | member_casual | avg_ride_length |
|---------------|---------------|-----------------|
| January       | member        | 10              |
| January       | casual        | 15              |
| February      | member        | 10              |
| February      | casual        | 17              |
| March         | member        | 10              |
| March         | casual        | 17              |
| April         | member        | 11              |
| April         | casual        | 22              |
| May           | member        | 13              |
| May           | casual        | 27              |
| June          | member        | 13              |
| June          | casual        | 24              |
| July          | member        | 13              |
| July          | casual        | 25              |
| August        | member        | 13              |
| August        | casual        | 24              |
| September     | member        | 12              |
| September     | casual        | 23              |
| October       | member        | 11              |
| October       | casual        | 21              |
| November      | member        | 11              |
| November      | casual        | 17              |


![230164787-3ea46ee9-aa5f-486b-9dd1-8f43dfce8e1c (1) (1)](https://github.com/tabby1307/Cyclist_Bike_Share_Project/assets/112205355/3cd6d68a-f7a7-4d3a-9066-b690d5513045)


- *Hour of the day*

This code provides insights into the ```average ride length for each hour of the day```, categorized by member type (member or casual).

```
Select hour_of_the_day, member_casual, AVG(ride_length) as avg_ride_length
From yearly_bike_data
Group by hour_of_the_day, member_casual
Order by member_casual DESC
```

| hour_of_the_day | member_casual | avg_ride_length |
|-----------------|---------------|-----------------|
| 0               | member        | 11              |
| 0               | casual        | 21              |
| 1               | casual        | 21              |
| 1               | member        | 12              |
| 2               | casual        | 21              |
| 2               | member        | 12              |
| 3               | casual        | 21              |
| 3               | member        | 13              |
| 4               | member        | 12              |
| 4               | casual        | 18              |
| 5               | member        | 10              |
| 5               | casual        | 15              |
| 6               | member        | 10              |
| 6               | casual        | 16              |
| 7               | casual        | 15              |
| 7               | member        | 11              |
| 8               | member        | 11              |
| 8               | casual        | 17              |
| 9               | member        | 11              |
| 9               | casual        | 23              |
| 10              | member        | 12              |
| 10              | casual        | 27              |
| 11              | member        | 12              |
| 11              | casual        | 28              |
| 12              | casual        | 27              |
| 12              | member        | 12              |
| 13              | member        | 12              |
| 13              | casual        | 26              |
| 14              | casual        | 26              |
| 14              | member        | 12              |
| 15              | casual        | 25              |
| 15              | member        | 12              |
| 16              | casual        | 22              |
| 16              | member        | 12              |
| 17              | casual        | 21              |
| 17              | member        | 13              |
| 18              | casual        | 21              |
| 18              | member        | 13              |
| 19              | member        | 12              |
| 19              | casual        | 21              |
| 20              | casual        | 21              |
| 20              | member        | 12              |
| 21              | casual        | 20              |
| 21              | member        | 12              |
| 22              | casual        | 20              |
| 22              | member        | 12              |
| 23              | member        | 12              |
| 23              | casual        | 20              |


![230164889-1c7943d2-7ada-411b-adc7-a043eb480ba1](https://github.com/tabby1307/Cyclist_Bike_Share_Project/assets/112205355/2591583a-4e94-4507-ba03-cd43379699e3)


*Summary of findings*

- The average ride length varies throughout the day, with casual riders generally taking longer trips compared to members during all hours. Additionally, there are fluctuations in average ride lengths across different months, with longer rides observed during warmer months. 

- The length of the average journey for members doesn't change throughout the year, week, or day. However, there are variations in how long casual riders cycle

Overall, casual riders tend to have longer average ride lengths compared to members, regardless of the time of day or month.

***4. Starting and ending locations***

To further understand the differences between casual and member riders, the locations of ```starting``` and ```ending stations``` were analyzed. 

Stations with the most trips are considered using filters to draw out the following conclusions.

- *Starting station locations*

```
Select start_station_name, member_casual,COUNT(ride_id) as total_rides	
From yearly_bike_data
Group by start_station_name, member_casual
Order by total_rides DESC
```

![230248445-3fe69cbb-30a9-42c6-b5e8-ab433a620ff3](https://github.com/tabby1307/Cyclist_Bike_Share_Project/assets/112205355/46e1b33b-da35-49ea-9ca3-b87171ec7d48)


Casual riders have frequently started their trips from the stations in the vicinity of museums, parks, beaches, harbor points, and aquariums while members have begun their journeys from stations close to universities, residential areas, restaurants, hospitals, grocery stores, theatre, schools, banks, factories, train stations, parks and plazas.

- *Ending station locations*

```
Select end_station_name, member_casual, COUNT(ride_id) as total_rides
From yearly_bike_data
Group by end_station_name, member_casual
Order by total_rides DESC
```

![230253219-4fb8a2ed-95e3-4e52-a359-9d86945b7a75](https://github.com/tabby1307/Cyclist_Bike_Share_Project/assets/112205355/8bf392a6-8f36-4d98-a145-034f0fab333c)



A similar trend can be observed in ending station locations. Casual riders end their journey near parks, museums, and other recreational sites whereas members end their trips close to universities, residential and commercial areas. 


***Data analysis summary***

| Casual                                                                                                                   | Member                                                                                                         |
|--------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------|
| Prefer using bikes throughout the day, more frequently over the weekends in summer and spring for leisure activities.    | Prefer riding bikes on weekdays during commute hours (8 am / 5 pm) in summer and spring.                       |
| Travel 2 times longer but less frequently than members.                                                                  | Travel more frequently but shorter rides (approximately half of casual riders' trip duration).                |
| Start and end their journeys near parks, museums, along the coast, and other recreational sites.                       | Start and end their trips close to universities, residential, and commercial areas.                          |


**CONCLUSION ON BIKE USAGE ANALYSIS**

Based on the provided data, here are four overall conclusions on how members and casual riders use bikes differently:

- ***Usage Patterns***
  
Members exhibit a more consistent and regular usage pattern compared to casual riders.

This is evidenced by the higher total rides per day, hour, and month for members, indicating a greater frequency of bike usage throughout different timescales.

- ***Trip Duration*** 

Casual riders tend to have shorter average ride lengths per day, hour, and month compared to members. 

This suggests that casual riders typically use bikes for shorter, more spontaneous trips, while members may engage in longer, planned rides or use bikes for commuting purposes.

- ***Starting Location Preferences*** 

Casual riders often begin their journeys near recreational sites such as museums, parks, beaches, and aquariums, indicating a preference for leisure activities. 

In contrast, members tend to start their rides near universities, residential areas, restaurants, and commercial centers, suggesting a focus on commuting or accessing essential services and amenities.

- ***Ending Location Preferences***
  
Similar to their starting location preferences, casual riders frequently end their trips near parks, museums, and recreational sites, reinforcing their preference for leisurely activities. 

Conversely, members tend to end their rides near universities, residential areas, and commercial centers, indicating a return to familiar or essential destinations after commuting or running errands.

Overall, these conclusions highlight the distinct usage patterns and preferences of members and casual riders, with members demonstrating a more structured and commuter-oriented approach, while casual riders prioritize leisure and spontaneous trips.


**WHY WOULD CASUAL RIDERS BUY CYCLIST ANNUAL MEMBERSHIP?**

To answer the second objective question for this project, I used the data analysis findings that I had done.

- ***Convenience and Cost Savings*** 

While casual riders typically prefer starting and ending their trips at recreational spots, they may find that having an annual membership offers them convenience and cost savings, especially if they frequently use the service during peak hours or months. 

By having a membership, they can avoid the hassle of purchasing single passes each time they ride, and they may benefit from discounted rates or bundled pricing options, making it more economical for them in the long run.

- ***Access to Additional Benefits*** 

Cyclistic may offer additional benefits or perks to annual members beyond just access to the bikes. 

These could include things like priority access to certain bikes or stations, special events or promotions, or partnerships with local businesses or attractions. Casual riders who enjoy the flexibility of riding to recreational sites may still find value in these membership perks, especially if they also use the bikes for other purposes like commuting or running errands.



**ACT**

In this section, I answered the third objective question;
***How can Cyclistic use digital media to influence casual riders to become members?***


 - ***Targeted Social Media Campaigns***
 
 Cyclistic can leverage digital media platforms like Facebook, Instagram, and Twitter to run targeted advertising campaigns.
 
Ads can highlight the benefits of membership, such as exclusive access to bikes near universities, residential areas, and commercial centers, areas where casual riders often
 start and end their trips.

- ***Personalized Email Marketing***
  
Cyclistic can send personalized email campaigns to casual riders based on their ride patterns, emphasizing the convenience and cost-effectiveness of membership for frequent riders. By showcasing how members can easily access bikes near popular recreational spots like parks and museums, Cyclistic can encourage casual riders to make the switch.

- ***In-App Promotions and Rewards***
  
Cyclistic's mobile app can feature special promotions and rewards exclusively for casual riders who convert to members. 

For example, offering discounts on membership fees or free ride credits for completing a certain number of rides can incentivize casual riders to become members.

Additionally, highlighting member-exclusive starting and ending locations, such as near universities and commercial areas, can further encourage conversion.

After identifying the differences between casual and member riders, marketing strategies to target casual riders can be developed to persuade them to become members.
Recommendations:

