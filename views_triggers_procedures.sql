USE accidents2;

-- -----------------------------------------------------
-- Create view of accidents during the day
-- -----------------------------------------------------
DROP VIEW IF EXISTS accidents_days;
CREATE VIEW accidents_days AS
SELECT * FROM accidents WHERE sunrise_sunset= '"Day"';

-- -----------------------------------------------------
-- Create corresponding procedure to call
-- view of accidents during the day
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS get_accidents_during_day;
DELIMITER //
 
CREATE PROCEDURE get_accidents_during_day()
BEGIN
    SELECT *  FROM accidents_days;
END //
 
DELIMITER ;

-- -----------------------------------------------------
-- Create views of accidents at night
-- -----------------------------------------------------
DROP VIEW IF EXISTS accidents_night;
CREATE VIEW accidents_night AS
SELECT * FROM accidents WHERE sunrise_sunset= '"Night"';

-- -----------------------------------------------------
-- Create corresponding procedure to call
-- view of accidents at night
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS get_accidents_at_night;
DELIMITER //
 
CREATE PROCEDURE get_accidents_at_night()
BEGIN
    SELECT *  FROM accidents_night;
END //
 
DELIMITER ;

-- -----------------------------------------------------
-- Create accidents & location_POI join
-- -----------------------------------------------------
DROP VIEW IF EXISTS accidents_loc;
CREATE VIEW accidents_loc AS
SELECT * FROM accidents 
INNER JOIN location_POI_start USING(start_lat,start_lng) LIMIT 5000;

-- -----------------------------------------------------
-- Create corresponding procedure to call
-- joinged accident_loc data
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS get_accidents_loc;
DELIMITER //
 
CREATE PROCEDURE get_accidents_loc()
BEGIN
    SELECT *  FROM accidents_loc;
END //
 
DELIMITER ;

-- -----------------------------------------------------
-- Create accidents & environment join
-- -----------------------------------------------------
DROP VIEW IF EXISTS accidents_env;
CREATE VIEW accidents_env AS
SELECT * FROM accidents a
INNER JOIN environment USING(weather_timestamp,airport_code) LIMIT 5000;

-- -----------------------------------------------------
-- Create corresponding procedure to call
-- joinged accident_loc data
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS get_accidents_env;
DELIMITER //
 
CREATE PROCEDURE get_accidents_env()
BEGIN
    SELECT *  FROM accidents_env;
END //
 
DELIMITER ;

-- -----------------------------------------------------
-- Create accidents_loc & zip join
-- -----------------------------------------------------
DROP VIEW IF EXISTS accidents_loc_zip;
CREATE VIEW accidents_loc_zip AS
SELECT * FROM accidents_loc a
INNER JOIN location_zip USING(zipcode,airport_code) 
INNER JOIN environment USING(weather_timestamp,airport_code); ; 

-- -----------------------------------------------------
-- Create corresponding procedure to call
-- joined accidents_loc_zip data
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS get_accidents_loc_zip;
DELIMITER //
 
CREATE PROCEDURE get_accidents_loc_zip()
BEGIN
    SELECT *  FROM accidents_loc_zip;
END //
 
DELIMITER ;

-- -----------------------------------------------------
-- Create zipcode audit table & trigger
-- -----------------------------------------------------
DROP TABLE IF EXISTS zip_audit;

CREATE TABLE zip_audit (
	zip_audit_id INT PRIMARY KEY AUTO_INCREMENT, 
	zipcode INT,
	city VARCHAR(20),
	county VARCHAR(20),
	timezone VARCHAR(20),
	airport_code VARCHAR(20),
	date_added DATETIME DEFAULT NULL,
    date_dropped DATETIME DEFAULT NULL
);

DROP TRIGGER IF EXISTS zipcode_after_insert;

DELIMITER //
CREATE TRIGGER zipcode_after_insert
AFTER INSERT
ON Location_zip
FOR EACH ROW
BEGIN
	INSERT INTO zip_audit (zipcode,city,county,timezone,airport_code, date_added)
	VALUES (NEW.zipcode, NEW.city, NEW.county, NEW.timezone, NEW.airport_code,current_date());

END //
DELIMITER ;


DROP TRIGGER IF EXISTS zipcode_after_delete;

DELIMITER //
CREATE TRIGGER zipcode_after_delete
AFTER DELETE
ON Location_zip
FOR EACH ROW
BEGIN
	INSERT INTO zip_audit (zipcode,city,county,timezone,airport_code, date_dropped)
	VALUES (OLD.zipcode, OLD.city, OLD.county, OLD.timezone, OLD.airport_code, current_date());

END //
DELIMITER ;

-- -----------------------------------------------------
-- Create accidents audit table & trigger
-- -----------------------------------------------------
DROP TABLE IF EXISTS accidents_audit;

