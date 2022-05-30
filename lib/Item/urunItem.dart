import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../Constants/resimler.dart';
import '../Model/Product.dart';
import '../Page/DetailPage.dart';

void tap({required context, required Product u, var height, var width,bool? key}){
  Navigator.push(context, MaterialPageRoute(builder: (_)=> DetailPage(product: u,)));

}
Widget urunItem({required context, required Product u,required Color color, var height, var width}) {
  return GestureDetector(
    onTap: () =>tap(context: context,u: u,height: height),
    child: SizedBox(
        child: Banner(
              location: BannerLocation.topEnd,
              message: "İndirimli",
              color: Colors.blue,
              child: cart(u: u, height: height,color: color, width: width,context: context),
            ),
    ),
  );
}

Widget cart({required context, required Product u, var height,required Color color, var width}){
  String isim = "";
  bool bosluk = true;
  for(int i=0; i<u.name.length; i++){
    isim += u.name[i];
    if(i>=15 && u.name[i]==" " && bosluk){
      isim +="\n";
      bosluk = false;
    }
  }
  return Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.white,
        width: 0.2
      )
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 75, sigmaX: 75),
        child: SizedBox(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),

                  ),
                  child: CachedNetworkImage(
                    width: width,
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                    imageUrl:"${u.imageUrl}",
                    placeholder: (context, url) => Container(
                      color: const Color(0xffe8e8f8),
                      child: Shimmer(
                        duration: Duration(milliseconds: 700), //Default value
                        color: Colors.lightGreenAccent, //Default value
                        enabled: true, //Defa
                        child: Center(
                          child:Icon(Icons.ac_unit,color: Colors.red,),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.ac_unit,color: Colors.red,),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding:  EdgeInsets.all(1.0),
                  child: FittedBox(
                    child: Text(
                      "$isim",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                width: width,
                height: 1,
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      "${u.price} ₺",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
