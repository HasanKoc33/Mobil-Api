<?php 
  $db = "mobilapi"; //database name
  $dbuser = "root"; //database username
  $dbpassword = ""; //database password
  $dbhost = "localhost"; //database host

  $return["error"] = false;
  $return["status"] = false;
  $return["message"] = "";

  $link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);

  $val = isset($_POST["productId"]) &&
       isset($_POST["userId"]) ;

 $productId = $_POST["productId"]; 
 $userId= $_POST["userId"]; 
        
  if($val){
      
  

       if($return["error"] == false){
            $productId = mysqli_real_escape_string($link, $productId);
            $userId = mysqli_real_escape_string($link, $userId);
          
            try{
                $sql = "INSERT INTO cart SET
                userId = '$userId',
                productId  = '$productId'
                ";

                $res = mysqli_query($link, $sql);
                if($res){
                $return["status"] = true;
                $return["message"] = "Ürün Sepete eklendi";
                }else{
                $return["error"] = true;
                $return["message"] = "Database error $productId  $userId  $res";
                }
            }catch(Exception  $e) {
                $return["error"] = true;
                $return["message"] = "Database error $e";
            }
           
       }
  }else{
      $return["error"] = true;
      $return["message"] =" Send all parameters.  $productId  $userId ";
  }

  mysqli_close($link); //close mysqli
  header('Content-Type: application/json');
  echo json_encode($return);
?>