import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_api/Model/Product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../API/API.dart';
import '../Model/Cart.dart';
import '../Util/statement.dart';

class DetailPage extends StatefulWidget {
  Product product;

  DetailPage({required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  initState(){
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    width: size.width,
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                    imageUrl:widget.product.imageUrl,
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
                  IconButton(
                      onPressed: ()=> Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios,size: 40,color: Colors.blue,))
                ],
              ),
            
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    widget.product.name,
                  style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w700),

                ),
              ),
              Container(
                color: Colors.blue,
                width: size.width,
                height: 1,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.product.des,
                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),

                ),
              ),

              const SizedBox(
                height: 100,
              )

            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: size.width,
        color: Colors.lightBlue,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${widget.product.price} TL",
                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),

                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green), ),
                  onPressed: ()=> addCart(widget.product.id!),
                  child: Text("Sepete Ekle", style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),)),
            ),
          ],
        ),
      ) ,
    );
  }

  Future<void> addCart(int pid) async {
    final prefs = await SharedPreferences.getInstance();
    int? id =  await prefs.getInt('id');
    var data = await API.addCart({
      'id':'0',
      'userId': id.toString(),
      'productId':  pid.toString()
    }
    );

    if(data['status']){
      statement(context, data['message']);
    }

  }
}
