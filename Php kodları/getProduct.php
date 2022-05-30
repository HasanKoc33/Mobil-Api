<?php 
  $db = "mobilapi"; //database name
  $dbuser = "root"; //database username
  $dbpassword = ""; //database password
  $dbhost = "localhost"; //database host

  $return["error"] = false;
  $return["status"] = false;
  $return["message"] = "";
  $return["products"] = "";

  $link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);

    
            
            try{
                $sql = "SELECT * FROM product ";
                $products = array();
              
                $res = mysqli_query($link, $sql);
                if ($res->num_rows > 0) {
                    while($row = $res->fetch_assoc()) {
                    
                        $products [$row['id']] =
                          array(
                              "id" => $row['id'],
                              "name" => $row['name'],
                              "imageUrl" => $row['imageUrl'],
                              "price" => $row['price'],
                              "stok" => $row['stok'],
                              "des" => $row['des']
                          );                  
                                            
                        }
                  } else {
                    $return["products"] = "0 results";
                  }

                if($res){
                $return["status"] = true;
                $return["products"] = json_encode($products);;
                $return["message"] = "Urunler yuklendi";
                }else{
                $return["error"] = true;
                $return["message"] = "Database error ";
                }
            }catch(Exception  $e) {
                $return["error"] = true;
                $return["message"] = "Database error ";
            }
           
       
 

  mysqli_close($link); //close mysqli
  header('Content-Type: application/json');
  echo json_encode($return);
?>