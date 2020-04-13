<?php

if (isset($_POST['submit'])) {

    require_once("conn.php");

    $query = "SELECT * FROM zip_audit";

try
    {
      $prepared_stmt = $dbo->prepare($query);
      $prepared_stmt->execute();
      $result = $prepared_stmt->fetchAll();
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

table {
  border-collapse: collapse;
  border-spacing: 0;
}

td, th {
  padding: 5px 30px 5px 30px;
  border-bottom: 1px solid #aaa;
}

</style>

<?php
if (isset($_POST['submit'])) {
  if ($result && $prepared_stmt->rowCount() > 0) { ?>
    
    <h2>Results</h2>

    <table>
      <thead>
		<tr>
		  <th>zip_audit_id</th>
		  <th>zipcode</th>
		  <th>city</th>
		  <th>county</th>
		  <th>timezone</th>
		  <th>airport_code</th>
		  <th>date_added</th>
		  <th>date_dropped</th>
		</tr>
      </thead>
      <tbody>
  
<?php foreach ($result as $row) { ?>
      
      <tr>
		<td><?php echo $row["zip_audit_id"]; ?></td>
		<td><?php echo $row["zipcode"]; ?></td>
		<td><?php echo $row["city"]; ?></td>
		<td><?php echo $row["county"]; ?></td>
		<td><?php echo $row["timezone"]; ?></td>
		<td><?php echo $row["airport_code"]; ?></td>
		<td><?php echo $row["date_added"]; ?></td>
		<td><?php echo $row["date_dropped"]; ?></td>
      </tr>
<?php } ?>
      </tbody>
  </table>
  
<?php } else { ?>
    > No results found for <?php echo $_POST['director']; ?>.
  <?php }
} ?>


<h1> Return the audit table</h1>

    <form method="post">

    	
    	<input type="submit" name="submit" value="Submit">
    </form>