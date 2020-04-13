DROP DATABASE IF EXISTS accidents2;

CREATE DATABASE accidents2;

USE accidents2;

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
#`End_Lat` DECIMAL(10,6) DEFAULT NULL,
#`End_Lng` DECIMAL(10,6)  DEFAULT NULL,
`Distance(mi)` DECIMAL (10,2) ,
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
#`Wind_Chill(F)` DECIMAL(5,2) NULL , #SHOULD BE A NUMBER
`Humidity(%)` DECIMAL(5,2) NULL  , #SHOULD BE A NUMBER
`Pressure(in)` DECIMAL(5,2) NULL  , #SHOULD BE A NUMBER
`Visibility(mi)` DECIMAL(5,2) NULL  , #SHOULD BE A NUMBER
`Wind_Direction` VARCHAR(20) NULL,
`Wind_Speed(mph)` DECIMAL(5,2) NULL , #SHOULD BE A NUMBER
#`Precipitation(in)` DECIMAL(5,2) NULL  , #SHOULD BE A NUMBER
`Weather_Condition` VARCHAR(50) NULL,
`Amenity` VARCHAR(13) , #SHOULD BE A BOOL VALUE
`Bump` VARCHAR(13)  , #SHOULD BE A BOOL VALUE
`Crossing` VARCHAR(13)  , #SHOULD BE A BOOL VALUE
`Give_Way` VARCHAR(13)  , #SHOULD BE A BOOL VALUE
`Junction` VARCHAR(13)  , #SHOULD BE A BOOL VALUE
`No_Exit` VARCHAR(13)  , #SHOULD BE A BOOL VALUE
`Railway` VARCHAR(13)  , #SHOULD BE A BOOL VALUE
`Roundabout` VARCHAR(13)  , #SHOULD BE A BOOL VALUE
`Station` VARCHAR(13)  , #SHOULD BE A BOOL VALUE
`Stop` VARCHAR(13)  , #SHOULD BE A BOOL VALUE
`Traffic_Calming` VARCHAR(13)  , #SHOULD BE A BOOL VALUE
`Traffic_Signal` VARCHAR(13)  , #SHOULD BE A BOOL VALUE
`Turning_Loop` VARCHAR(13)  , #SHOULD BE A BOOL VALUE
`Sunrise_Sunset` VARCHAR(100),
`Civil_Twilight` VARCHAR(100),
`Nautical_Twilight` VARCHAR(100),
`Astronomical_Twilight` VARCHAR(100)
);

/**
`Amenity` BOOL , #SHOULD BE A BOOL VALUE
`Bump` BOOL  , #SHOULD BE A BOOL VALUE
`Crossing` BOOL  , #SHOULD BE A BOOL VALUE
`Give_Way` BOOL  , #SHOULD BE A BOOL VALUE
`Junction` BOOL  , #SHOULD BE A BOOL VALUE
`No_Exit` BOOL  , #SHOULD BE A BOOL VALUE
`Railway` BOOL  , #SHOULD BE A BOOL VALUE
`Roundabout` BOOL  , #SHOULD BE A BOOL VALUE
`Station` BOOL  , #SHOULD BE A BOOL VALUE
`Stop` BOOL  , #SHOULD BE A BOOL VALUE
`Traffic_Calming` BOOL  , #SHOULD BE A BOOL VALUE
`Traffic_Signal` BOOL  , #SHOULD BE A BOOL VALUE
`Turning_Loop` BOOL  , #SHOULD BE A BOOL VALUE


**/


ALTER TABLE `accidents2`.`master_table` 
ENGINE = InnoDB ;
LOAD DATA LOCAL INFILE '/Users/linh/Documents/Vanderbilt/Spring2020/DMS_5420/Project2/accident_0402_v2.csv'

#LOAD DATA INFILE 'C:\\Users\\ninoy\\Desktop\\VandyDS\\2020spring\\dbms\\us_accident\\accident_0402_v2.csv'
INTO TABLE master_table
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;

SELECT * FROM master_table LIMIT 1000;


