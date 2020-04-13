SELECT * FROM location_zip WHERE zipcode = 1234;
INSERT INTO Location_zip(zipcode,city,county,timezone,airport_code) VALUES (1234,'test','US','US/Eastern','KDAY');
DELETE FROM location_zip WHERE zipcode = 1234;
SELECT * FROM zip_audit;
