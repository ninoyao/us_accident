DROP DATABASE IF EXISTS accidents;

CREATE DATABASE accidents;

USE accidents;

#before loading database go preferences -> SQL Editor and change DBMS connection read time out (in seconds): 300
# https://jeffreyeverhart.com/2017/11/04/mysql-workbench-error-code-2013-lost-connection-mysql-server-query/

CREATE TABLE master_table(
`ID` VARCHAR(50) PRIMARY KEY,
`Source` VARCHAR(20),
`TMC` VARCHAR(10) , #SHOULD BE A NUMBER
`Severity` INT(2),
`Start_Time` DATETIME,
`End_Time` DATETIME,
`Start_Lat` DECIMAL(10,6) ,
`Start_Lng` DECIMAL(10,6) ,
`End_Lat` VARCHAR(120) ,
`End_Lng` VARCHAR(120) ,
`Distance(mi)` DECIMAL (8,2) ,
`Description` BLOB,
`Number` VARCHAR(10), #SHOULD BE A NUMBER 
`Street` VARCHAR(120),
`Side` VARCHAR(2),
`City` VARCHAR(50),
`County` VARCHAR(50),
`State` VARCHAR(10),
`Zipcode` VARCHAR(15),
`Country` VARCHAR(2),
`Timezone` VARCHAR(20),
`Airport_Code` VARCHAR(6),
`Weather_Timestamp` VARCHAR(20),#SHOULD BE A DATETIME
`Temperature(F)` VARCHAR(10) , #SHOULD BE A NUMBER
`Wind_Chill(F)` VARCHAR(10) , #SHOULD BE A NUMBER
`Humidity(%)` VARCHAR(10) , #SHOULD BE A NUMBER
`Pressure(in)` VARCHAR(10) , #SHOULD BE A NUMBER
`Visibility(mi)` VARCHAR(10) , #SHOULD BE A NUMBER
`Wind_Direction` VARCHAR(20),
`Wind_Speed(mph)` VARCHAR(10) , #SHOULD BE A NUMBER
`Precipitation(in)` VARCHAR(10) , #SHOULD BE A NUMBER
`Weather_Condition` VARCHAR(50),
`Amenity` VARCHAR(10) , #SHOULD BE A BOOL VALUE
`Bump` VARCHAR(10) , #SHOULD BE A BOOL VALUE
`Crossing` VARCHAR(10) , #SHOULD BE A BOOL VALUE
`Give_Way` VARCHAR(10) , #SHOULD BE A BOOL VALUE
`Junction` VARCHAR(10) , #SHOULD BE A BOOL VALUE
`No_Exit` VARCHAR(10) , #SHOULD BE A BOOL VALUE
`Railway` VARCHAR(10) , #SHOULD BE A BOOL VALUE
`Roundabout` VARCHAR(10) , #SHOULD BE A BOOL VALUE
`Station` VARCHAR(10) , #SHOULD BE A BOOL VALUE
`Stop` VARCHAR(10) , #SHOULD BE A BOOL VALUE
`Traffic_Calming` VARCHAR(10) , #SHOULD BE A BOOL VALUE
`Traffic_Signal` VARCHAR(10) , #SHOULD BE A BOOL VALUE
`Turning_Loop` VARCHAR(10) , #SHOULD BE A BOOL VALUE
`Sunrise_Sunset` VARCHAR(6),
`Civil_Twilight` VARCHAR(6),
`Nautical_Twilight` VARCHAR(6),
`Astronomical_Twilight` VARCHAR(6)
);

LOAD DATA INFILE 'C:\\Users\\ninoy\\Desktop\\VandyDS\\2020spring\\dbms\\US_Accidents_Dec19.csv'
INTO TABLE master_table
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;

SELECT * FROM master_table LIMIT 1000;
