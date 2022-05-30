import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_api/Util/statement.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../API/API.dart';
import '../Model/Cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  List<Cart> carts=[];

  double total =0.0;
  Future<void> getCart() async {
    carts.clear();
    total =0.0;
    setState((){});
    final prefs = await SharedPreferences.getInstance();
    int? id =  await prefs.getInt('id');

    Map<dynamic,dynamic>  data = await API.getCart(id??0);
    if(data['cards']!=null){
      carts.clear();
      total =0.0;
      (jsonDecode(data['cards']) as Map).forEach((key, value) {
        Cart cart = Cart.fromJson(value);
        carts.add(cart);
        total+=cart.product!.price;
      });
    }
    setState((){});
  }

  @override
  initState(){
    getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
     backgroundColor: Colors.blue.shade900,
      body: carts.isNotEmpty?
      ListView.builder(
        itemCount: carts.length,
          itemBuilder: (context,index){
            Cart cart = carts[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: Colors.white,

                  child: Row(
                    children: [
                      Expanded(
                        flex:1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CachedNetworkImage(
                            width: size.width/4,
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                            imageUrl:cart.product!.imageUrl,
                            placeholder: (context, url) => Container(
                              color: const Color(0xffe8e8f8),
                              child: Shimmer(
                                duration: Duration(milliseconds: 700), //Default value
                                color: Colors.lightGreenAccent, //Default value
                                enabled: true, //Defa
                                child: const Center(
                                  child:  Icon(Icons.ac_unit,color: Colors.red,),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.ac_unit,color: Colors.red,),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text(cart.product!.name),
                            Text(cart.product!.price.toString()+" TL"),
                          ],
                        ),
                      ),
                      Expanded(
                          child: IconButton(
                            icon: Icon(Icons.delete ,color:Colors.red),
                            onPressed: (){
                                sepetCikar(cart.id!);
                            },
                          )

                      )
                    ],
                  ),
                ),
              ),
            );
          }

      ):
      const Padding(
        padding:  EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            "Sepetinizde ürün bulunmamaktadır",
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: carts.isNotEmpty? Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              border: Border.all(color:Colors.green,width: 1.5),
              borderRadius: BorderRadius.circular(11)
          ),
          width: 290,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        height: 50,
                        width: 100,
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: FittedBox(
                          child: Text(
                            "Ara Toplam"+"\n${total.toStringAsFixed(2)} TL",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),

                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        statement(context, "Keyifli alışverişler");
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        child: Container(
                            width: size.width / 2.6,
                            height: 50,
                            color: Colors.green,
                            // alignment: Alignment.center,
                            child: Center(
                              child: Text(
                                "ÖDEME",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ):null,
    );
  }

  Future<void> sepetCikar(int id) async {
    var data = await API.removeCart(id);
    print(data["message"]);
    statement(context, data["message"]);
    getCart();
  }
}