UPDATE master_table
SET Amenity = CASE WHEN Amenity = 'False' THEN 0 ELSE 1 END;

UPDATE master_table
SET Bump = CASE WHEN Bump = 'False' THEN 0 ELSE 1 END;

UPDATE master_table
SET Crossing = CASE WHEN Crossing = 'False' THEN 0 ELSE 1 END;

UPDATE master_table
SET Give_Way = CASE WHEN Give_Way = 'False' THEN 0 ELSE 1 END;

UPDATE master_table
SET Junction = CASE WHEN Junction = 'False' THEN 0 ELSE 1 END;

UPDATE master_table
SET No_Exit = CASE WHEN No_Exit = 'False' THEN 0 ELSE 1 END;

UPDATE master_table
SET Railway = CASE WHEN Railway = 'False' THEN 0 ELSE 1 END;

UPDATE master_table
SET Roundabout = CASE WHEN Roundabout = 'False' THEN 0 ELSE 1 END;

UPDATE master_table
SET Station = CASE WHEN Station = 'False' THEN 0 ELSE 1 END;

UPDATE master_table
SET `Stop` = CASE WHEN `Stop` = 'False' THEN 0 ELSE 1 END;

UPDATE master_table
SET Traffic_Calming = CASE WHEN Traffic_Calming = 'False' THEN 0 ELSE 1 END;

UPDATE master_table
SET Traffic_Signal = CASE WHEN Traffic_Signal = 'False' THEN 0 ELSE 1 END;

UPDATE master_table
SET Turning_Loop = CASE WHEN Turning_Loop = 'False' THEN 0 ELSE 1 END;

UPDATE master_table SET zipcode = TRIM(BOTH '"' FROM zipcode);
UPDATE master_table SET ID = TRIM(BOTH '"' FROM ID);
UPDATE master_table SET `Source` = TRIM(BOTH '"' FROM `Source`);
UPDATE master_table SET Street = TRIM(BOTH '"' FROM Street);
UPDATE master_table SET Side = TRIM(BOTH '"' FROM Side);
UPDATE master_table SET City = TRIM(BOTH '"' FROM City);
UPDATE master_table SET County = TRIM(BOTH '"' FROM Country);
UPDATE master_table SET State = TRIM(BOTH '"' FROM State);
UPDATE master_table SET Country = TRIM(BOTH '"' FROM Country);
UPDATE master_table SET Timezone = TRIM(BOTH '"' FROM Timezone);
UPDATE master_table SET Airport_Code = TRIM(BOTH '"' FROM Airport_Code);
UPDATE master_table SET Wind_Direction = TRIM(BOTH '"' FROM Wind_Direction);
UPDATE master_table SET Weather_Condition = TRIM(BOTH '"' FROM Weather_Condition);
UPDATE master_table SET Sunrise_Sunset = TRIM(BOTH '"' FROM Sunrise_Sunset);
UPDATE master_table SET Civil_Twilight = TRIM(BOTH '"' FROM Civil_Twilight);
UPDATE master_table SET Nautical_Twilight = TRIM(BOTH '"' FROM Nautical_Twilight);
UPDATE master_table SET Astronomical_Twilight = TRIM(BOTH '"' FROM Astronomical_Twilight);

UPDATE master_table SET ID=TRIM(LEADING 'A-' FROM ID); 