CREATE TABLE accidents_audit (
	audit_id INT PRIMARY KEY AUTO_INCREMENT, 
	id INT,
	date_added DATETIME DEFAULT NULL
);

DROP TRIGGER IF EXISTS accidents_after_insert;

DELIMITER //
CREATE TRIGGER accidents_after_insert
AFTER INSERT 
ON accidents
FOR EACH ROW
BEGIN
	INSERT INTO accidents_audit (id, date_added)
	VALUES (NEW.id, current_date());

END //
DELIMITER ;

-- -----------------------------------------------------
-- Create accidents audit table & trigger
-- -----------------------------------------------------

DROP TRIGGER IF EXISTS accidents_before_insert;
DELIMITER //
CREATE TRIGGER accidents_before_insert
BEFORE INSERT 
ON accidents
FOR EACH ROW
BEGIN
	IF NEW.weather_timestamp IS NULL THEN
		SET NEW.weather_timestamp =NOW();
	END IF;
END //
DELIMITER ;


-- -----------------------------------------------------
-- Create trigger for update table to environment table
-- -----------------------------------------------------

DROP TRIGGER IF EXISTS environment_before_update;

DELIMITER //
CREATE TRIGGER environment_before_update
BEFORE UPDATE 
ON environment
FOR EACH ROW
BEGIN
	IF NEW.temperature > 250 THEN
		SIGNAL SQLSTATE 'HY000'
		SET MESSAGE_TEXT = 'The temperature percent is greater than 250!';
	ELSEIF NEW.temperature < -200 THEN
		SIGNAL SQLSTATE 'HY000'
		SET MESSAGE_TEXT =  'The temperature is less than -200.';
	END IF; 
	IF NEW.humidity > 100 THEN
			SIGNAL SQLSTATE 'HY000'
			SET MESSAGE_TEXT = 'The humidity cannot is more than 100.';
		ELSEIF NEW.humidity < 0 THEN
			SIGNAL SQLSTATE 'HY000'
			SET MESSAGE_TEXT =  'The humidity cannot is less than 0.';
	END IF; 
	IF NEW.pressure > 100 THEN
			SIGNAL SQLSTATE 'HY000'
			SET MESSAGE_TEXT = 'The pressure is more than 100.';
		ELSEIF NEW.pressure < 0 THEN
			SIGNAL SQLSTATE 'HY000'
			SET MESSAGE_TEXT =  'The pressure cannot be less than 0.';
	END IF; 
	IF NEW.wind_speed < 0 THEN
			SIGNAL SQLSTATE 'HY000'
			SET MESSAGE_TEXT = 'The windspeed cannot be less than 0.';
	END IF; 
	IF NEW.visibility < 0 THEN
			SIGNAL SQLSTATE 'HY000'
			SET MESSAGE_TEXT = 'The visibility cannot be less than 0.';
	END IF; 
END //
DELIMITER ;

-- -----------------------------------------------------
-- insert test scripts
-- -----------------------------------------------------

INSERT INTO Location_zip(zipcode,city,county,timezone,airport_code) VALUES (1234,'test','US','US/Eastern','KDAY');

INSERT INTO Location_POI_start(start_lat,start_lng,amenity,
bump,crossing,give_way,
junction,no_exit,railway,
roundabout,station,`stop`,
traffic_calming,traffic_signal,turning_loop,
`number`,street,zipcode) 
VALUES (39.542391,-84.235132,1,
1,1,1,
1,1,1,
1,1,1,
1,1,1,
1234,'test',1234);

INSERT INTO environment(airport_code,weather_timestamp,temperature,
humidity,pressure,visibility,
wind_direction,wind_speed,weather_condition) VALUES('KDAY','2016-02-08 11:11:11',80.0,
0.0,0.0,10.1,
10.0,1.0,'Calm');

INSERT INTO accidents(id,source,TMC,
										severity,start_time,end_time,
										start_lat,start_lng,distance,
										Description,airport_code,weather_timestamp,
										sunrise_sunset,nautical_twilight,civil_twilight,
										astronomical_twilight) 
VALUE (1,'Bing',201,
2,'2016-02-08 11:11:11','2016-02-08 11:11:11',
 39.542391,-84.235132,1.00,
'test test test','KDAY','2016-02-08 11:11:11',
'Day','Day','Day','Day');

-- -----------------------------------------------------
-- check audit tables
-- -----------------------------------------------------

SELECT * FROM accidents_audit LIMIT 100;
SELECT * FROM zip_audit LIMIT 100;

-- -----------------------------------------------------
-- check audit tables
-- -----------------------------------------------------

SELECT * FROM location_zip WHERE zipcode = 1234;

SELECT * FROM zip_audit;