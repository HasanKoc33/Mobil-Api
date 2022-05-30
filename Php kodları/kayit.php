<?php 
  $db = "mobilapi"; //database name
  $dbuser = "root"; //database username
  $dbpassword = ""; //database password
  $dbhost = "localhost"; //database host

  $return["error"] = false;
  $return["status"] = false;
  $return["message"] = "";

  $link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);

  $val = isset($_POST["name"]) && isset($_POST["eMail"]) && isset($_POST["pass"]) ;

  if($val){
      

       $name = $_POST["name"]; //grabing the data from headers
       $eMail = $_POST["eMail"];
       $pass = $_POST["pass"];
       $yetgi  = false;

       //validation name if there is no error before
       if($return["error"] == false && strlen($name) > 50
        ){
           $return["error"] = true;
           $return["message"] = "name  max 50 karakter olmali :strlen($name) ";
       }

       if($return["error"] == false && strlen($eMail) > 50
       ){
          $return["error"] = true;
          $return["message"] = "mail adresi max 50 karakter olmali";
      }

       if($return["error"] == false){
            $name = mysqli_real_escape_string($link, $name);
            $eMail = mysqli_real_escape_string($link, $eMail);
            $pass = mysqli_real_escape_string($link, $pass);

            $pass = md5($pass);
            try{
                $sql = "INSERT INTO users SET
                name = '$name',
                eMail  = '$eMail',
                pass = '$pass',
                yetgi = '$yetgi'";

                $res = mysqli_query($link, $sql);
                if($res){
                $return["status"] = true;
                $return["message"] = "Kayit Basarili";
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