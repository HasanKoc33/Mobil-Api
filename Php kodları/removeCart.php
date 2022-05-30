<?php 
  $db = "mobilapi"; //database name
  $dbuser = "root"; //database username
  $dbpassword = ""; //database password
  $dbhost = "localhost"; //database host

  $return["error"] = false;
  $return["status"] = false;
  $return["message"] = "";

  $link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);


 $id= $_POST["id"]; 
        
      
            try{
                $sql = "DELETE FROM cart WHERE id=$id";

                $res = mysqli_query($link, $sql);
                if($res){
                $return["status"] = true;
                $return["message"] = "Ürün Sepet'den kaldırıldı";
                }else{
                $return["error"] = true;
                $return["message"] = "Database error $id";
                }
            }catch(Exception  $e) {
                $return["error"] = true;
                $return["message"] = "Database error $e";
            }
           
       
  

  mysqli_close($link); //close mysqli
  header('Content-Type: application/json');
  echo json_encode($return);
?>