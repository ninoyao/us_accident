DROP DATABASE IF EXISTS accidents1;

CREATE DATABASE accidents1;

USE accidents1;

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
`End_Lng` DECIMAL(10,6)  DEFAULT NULL,
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
`Wind_Chill(F)` DECIMAL(5,2) NULL , #SHOULD BE A NUMBER
`Humidity(%)` DECIMAL(5,2) NULL  , #SHOULD BE A NUMBER
`Pressure(in)` DECIMAL(5,2) NULL  , #SHOULD BE A NUMBER
`Visibility(mi)` DECIMAL(5,2) NULL  , #SHOULD BE A NUMBER
`Wind_Direction` VARCHAR(20) NULL,
`Wind_Speed(mph)` DECIMAL(5,2) NULL , #SHOULD BE A NUMBER
`Precipitation(in)` DECIMAL(5,2) NULL  , #SHOULD BE A NUMBER
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


ALTER TABLE `accidents1`.`master_table` 
ENGINE = InnoDB ;
LOAD DATA LOCAL INFILE '/Users/linh/Documents/Vanderbilt/Spring2020/DMS_5420/Project2/accident_na.csv'

#LOAD DATA INFILE 'C:\\Users\\ninoy\\Desktop\\VandyDS\\2020spring\\dbms\\us_accident\\accident_na.csv'
INTO TABLE master_table
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;

SELECT * FROM master_table LIMIT 1000;

/**
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

**/

/**
ALTER TABLE master_table
MODIFY COLUMN Amenity BOOL;

ALTER TABLE master_table
MODIFY COLUMN Bump BOOL;

ALTER TABLE master_table
MODIFY COLUMN Crossing BOOL;

ALTER TABLE master_table
MODIFY COLUMN Give_Way BOOL;

ALTER TABLE master_table
MODIFY COLUMN Junction BOOL;

ALTER TABLE master_table
MODIFY COLUMN No_Exit BOOL;

ALTER TABLE master_table
MODIFY COLUMN Railway BOOL;

ALTER TABLE master_table
MODIFY COLUMN Roundabout BOOL;

ALTER TABLE master_table
MODIFY COLUMN Station BOOL;

ALTER TABLE master_table
MODIFY COLUMN `Stop` BOOL;

ALTER TABLE master_table
MODIFY COLUMN Traffic_Calming BOOL;

ALTER TABLE master_table
MODIFY COLUMN Traffic_Signal BOOL;

ALTER TABLE master_table
MODIFY COLUMN Turning_Loop BOOL;
**/

UPDATE master_table SET zipcode = TRIM(BOTH '"' FROM zipcode);
/**
DELETE m1 FROM master_table m1
INNER JOIN master_table m2 
WHERE
    m1.zipcode = m2.zipcode;
**/


-- -----------------------------------------------------
-- Table new tables
-- -----------------------------------------------------


SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- -----------------------------------------------------
-- Table `accidents1`.`Location_zip`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `accidents1`.`Location_zip` ;

CREATE TABLE IF NOT EXISTS `accidents1`.`Location_zip` (
  `zipcode` BIGINT NOT NULL,
  `city` VARCHAR(45) NULL,
  `county` VARCHAR(45) NULL,
  `timezone` VARCHAR(45) NULL,
  `airport_code` VARCHAR(45) NULL,
  PRIMARY KEY (`zipcode`))
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `accidents1`.`Location_POI_start`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `accidents1`.`Location_POI_start` ;

