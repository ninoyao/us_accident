USE accidents2;

SELECT * FROM accidents LIMIT 500;

SELECT * FROM environment LIMIT 500;

SELECT * FROM location_poi_start LIMIT 500;

SELECT * FROM location_zip LIMIT 500;


#count of accidents per timezone
SELECT COUNT(timezone), timezone FROM location_zip GROUP BY timezone;

#count of accidents during day/ night
SELECT COUNT(sunrise_sunset), sunrise_sunset FROM accidents GROUP BY sunrise_sunset;

#number of accidents by weather condition
SELECT COUNT(weather_condition) AS num_accidents, weather_condition FROM environment GROUP BY weather_condition ORDER BY  num_accidents DESC;

#number of accidents severity
SELECT COUNT(severity), severity FROM accidents GROUP BY severity;

CREATE VIEW accidents_day AS
SELECT * FROM accidents WHERE sunrise_sunset= '"Day"';

CREATE VIEW accidents_night AS
SELECT * FROM accidents WHERE sunrise_sunset= '"Night"';

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

