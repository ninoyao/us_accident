DROP DATABASE IF EXISTS accidents;

CREATE DATABASE accidents;

USE accidents;

#before loading database go preferences -> SQL Editor and change DBMS connection read time out (in seconds): 300
# https://jeffreyeverhart.com/2017/11/04/mysql-workbench-error-code-2013-lost-connection-mysql-server-query/

DROP TABLE IF EXISTS master_table;
CREATE TABLE master_table(
`X1` VARCHAR(50),
`ID` VARCHAR(50) PRIMARY KEY,
`Source` VARCHAR(20),
`TMC` INT NULL , #SHOULD BE A NUMBER
`Severity` INT(2),
`Start_Time` DATETIME,
`End_Time` DATETIME,
`Start_Lat` DECIMAL(10,6) ,
`Start_Lng` DECIMAL(10,6) ,
`End_Lat` DECIMAL(10,6) DEFAULT NULL,
`End_Lng` VARCHAR(50) DEFAULT NULL,
`Distance(mi)` DECIMAL (8,2) ,
`Description` BLOB,
`Number` INT NULL , #SHOULD BE A NUMBER 
`Street` VARCHAR(120),
`Side` VARCHAR(10),
`City` VARCHAR(50),
`County` VARCHAR(100),
`State` VARCHAR(10),
`Zipcode` VARCHAR(15),
`Country` VARCHAR(200),
`Timezone` VARCHAR(20),
`Airport_Code` VARCHAR(6),
`Weather_Timestamp` DATETIME NULL,#SHOULD BE A DATETIME
`Temperature(F)` DECIMAL(5,2) NULL, #SHOULD BE A NUMBER
`Wind_Chill(F)` DECIMAL(4,2) NULL , #SHOULD BE A NUMBER
`Humidity(%)` DECIMAL(5,2) NULL  , #SHOULD BE A NUMBER
`Pressure(in)` DECIMAL(4,2) NULL  , #SHOULD BE A NUMBER
`Visibility(mi)` DECIMAL(4,2) NULL  , #SHOULD BE A NUMBER
`Wind_Direction` VARCHAR(20) NULL,
`Wind_Speed(mph)` DECIMAL(4,2) NULL , #SHOULD BE A NUMBER
`Precipitation(in)` DECIMAL(4,2) NULL  , #SHOULD BE A NUMBER
`Weather_Condition` VARCHAR(50) NULL,
`Amenity` SET('True', 'False') , #SHOULD BE A BOOL VALUE
`Bump` SET('True', 'False')  , #SHOULD BE A BOOL VALUE
`Crossing` SET('True', 'False')  , #SHOULD BE A BOOL VALUE
`Give_Way` SET('True', 'False')  , #SHOULD BE A BOOL VALUE
`Junction` SET('True', 'False')  , #SHOULD BE A BOOL VALUE
`No_Exit` SET('True', 'False')  , #SHOULD BE A BOOL VALUE
`Railway` SET('True', 'False')  , #SHOULD BE A BOOL VALUE
`Roundabout` SET('True', 'False')  , #SHOULD BE A BOOL VALUE
`Station` SET('True', 'False')  , #SHOULD BE A BOOL VALUE
`Stop` SET('True', 'False')  , #SHOULD BE A BOOL VALUE
`Traffic_Calming` SET('True', 'False')  , #SHOULD BE A BOOL VALUE
`Traffic_Signal` SET('True', 'False')  , #SHOULD BE A BOOL VALUE
`Turning_Loop` SET('True', 'False')  , #SHOULD BE A BOOL VALUE
`Sunrise_Sunset` VARCHAR(100),
`Civil_Twilight` VARCHAR(100),
`Nautical_Twilight` VARCHAR(100),
`Astronomical_Twilight` VARCHAR(100)
);

ALTER TABLE `accidents`.`master_table` 
ENGINE = InnoDB ;
#LOAD DATA LOCAL INFILE '/Users/linh/Documents/Vanderbilt/Spring2020/DMS_5420/Project2/US_Accidents_Dec19.csv'

LOAD DATA INFILE 'C:\\Users\\ninoy\\Desktop\\VandyDS\\2020spring\\dbms\\us_accident\\accident_na.csv'
INTO TABLE master_table
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;

SELECT * FROM master_table LIMIT 1000;
