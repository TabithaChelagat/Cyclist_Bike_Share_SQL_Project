PROJECT SUMMARY

I am assuming to be a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s 
future success depends on maximizing the number of annual memberships. Therefore, my team wants to understand how casual riders and annual members use Cyclistic bikes differently. 
From these insights, my team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve our recommendations, 
so they must be backed up with compelling data insights and professional data visualizations.


Background

Cyclistic, a bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic sets itself apart by also offering reclining bikes, hand tricycles, and cargo 
bikes, making bike-share more inclusive to people with disabilities and riders who can’t use a standard two-wheeled bike. The majority of riders opt for traditional bikes; about 8% of
riders use the assistive options. Cyclistic users are more likely to ride for leisure, but about 30% use them to commute to work each day.

Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments. What helped make these things possible was 
the flexibility of its pricing plans: single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers who purchase annual memberships are Cyclistic members.

Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the pricing flexibility helps Cyclistic attract more customers,
Moreno (the director of marketing and my manager) believes that maximizing the number of annual members will be key to future growth. Rather than creating a marketing campaign that
targets all-new customers, Moreno believes there is a very good chance to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic program 
and have chosen Cyclistic for their mobility needs.

Moreno has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members. In order to do that, however, the marketing analyst team needs to 
better understand how annual members and casual riders differ, why casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are interested in analyzing the Cyclistic historical bike trip data to identify trends.



QUESIONS TO ANSWER

- How do annual members and casual riders use Cyclistic bikes differently?
- Why would casual riders buy Cyclistic annual memberships?
- How can Cyclistic use digital media to influence casual riders to become members?

Project Deliverables:

Data Analysis Report: A comprehensive report analyzing the differences in behavior between annual members and casual riders based on Cyclistic historical bike trip data. This report will include insights into usage patterns, trip durations, popular routes, and frequency of bike usage for each user group.

Professional Data Visualizations: A series of visually compelling data visualizations, including charts, graphs, and interactive dashboards, illustrating key findings from the analysis. These visualizations will provide stakeholders with clear and concise insights into the differences between annual members and casual riders, aiding in decision-making.

Marketing Strategy Recommendations: A set of data-driven marketing strategy recommendations aimed at converting casual riders into annual members. These recommendations will be supported by the insights gained from the data analysis and will outline actionable steps for targeting casual riders through digital media and other marketing channels.

Expected Results:

Identification of Usage Patterns: The data analysis will reveal distinct usage patterns between annual members and casual riders, such as peak usage times, preferred bike types, and trip purposes. This will provide Cyclistic with valuable insights into the different needs and preferences of each user group.

Insights into Motivation for Membership: By analyzing trip data and customer behavior, the project will uncover the reasons why casual riders may choose to purchase annual memberships. Understanding these motivations will enable Cyclistic to tailor marketing messages and incentives to effectively encourage conversion.

Optimized Digital Media Strategies: The analysis will highlight opportunities for using digital media to influence casual riders to become members. By identifying the most effective channels, messaging, and targeting strategies, Cyclistic will be equipped to implement targeted digital marketing campaigns aimed at converting casual riders into annual members.



DATA SOURCE

I will use Cyclistic’s historical trip data to analyze and identify trends from Jan 2022 to Dec 2022 which can be downloaded from https://divvy-tripdata.s3.amazonaws.com/index.html.

DATA ANALYSIS

I will be using SQL to explore, organize, clean, and analyze the dataset.

Data Organization

There are 12 CSV files with the naming convention of YYYY-MM-divvy-tripdata and each file contains data for one month including;


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

This table provides a clear overview of the column names and their corresponding descriptions, making it easier for users to understand the dataset structure.

Data Combination

The 12 CSV files were successfully uploaded to the SQL database and merged into a single table, trip_data,  consolidating the yearly data. Utilizing the ```CREATE TABLE``` function, 
I created a table with 17 columns, specifying the data type that each column will hold to ensure accurate data representation and integrity within the database.

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

