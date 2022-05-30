import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_api/Model/Product.dart';

import '../Constants/Constants.dart';
import '../Model/Cart.dart';
import '../Model/User.dart';

class API{




  static Future<dynamic> giris({required String email,required String pass}) async {
    final uri = Uri(
    scheme: Constants.scheme,
    host: Constants.host,
    path: Constants.pathGiris
    );
    final req = await http.post(
        uri,
      body: {
          "eMail": email,
          "pass": pass,
      }
    );
    print(req.body);
    var data = json.decode(req.body);
    return data;
  }

  static Future<dynamic> kayit({required User user}) async {
    final uri = Uri(
        scheme: Constants.scheme,
        host: Constants.host,
        path: Constants.pathKayit
    );
    final req = await http.post(
        uri,
        body: user.toJson()
    );

    print(req.body);
    var data = jsonDecode(req.body);
    return data;
  }

  static Future<dynamic> getProduct() async {
    final uri = Uri(
        scheme: Constants.scheme,
        host: Constants.host,
        path: Constants.pathGetProduct
    );
    final req = await http.post(
        uri,
    );

    print(req.body);
    var data = jsonDecode(req.body);
    return data;
  }




  static Future<dynamic> getUser(String mail) async {
    final uri = Uri(
        scheme: Constants.scheme,
        host: Constants.host,
        path: Constants.pathGetUser
    );
    final req = await http.post(
      uri,
      body:{
        'eMail':mail
      }
    );

    print(req.body);
    var data = jsonDecode(req.body);
    return data;
  }

  static Future<dynamic> addCart(var cart) async {
    final uri = Uri(
        scheme: Constants.scheme,
        host: Constants.host,
        path: Constants.pathAddCart
    );
    final req = await http.post(
      uri,
      body: cart
    );

    print(req.body);
    var data = jsonDecode(req.body);
    return data;
  }

  static Future<dynamic> getCart(int userId) async {
    final uri = Uri(
        scheme: Constants.scheme,
        host: Constants.host,
        path: Constants.pathGetCart
    );
    final req = await http.post(
        uri,
        body: {
          'userId':userId.toString()
        }
    );
    var data  = jsonDecode(req.body);
    return data;
  }
  static Future<dynamic> removeCart(int id) async {
    final uri = Uri(
        scheme: Constants.scheme,
        host: Constants.host,
        path: Constants.pathremoveCart
    );
    final req = await http.post(
        uri,
        body: {
          'id':id.toString()
        }
    );

    print(req.body);
    var data = jsonDecode(req.body);
    return data;
  }
}