UPDATE master_table SET wind_direction = REPLACE (wind_direction,'WNW','NW')  WHERE wind_direction='WNW';
UPDATE master_table SET wind_direction = REPLACE (wind_direction,'SSW','SW')  WHERE wind_direction='SSW';
UPDATE master_table SET wind_direction = REPLACE (wind_direction,'ESE','SE')  WHERE wind_direction='ESE';
UPDATE master_table SET wind_direction = REPLACE (wind_direction,'SSE','SE')  WHERE wind_direction='SSE';
UPDATE master_table SET wind_direction = REPLACE (wind_direction,'South','S')  WHERE wind_direction='South';
UPDATE master_table SET wind_direction = REPLACE (wind_direction,'West','W')  WHERE wind_direction='West';
UPDATE master_table SET wind_direction = REPLACE (wind_direction,'WSW','SW')  WHERE wind_direction='WSW';
UPDATE master_table SET wind_direction = REPLACE (wind_direction,'ENE','NE')  WHERE wind_direction='ENE';
UPDATE master_table SET wind_direction = REPLACE (wind_direction,'NNE','NE')  WHERE wind_direction='NNE';
UPDATE master_table SET wind_direction = REPLACE (wind_direction,'NNW','NW')  WHERE wind_direction='NNW';
UPDATE master_table SET wind_direction = REPLACE (wind_direction,'East','E')  WHERE wind_direction='East';
UPDATE master_table SET wind_direction = REPLACE (wind_direction,'Variable','VAR')  WHERE wind_direction='Variable';
UPDATE master_table SET wind_direction = REPLACE (wind_direction,'North','N')  WHERE wind_direction='North';


UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Cloudy / Windy','Cloudy')  WHERE Weather_Condition='Cloudy / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Light Snow / Windy','Light Snow')  WHERE Weather_Condition='Light Snow / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Light Rain / Windy','Light Rain')  WHERE Weather_Condition='Light Rain / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Heavy Snow / Windy','Heavy Snow')  WHERE Weather_Condition='Heavy Snow / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Mostly Cloudy / Windy','Mostly Cloudy')  WHERE Weather_Condition='Mostly Cloudy / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Wintry Mix / Windy','Wintry Mix')  WHERE Weather_Condition='Wintry Mix / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Partly Cloudy / Windy','Partly Cloudy')  WHERE Weather_Condition='Partly Cloudy / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Fair / Windy','Fair')  WHERE Weather_Condition='Fair / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Light Drizzle / Windy','Light Drizzle')  WHERE Weather_Condition='Light Drizzle / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Thunder in the Vicinity','Thunder')  WHERE Weather_Condition='Thunder in the Vicinity';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Patches of Fog','Fog')  WHERE Weather_Condition='Patches of Fog';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Shallow Fog','Fog')  WHERE Weather_Condition='Shallow Fog';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Light Rain with Thunder','Light Rain')  WHERE Weather_Condition='Light Rain with Thunder';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Heavy Rain / Windy','Heavy Rain')  WHERE Weather_Condition='Heavy Rain / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Rain / Windy','Rain')  WHERE Weather_Condition='Rain / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'T-Storm / Windy','T-Storms')  WHERE Weather_Condition='T-Storm / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Heavy T-Storm / Windy','Heavy T-Storms')  WHERE Weather_Condition='Heavy T-Storm / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Haze / Windy','Haze')  WHERE Weather_Condition='Haze / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Showers in the Vicinity','Showers')  WHERE Weather_Condition='Showers in the Vicinity';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Light Thunderstorms and Rain','Light T-Storms')  WHERE Weather_Condition='Light Thunderstorms and Rain';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Thunderstorms and Rain','T-Storms')  WHERE Weather_Condition='Thunderstorms and Rain';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Heavy Thunderstorms and Rain','Heavy T-Storms')  WHERE Weather_Condition='Heavy Thunderstorms and Rain';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Thunderstorm','T-Storms')  WHERE Weather_Condition='Thunderstorm';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Blowing Snow','Snow')  WHERE Weather_Condition='Blowing Snow';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Small Hail','Light Hail')  WHERE Weather_Condition='Small Hail';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Smoke / Windy','Smoke')  WHERE Weather_Condition='Smoke / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Light Freezing Rain / Windy','Freezing Rain')  WHERE Weather_Condition='Light Freezing Rain / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Snow / Windy','Snow')  WHERE Weather_Condition='Snow / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Light Snow Grains','Light Snow')  WHERE Weather_Condition='Light Snow Grains';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Fog / Windy','Fog')  WHERE Weather_Condition='Fog / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Light Rain Shower / Windy','Light Rain')  WHERE Weather_Condition='Light Rain Shower / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Squalls / Windy','Rain')  WHERE Weather_Condition='Squalls / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Thunder / Windy','Thunder')  WHERE Weather_Condition='Thunder / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Blowing Dust / Windy','Blowing Dust')  WHERE Weather_Condition='Blowing Dust / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Drizzle / Windy','Drizzle')  WHERE Weather_Condition='Drizzle / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Partial Fog','Fog')  WHERE Weather_Condition='Partial Fog';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Sand / Dust Whirlwinds / Windy','Sand / Dust Whirlwinds')  WHERE Weather_Condition='Sand / Dust Whirlwinds / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Blowing Snow / Windy','Blowing Snow')  WHERE Weather_Condition='Blowing Snow / Windy';
UPDATE master_table SET Weather_Condition = REPLACE (Weather_Condition,'Light Snow and Sleet / Windy','Rain')  WHERE Weather_Condition='Light Snow and Sleet / Windy';
# THIS 
DELETE FROM master_table WHERE Zipcode = '20815-3704';


