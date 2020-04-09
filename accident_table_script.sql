
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
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
DROP TABLE IF EXISTS `accidents2`.`Accidents` ;

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
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Accidents_Environment1`
    FOREIGN KEY (`airport_code` , `weather_timestamp`)
    REFERENCES `accidents2`.`Environment` (`airport_code` , `weather_timestamp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;




SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;