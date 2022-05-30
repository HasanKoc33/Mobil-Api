import 'dart:convert';

import 'Product.dart';
import 'User.dart';

class Cart{
  int? id;
  Product? product;
  User? user;

  Cart({
    this.id,
    required this.product,
    required this.user,

  });
  factory Cart.fromJson(Map<dynamic, dynamic> json) {
    return Cart(
      id: json["id"]!=null? int.parse(json["id"].toString()): 0,
      product: json["product"]!=null? Product.fromJson(json["product"]):null,
      user: json["user"]!=null? User.fromJson(json["user"]):null,
    );
  }

}