CREATE TABLE IF NOT EXISTS `accidents1`.`Location_POI_start` (
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
  `street` VARCHAR(45) NULL,
  `zipcode` INT NOT NULL,
  PRIMARY KEY (`start_lat`, `start_lng`),
  INDEX `fk_POI_Location_zip_idx` (`zipcode` ASC),
  CONSTRAINT `fk_POI_Location_zip`
    FOREIGN KEY (`zipcode`)
    REFERENCES `mydb`.`Location_zip` (`zipcode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `accidents1`.`Enviornment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `accidents1`.`Enviornment` ;

CREATE TABLE IF NOT EXISTS `accidents1`.`Enviornment` (
  `airport_code` VARCHAR(45) NOT NULL,
  `weather_timestamp` DATE NOT NULL,
  `temperature` DECIMAL(4,2) NULL,
  `wind_chill` DECIMAL(4,2) NULL,
  `humidity` DECIMAL(5,2) NULL,
  `pressure` DECIMAL(4,2) NULL,
  `visibility` DECIMAL(4,2) NULL,
  `wind_direction` VARCHAR(20) NULL,
  `wind_speed` DECIMAL(4,2) NULL,
  `precipitation` DECIMAL(4,2) NULL,
  `weather_condition` VARCHAR(45) NULL,
  PRIMARY KEY (`airport_code`, `weather_timestamp`))
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `accidents1`.`Location_POI_end`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `accidents1`.`Location_POI_end` ;

CREATE TABLE IF NOT EXISTS `accidents1`.`Location_POI_end` (
  `end_lat` DECIMAL(10,6) NOT NULL,
  `end_lng` DECIMAL(10,6) NOT NULL,
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
  `street` VARCHAR(45) NULL,
  `zipcode` INT NOT NULL,
  PRIMARY KEY (`end_lat`, `end_lng`),
  INDEX `fk_Location_POI_end_Location_zip1_idx` (`zipcode` ASC),
  CONSTRAINT `fk_Location_POI_end_Location_zip1`
    FOREIGN KEY (`zipcode`)
    REFERENCES `mydb`.`Location_zip` (`zipcode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `accidents1`.`accidents1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `accidents1`.`accidents1` ;

CREATE TABLE IF NOT EXISTS `accidents1`.`accidents1` (
  `id` INT NOT NULL,
  `source` VARCHAR(45) NULL,
  `TMC` INT NULL,
  `severity` INT NULL,
  `start_time` DATE NULL,
  `end_time` DATE NULL,
  `start_lat` DECIMAL(10,6) NOT NULL,
  `start_lng` DECIMAL(10,6) NOT NULL,
  `end_end_lat` DECIMAL(10,6) NULL,
  `end_end_lng` DECIMAL(10,6) NULL,
  `distance` DECIMAL(8,2) NULL,
  `description` VARCHAR(45) NULL,
  `airport_code` VARCHAR(45) NOT NULL,
  `weather_timestamp` DATE NULL,
  `sunrise_sunset` VARCHAR(45) NULL,
  `civil_twilight` VARCHAR(45) NULL,
  `astronomical_twilight` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_accidents1_Location_POI1_idx` (`start_lat` ASC, `start_lng` ASC),
  INDEX `fk_accidents1_Location_POI_end1_idx` (`end_end_lat` ASC, `end_end_lng` ASC),
  INDEX `fk_accidents1_Enviornment1_idx` (`airport_code` ASC, `weather_timestamp` ASC),
  CONSTRAINT `fk_accidents1_Location_POI1`
    FOREIGN KEY (`start_lat` , `start_lng`)
    REFERENCES `mydb`.`Location_POI_start` (`start_lat` , `start_lng`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_accidents1_Location_POI_end1`
    FOREIGN KEY (`end_end_lat` , `end_end_lng`)
    REFERENCES `mydb`.`Location_POI_end` (`end_lat` , `end_lng`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_accidents1_Enviornment1`
    FOREIGN KEY (`airport_code` , `weather_timestamp`)
    REFERENCES `mydb`.`Enviornment` (`airport_code` , `weather_timestamp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;




SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- -----------------------------------------------------
-- Inserting data into tables
-- -----------------------------------------------------

UPDATE master_table
SET zipcode = LPAD(zipcode, 5,'-');

SELECT DISTINCT(zipcode),
				city,
				county,
				timezone,
				airport_code
FROM master_table WHERE zipcode IS NOT NULL;


INSERT INTO Location_zip(
				zipcode,
				city,
				county,
				timezone,
				airport_code
)
SELECT DISTINCT(zipcode),
				city,
				county,
				timezone,
				airport_code
FROM master_table WHERE zipcode IS NOT NULL;

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
)SELECT start_lat,
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
FROM master_table;


INSERT INTO Environment(
				airport_code,
				weather_timestamp,
				temperature,
				wind_chill,
				humidity,
				pressure,
				visibility,
				wind_direction,
				wind_speed,
				precipitation,
				weather_condition
)
SELECT airport_code,
				weather_timestamp,
				temperature,
				wind_chill,
				humidity,
				pressure,
				visibility,
				wind_direction,
				wind_speed,
				precipitation,
				weather_condition
FROM master_table;

INSERT INTO Location_POI_end(
				end_lat,
				end_lng,
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
)SELECT end_lat,
				end_lng,
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


INSERT INTO accidents1(
				id,
				`source`,
				TMC,
				severity,
				start_time,
				start_lat,
				start_lng,
				end_lat,
				end_lng,
				distance,
				description,
				airport_code,
				weather_timestamp,
				sunrise_sunset,
				civil_twilight,
				astronomical_twilight
) SELECT id,
				`source`,
				TMC,
				severity,
				start_time,
				start_lat,
				start_lng,
				end_lat,
				end_lng,
				distance,
				description,
				airport_code,
				weather_timestamp,
				sunrise_sunset,
				civil_twilight,
				astronomical_twilight
FROM master_table;