After the ```trip_data``` table was created, data from the 12 CSV files was inserted into it using the ```UNION ALL``` function. This function combines the results of multiple ```SELECT``` 
statements into a single result set, retaining all rows from each SELECT statement and resulting in a combined dataset containing 5,495,803.

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

To resolve the inconsistency in data types between the ```station_station_id``` column stored as ```nvarchar(255)``` in our dataset and as ```float``` in tables 3 and 5, along with the
```end_station_id``` column in table 5, which prevented unioning with the rest of the tables, I utilized the ```CAST``` function.

The ```CAST``` function is used to convert an expression of one data type to another. In this context, I employed it to convert the float data type to ```nvarchar(255)```. 

DATA EXPLORATION

Before cleaning the data, I familiarized myself with the data to identify if there were any nulls and duplicates.

Checking for nulls

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


Note that the end_lat and the end_lng columns have the same number of missing values. This may be due to missing information in the same row.

The null values of the different columns will be excluded from the new clean dataset that will be used for analysis.


Checking for duplicates

As ride_id has no null values, let's use it to check for duplicates.

```
Select COUNT(ride_id)-COUNT(DISTINCT ride_id) as Duplicate_rows
From trip_data
```
COUNT(ride_id) function returns the total number of rows in the ride_id column and COUNT(DISTINCT ride_id) returns the count of unique values in the ride_id column by eliminating duplicate values.

| Duplicate_rows |
|----------------|
|       0        |

There are no duplicate rows in the data.

Checking types of bikes

There are 3 unique types of bikes(rideable_type) in our data.

| rideable_type |
|---------------|
| electric_bike |
| classic_bike  |
| docked_bike   |

Trip duration 

Trips lasting under a minute are likely indicative of system errors or test rides rather than genuine user activity, providing little meaningful insight into user behavior. 

```
Select started_at, ended_at, DATEDIFF(minute, started_at, ended_at) as time_difference
From trip_data
Where DATEDIFF(minute, started_at, ended_at) < 1;
```

There are a total of 86,315 trips that lasted for less than a minute in the data set that will be dropped when creating the clean table for analysis.

On the other hand, trips lasting more than a day are outliers that are unlikely to represent typical usage patterns, skewing the analysis and potentially leading to inaccurate conclusions.

```Select started_at, ended_at, DATEDIFF(minute, started_at, ended_at) as time_difference
From trip_data
Where DATEDIFF(minute, started_at, ended_at) > 1440;
```
There are a total of 6,154 trips that lasted more than a day in the data set that will be dropped when creating the clean table for analysis.

The started_at and ended_at show the start and end time of the trip in YYYY-MM-DD hh:mm: ss UTC format. A new column, ```ride_length``, which will be in minutes will be created to find the
total trip duration. 

Other columns ```day_of_ride```, ``hour_of_the_ride``` and ````month_of_ride``` will also be helpful in the analysis of trips at different times of the year.

Type of rider

member_casual column has 2 unique values classifying the riders as either member or ccasual.

| member_casual |
|---------------|
|    3488296    |
|    2007507    |



DATA CLEANING

Getting the time difference excluding the ones > 24 hours and < 1 minute

```
Select started_at, ended_at, DATEDIFF(minute, started_at, ended_at) as ride_length
From trip_data
Where DATEDIFF(minute, started_at, ended_at) <= 1440 AND DATEDIFF(minute, started_at, ended_at) >= 1;
```

I utilized the ```DATEDIFF``` function to calculate the length of each ride in minutes by subtracting the started_at timestamp from the ended_at timestamp.
Additionally, the ```WHERE``` clause filters the results to include only rides that lasted between 1 minute and 1440 minutes (24 hours), ensuring that only meaningful ride lengths are considered for analysis.

Getting the day and month when the trip was made

Day

```
Select started_at, DATENAME(weekday, started_at) as day_of_ride
From trip_data
```

Month

```
Select started_at, DATENAME(month, started_at) as month_of_ride
From trip_data
```

Getting the hour of the day when the ride took place

```
Select started_at, DATENAME(hour, started_at) as hour_of_the_day
From trip_data
```
The ```DATENAME``` function helped in extracting the day, month and hour of the day from the started_at timestamp by specifying 'day', 'month', and 'hour' as the datepart parameter.


Adding ride_length, day_of_ride, month_of_ride and hour_of_the_day columns to the trip_data table.

ride_length

```

