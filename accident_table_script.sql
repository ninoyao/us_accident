SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


USE `accidents` ;

-- -----------------------------------------------------
-- Table `mydb`.`Location_zip`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `accidents`.`Location_zip` ;

CREATE TABLE IF NOT EXISTS `accidents`.`Location_zip` (
  `zipcode` INT NOT NULL,
  `city` VARCHAR(45) NULL,
  `county` VARCHAR(45) NULL,
  `timezone` VARCHAR(45) NULL,
  `airport_code` VARCHAR(45) NULL,
  PRIMARY KEY (`zipcode`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Location_POI_start`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `accidents`.`Location_POI_start` ;

CREATE TABLE IF NOT EXISTS `accidents`.`Location_POI_start` (
  `start_lat` DECIMAL(10,6) NOT NULL,
  `start_lng` DECIMAL(10,6) NOT NULL,
  `amenity` TINYINT(1) NULL,
  `bump` TINYINT(1) NULL,
  `crossing` TINYINT(1) NULL,
  `give_way` TINYINT(1) NULL,
  `junction` TINYINT(1) NULL,
  `no_exit` TINYINT(1) NULL,
  `railway` TINYINT(1) NULL,
  `roundabou` TINYINT(1) NULL,
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
-- Table `mydb`.`Enviornment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `accidents`.`Enviornment` ;

CREATE TABLE IF NOT EXISTS `accidents`.`Enviornment` (
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
-- Table `mydb`.`Location_POI_end`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `accidents`.`Location_POI_end` ;

CREATE TABLE IF NOT EXISTS `accidents`.`Location_POI_end` (
  `end_lat` DECIMAL(10,6) NOT NULL,
  `end_lng` DECIMAL(10,6) NOT NULL,
  `amenity` TINYINT(1) NULL,
  `bump` TINYINT(1) NULL,
  `crossing` TINYINT(1) NULL,
  `give_way` TINYINT(1) NULL,
  `junction` TINYINT(1) NULL,
  `no_exit` TINYINT(1) NULL,
  `railway` TINYINT(1) NULL,
  `roundabou` TINYINT(1) NULL,
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
-- Table `mydb`.`Accidents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `accidents`.`Accidents` ;

CREATE TABLE IF NOT EXISTS `accidents`.`Accidents` (
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
  INDEX `fk_Accidents_Location_POI1_idx` (`start_lat` ASC, `start_lng` ASC),
  INDEX `fk_Accidents_Location_POI_end1_idx` (`end_end_lat` ASC, `end_end_lng` ASC),
  INDEX `fk_Accidents_Enviornment1_idx` (`airport_code` ASC, `weather_timestamp` ASC),
  CONSTRAINT `fk_Accidents_Location_POI1`
    FOREIGN KEY (`start_lat` , `start_lng`)
    REFERENCES `mydb`.`Location_POI_start` (`start_lat` , `start_lng`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Accidents_Location_POI_end1`
    FOREIGN KEY (`end_end_lat` , `end_end_lng`)
    REFERENCES `mydb`.`Location_POI_end` (`end_lat` , `end_lng`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Accidents_Enviornment1`
    FOREIGN KEY (`airport_code` , `weather_timestamp`)
    REFERENCES `mydb`.`Enviornment` (`airport_code` , `weather_timestamp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
