<?php 
  $db = "mobilapi"; //database name
  $dbuser = "root"; //database username
  $dbpassword = ""; //database password
  $dbhost = "localhost"; //database host

  $return["error"] = false;
  $return["status"] = false;
  $return["message"] = "";
  $return["eMail"] = "";
  $link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);

  $val = isset($_POST["eMail"]) && isset($_POST["pass"]);

  if(empty(trim($_POST["eMail"]))){
        $return["error"] = true;
        $return["message"] = "Lütfen e posta adresinizi girin!";
    } else{
        $eMail = trim($_POST["eMail"]);
    }
    
    // Check if password is empty
    if(empty(trim($_POST["pass"]))){
        $return["error"] = true;
        $return["message"] = "Lütfen şifrenizi girin!";
    } else{
        $pass = trim($_POST["pass"]);
    }

  if($val){
      
       $eMail = $_POST["eMail"];
       $pass = $_POST["pass"];
      
       if($return["error"] == false){
            $eMail = mysqli_real_escape_string($link, $eMail);
            $pass = mysqli_real_escape_string($link, $pass);

                $pass = md5($pass);
                $sql = "SELECT id, eMail, pass FROM users WHERE eMail= ? ";
                if($stmt = mysqli_prepare($link, $sql)){
                    mysqli_stmt_bind_param($stmt, "s", $param_eMail);
                    $param_eMail = $eMail;
                    if(mysqli_stmt_execute($stmt)){
                        mysqli_stmt_store_result($stmt);
                        
                        if(mysqli_stmt_num_rows($stmt) == 1){                    
                            mysqli_stmt_bind_result($stmt, $id, $eMail, $hashed_password);
                            if(mysqli_stmt_fetch($stmt)){
                                if($pass == $hashed_password){
                                        $return["status"] = true;
                                        $return["message"] = "Giris Başarılı ";     
                                        $return["eMail"] =  $eMail;                 
                                       
           
                                } else{
                                    $return["error"] = true;
                                    $return["message"] = "Geçersiz kullanıcı adı veya şifre.";
                                }
                            }
                        } else{
                            $return["error"] = true;
                            $return["message"] = "Geçersiz kullanıcı adı veya şifre.";
                        }
                    } else{
                        $return["error"] = true;
                         $return["message"] = "Hata! Bir şeyler ters gitti. Lütfen daha sonra tekrar deneyin.";
                    }
        
                    mysqli_stmt_close($stmt);
                }

               
          
           
       }
  }else{
      $return["error"] = true;
      $return["message"] = 'Tüm parametreleri gönderin.  eMail , pass';
  }

  mysqli_close($link); //close mysqli
  header('Content-Type: application/json');
  echo json_encode($return);
?>