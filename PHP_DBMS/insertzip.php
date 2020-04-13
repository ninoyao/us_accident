<?php

if (isset($_POST['submit'])) {

    require_once("conn.php");

    $zipcode = $_POST['zipcode'];
    $county = $_POST['county'];
    $city = $_POST['city'];
    $timezone = $_POST['timezone'];
    $airport_code = $_POST['airport_code'];

    $query = "INSERT INTO location_zip (zipcode,city,county,timezone,airport_code) "
            . "VALUES (:zipcode, :city, :county, :timezone, :airport_code)";

    try
    {
      $prepared_stmt = $dbo->prepare($query);
      $prepared_stmt->bindValue(':zipcode', $zipcode, PDO::PARAM_STR);
      $prepared_stmt->bindValue(':city', $city, PDO::PARAM_STR);
      $prepared_stmt->bindValue(':county', $county, PDO::PARAM_STR);
      $prepared_stmt->bindValue(':timezone', $timezone, PDO::PARAM_STR);
      $prepared_stmt->bindValue(':airport_code', $airport_code, PDO::PARAM_STR);
      $prepared_stmt->execute();

    }
    catch (PDOException $ex)
    { // Error in database processing.
      echo $sql . "<br>" . $error->getMessage(); // HTTP 500 - Internal Server Error
    }
}

?>

<style>
label {
  display: block;
  margin: 5px 0;
}

</style>

<h1> Insert Zip</h1>

    <form method="post">
    	<label for="zipcode">zipcode</label>
    	<input type="text" name="zipcode" id="zipcode">

    	<label for="city">city</label>
    	<input type="text" name="city" id="city">

    	<label for="county">county</label>
    	<input type="text" name="county" id="county">

    	<label for="timezone">timezone</label>
    	<input type="text" name="timezone" id="timezone">

    	<label for="airport_code">airport_code</label>
    	<input type="text" name="airport_code" id="airport_code">
    	
    	<input type="submit" name="submit" value="Submit">
    </form>
