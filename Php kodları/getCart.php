<?php 
  $db = "mobilapi"; //database name
  $dbuser = "root"; //database username
  $dbpassword = ""; //database password
  $dbhost = "localhost"; //database host

  $return["error"] = false;
  $return["status"] = false;
  $return["message"] = "";
  $return["cards"] = "";

  $link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);

  $userId = $_POST["userId"];
    
            
            try{
                $sql = "SELECT cart.id as id, product.imageUrl AS imageUrl , product.name AS name , product.price AS price , product.id AS productId
                   FROM cart INNER JOIN product on product.id=cart.productId JOIN users on users.id=cart.userId WHERE `userId`=$userId";
                $cards = array();
                $res = mysqli_query($link, $sql);
                if ($res->num_rows > 0) {
                    while($row = $res->fetch_assoc()) {
                        $cards [$row['id']] = 
                          array(
                              "id" => $row['id'],
                              "product" => array(
                                "id" => $row['productId'],
                                "name" => $row['name'],
                                "imageUrl" => $row['imageUrl'],
                                "price" => $row['price']
                              ),
                            
                          );                 
                                            
                        }
                  } else {
                    $return["cards"] = "0 results $res";
                  }

                if($res){
                $return["status"] = true;
                $return["cards"] = json_encode($cards);;
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