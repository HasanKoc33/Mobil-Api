<?php 
  $db = "mobilapi"; //database name
  $dbuser = "root"; //database username
  $dbpassword = ""; //database password
  $dbhost = "localhost"; //database host

  $return["error"] = false;
  $return["status"] = false;
  $return["message"] = "";

  $link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);

  $val = isset(
            $_POST["name"]) &&
       isset($_POST["des"]) &&
        isset($_POST["imageUrl"]) && 
        isset($_POST["price"]) 
      //  isset($_POST["stok"])
        
        
        ;

  if($val){
      
    $name = $_POST["name"]; 
    $des= $_POST["des"]; 
    $imageUrl= $_POST["imageUrl"]; 
    $price= $_POST["price"]; 
    $stok= $_POST["stok"]; 

    

       if($return["error"] == false){
            $name = mysqli_real_escape_string($link, $name);
            $des = mysqli_real_escape_string($link, $des);
            $imageUrl = mysqli_real_escape_string($link, $imageUrl);
            $stok = mysqli_real_escape_string($link, $stok);
            $price = mysqli_real_escape_string($link, $price);


            try{
                $sql = "INSERT INTO product SET
                name = '$name',
                des  = '$des', 
                imageUrl = '$imageUrl',
                stok = '$stok',
                price = '$price'               
                ";

                $res = mysqli_query($link, $sql);
                if($res){
                $return["status"] = true;
                $return["message"] = "Ürün Kaydedildi";
                }else{
                $return["error"] = true;
                $return["message"] = "Database error ";
                }
            }catch(Exception  $e) {
                $return["error"] = true;
                $return["message"] = "Database error ";
            }
           
       }
  }else{
      $return["error"] = true;
      $return["message"] = 'Send all parameters.';
  }

  mysqli_close($link); //close mysqli
  header('Content-Type: application/json');
  echo json_encode($return);
?>