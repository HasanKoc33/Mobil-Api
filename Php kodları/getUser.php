<?php 
  $db = "mobilapi"; //database name
  $dbuser = "root"; //database username
  $dbpassword = ""; //database password
  $dbhost = "localhost"; //database host

  $return["error"] = false;
  $return["status"] = false;
  $return["message"] = "";
  $return["user"] = "";

  $link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);
    
$eMail = $_POST["eMail"]; 

$sql = "SELECT * FROM users WHERE eMail='$eMail'";
$result = mysqli_query($link, $sql);

if($row = mysqli_fetch_assoc($result)) {
    $name = $row["name"];
    $id = $row["id"];
    $eMail = $row["eMail"];
    $return ['user'] =
    json_encode(
    array(
        "id" => $row['id'],
        "name" => $row['name'],
        "eMail" => $row['eMail']
    ));   
    $return["status"] = true;
    $return["message"] = "Kullaniciya ulasildi";
}else{
                $return["error"] = true;
                $return["message"] = "Database error ";
                }
          
       
 

  mysqli_close($link); //close mysqli
  header('Content-Type: application/json');
  echo json_encode($return);
?>