use accidents2;
SELECT * FROM location_zip WHERE zipcode = 37203;


INSERT INTO Location_zip(zipcode,city,county,State,timezone,airport_code) VALUES (1234,'test','US','TN','US/Eastern','KDAY');

DELETE FROM location_zip WHERE State = 'aa';

DELETE FROM zip_audit WHERE zipcode = 1234 or 37203;

SELECT * FROM zip_audit;