```

day_of_ride

```

```

month_of_ride

```

```

hour_of_the_day

```

```



Analyze and Share
SQL Query: Data Analysis
Data Visualization: Tableau
The data is stored appropriately and is now prepared for analysis. I queried multiple relevant tables for the analysis and visualized them in Tableau.
The analysis question is: How do annual members and casual riders use Cyclistic bikes differently?

First of all, member and casual riders are compared by the type of bikes they are using.

image

The members make 59.7% of the total while remaining 40.3% constitutes casual riders. Each bike type chart shows percentage from the total. Most used bike is classic bike followed by the electric bike. Docked bikes are used the least by only casual riders.

Next the number of trips distributed by the months, days of the week and hours of the day are examined.

image image

Months: When it comes to monthly trips, both casual and members exhibit comparable behavior, with more trips in the spring and summer and fewer in the winter. The gap between casuals and members is closest in the month of july in summmer.
Days of Week: When the days of the week are compared, it is discovered that casual riders make more journeys on the weekends while members show a decline over the weekend in contrast to the other days of the week.
Hours of the Day: The members shows 2 peaks throughout the day in terms of number of trips. One is early in the morning at around 6 am to 8 am and other is in the evening at around 4 pm to 8 pm while number of trips for casual riders increase consistently over the day till evening and then decrease afterwards.

We can infer from the previous observations that member may be using bikes for commuting to and from the work in the week days while casual riders are using bikes throughout the day, more frequently over the weekends for leisure purposes. Both are most active in summer and spring.

Ride duration of the trips are compared to find the differences in the behavior of casual and member riders.

image
image

Take note that casual riders tend to cycle longer than members do on average. The length of the average journey for members doesn't change throughout the year, week, or day. However, there are variations in how long casual riders cycle. In the spring and summer, on weekends, and from 10 am to 2 pm during the day, they travel greater distances. Between five and eight in the morning, they have brief trips.

These findings lead to the conclusion that casual commuters travel longer (approximately 2x more) but less frequently than members. They make longer journeys on weekends and during the day outside of commuting hours and in spring and summer season, so they might be doing so for recreation purposes.

To further understand the differences in casual and member riders, locations of starting and ending stations can be analysed. Stations with the most trips are considered using filters to draw out the following conclusions.

image

Casual riders have frequently started their trips from the stations in vicinity of museums, parks, beach, harbor points and aquarium while members have begun their journeys from stations close to universities, residential areas, restaurants, hospitals, grocery stores, theatre, schools, banks, factories, train stations, parks and plazas.

image

Similar trend can be observed in ending station locations. Casual riders end their journay near parks, museums and other recreational sites whereas members end their trips close to universities, residential and commmercial areas. So this proves that casual riders use bikes for leisure activities while members extensively rely on them for daily commute.

Summary:

Casual	Member
Prefer using bikes throughout the day, more frequently over the weekends in summer and spring for leisure activities.	Prefer riding bikes on week days during commute hours (8 am / 5pm) in summer and spring.
Travel 2 times longer but less frequently than members.	Travel more frequently but shorter rides (approximately half of casual riders' trip duration).
Start and end their journeys near parks, museums, along the coast and other recreational sites.	Start and end their trips close to universities, residential and commercial areas.
Act
After identifying the differences between casual and member riders, marketing strategies to target casual riders can be developed to persuade them to become members.
Recommendations:

Marketing campaigns might be conducted in spring and summer at tourist/recreational locations popular among casual riders.
Casual riders are most active on weekends and during the summer and spring, thus they may be offered seasonal or weekend-only memberships.
Casual riders use their bikes for longer durations than members. Offering discounts for longer rides may incentivize casual riders and entice members to ride for longer periods of time.