SELECT DISTINCT(tmc) FROM master_table LIMIT 100;

-- -----------------------------------------------------
-- Table new tables
-- -----------------------------------------------------
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- -----------------------------------------------------
-- Table `accidents2`.`Location_zip`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `accidents2`.`Location_zip` ;

CREATE TABLE IF NOT EXISTS `accidents2`.`Location_zip` (
  `zipcode` VARCHAR(15) NOT NULL,
  `city` VARCHAR(45) NULL,
  `county` VARCHAR(45) NULL,
  `State` VARCHAR(10),
  `timezone` VARCHAR(45) NULL,
  `airport_code` VARCHAR(45) NULL,
  PRIMARY KEY (`zipcode`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `accidents2`.`Location_POI_start`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `accidents2`.`Location_POI_start` ;

CREATE TABLE IF NOT EXISTS `accidents2`.`Location_POI_start` (
  `start_lat` DECIMAL(10,6) NOT NULL,
  `start_lng` DECIMAL(10,6) NOT NULL,
  `amenity` TINYINT(1) NULL,
  `bump` TINYINT(1) NULL,
  `crossing` TINYINT(1) NULL,
  `give_way` TINYINT(1) NULL,
  `junction` TINYINT(1) NULL,
  `no_exit` TINYINT(1) NULL,
  `railway` TINYINT(1) NULL,
  `roundabout` TINYINT(1) NULL,
  `station` TINYINT(1) NULL,
  `stop` TINYINT(1) NULL,
  `traffic_calming` TINYINT(1) NULL,
  `traffic_signal` TINYINT(1) NULL,
  `turning_loop` TINYINT(1) NULL,
  `number` INT NULL,
  `street` VARCHAR(120) NULL,
  `zipcode` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`start_lat`, `start_lng`),
  INDEX `fk_POI_Location_zip_idx` (`zipcode` ASC),
  CONSTRAINT `fk_POI_Location_zip`
    FOREIGN KEY (`zipcode`)
    REFERENCES `accidents2`.`Location_zip` (`zipcode`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `accidents2`.`Environment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `accidents2`.`Environment` ;

CREATE TABLE IF NOT EXISTS `accidents2`.`Environment` (
  `airport_code` VARCHAR(45) NOT NULL,
  `weather_timestamp` DATETIME NOT NULL,
  `temperature` DECIMAL(5,2) NULL,
  `humidity` DECIMAL(5,2) NULL,
  `pressure` DECIMAL(5,2) NULL,
  `visibility` DECIMAL(5,2) NULL,
  `wind_direction` VARCHAR(20) NULL,
  `wind_speed` DECIMAL(5,2) NULL,
  `weather_condition` VARCHAR(45) NULL,
  PRIMARY KEY (`airport_code`, `weather_timestamp`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `accidents2`.`Accidents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `accidents2`.`accidents`;

CREATE TABLE IF NOT EXISTS `accidents2`.`Accidents` (
  `id` BIGINT AUTO_INCREMENT NOT NULL,
  `source` VARCHAR(20) NULL,
  `TMC` INT NULL,
  `severity` INT NULL,
  `start_time` DATETIME NULL,
  `end_time` DATETIME NULL,
  `start_lat` DECIMAL(10,6) NOT NULL,
  `start_lng` DECIMAL(10,6) NOT NULL,
  `distance` DECIMAL(10,2) NULL,
  `Description` BLOB,
  `airport_code` VARCHAR(45) NOT NULL,
  `weather_timestamp` DATETIME NULL,
  `sunrise_sunset` VARCHAR(45) NULL,
  `nautical_twilight`VARCHAR(45) NULL,
  `civil_twilight` VARCHAR(45) NULL,
  `astronomical_twilight` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Accidents_Location_POI1_idx` (`start_lat` ASC, `start_lng` ASC),
  INDEX `fk_Accidents_Environment1_idx` (`airport_code` ASC, `weather_timestamp` ASC),
  CONSTRAINT `fk_Accidents_Location_POI1`
    FOREIGN KEY (`start_lat` , `start_lng`)
    REFERENCES `accidents2`.`Location_POI_start` (`start_lat` , `start_lng`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Accidents_Environment1`
    FOREIGN KEY (`airport_code` , `weather_timestamp`)
    REFERENCES `accidents2`.`Environment` (`airport_code` , `weather_timestamp`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;




SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- -----------------------------------------------------
-- Inserting data into tables
-- -----------------------------------------------------

INSERT INTO Location_zip(
				zipcode,
				city,
				county,
                state ,
				timezone,
				airport_code
) SELECT DISTINCT(zipcode), city, county, state,timezone, airport_code
FROM master_table;

SELECT DISTINCT start_lat, start_lng,
				amenity,
				bump,
				crossing,
				give_way,
				junction,
				no_exit,
				railway,
				roundabout,
				station,
				`stop`,
				traffic_calming,
				traffic_signal,
				turning_loop,
				`number`,
				street,
				zipcode
FROM master_table;

INSERT INTO Location_POI_start(
				start_lat,
				start_lng,
				amenity,
				bump,
				crossing,
				give_way,
				junction,
				no_exit,
				railway,
				roundabout,
				station,
				`stop`,
				traffic_calming,
				traffic_signal,
				turning_loop,
				`number`,
				street,
				zipcode
)SELECT DISTINCT start_lat, start_lng,
				amenity,
				bump,
				crossing,
				give_way,
				junction,
				no_exit,
				railway,
				roundabout,
				station,
				`stop`,
				traffic_calming,
				traffic_signal,
				turning_loop,
				`number`,
				street,
				zipcode
FROM master_table;


INSERT INTO Environment(
				airport_code,
				weather_timestamp,
				temperature,
				humidity,
				pressure,
				visibility,
				wind_direction,
				wind_speed,
				weather_condition
)
SELECT 	DISTINCT airport_code,
				weather_timestamp,
				`temperature(F)`,
				`humidity(%)`,
				`pressure(in)`,
				`visibility(mi)`,
				wind_direction,
				`wind_speed(mph)`,
				weather_condition
FROM master_table;

INSERT INTO accidents(
 `id`,
  `source` ,
  `TMC` ,
  `severity` ,
  `start_time` ,
  `end_time` ,
  `start_lat`,
  `start_lng` ,
  `distance` ,
  `Description`,
  `airport_code` ,
  `weather_timestamp` ,
  `sunrise_sunset`,
  `civil_twilight` ,
 `nautical_twilight`,
  `astronomical_twilight` 
  )
  SELECT `id`,
  `source` ,
  `TMC` ,
  `severity` ,
  `start_time` ,
  `end_time` ,
  `start_lat`,
  `start_lng` ,
  `Distance(mi)` ,
  `Description`,
  `airport_code` ,
  `weather_timestamp` ,
  `sunrise_sunset`,
  `civil_twilight` ,
 `nautical_twilight`,
  `astronomical_twilight` 
  FROM master_table;

USE accidents2;
SELECT* FROM master_table LIMIT 10;
SELECT* FROM accidents LIMIT 10;
SELECT* FROM environment LIMIT 10;
SELECT* FROM location_POI_start LIMIT 10;
SELECT* FROM location_zip LIMIT 10;
