<?php 
  $data = $_GET["data"];
  $return["message"] = "Kurulum başarılı PHP kodları bu sunucuda çalışıyor.";
  $return["Developer"] = "hasan Koç";
  $return["data"] = " $data ";
  header('Content-Type: application/json');
  echo json_encode($return);
?>