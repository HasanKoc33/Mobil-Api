import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void mesaj(String mes,{Color? color}) {
  Fluttertoast.showToast(
      msg: mes,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: color??Colors.white,
      timeInSecForIosWeb: 1);
}

void mesajSnackBar(String mes,BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(mes),
  ));
}

void hataMesaji(String mes) {
  Fluttertoast.showToast(
      msg: mes,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.red,
      timeInSecForIosWeb: 1);
}

void statement(BuildContext context,String mes) {
  showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
        content:Text(mes,style:const TextStyle(color: Colors.black,fontWeight: FontWeight.w700),),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text("Tamam"))
      ],
    ),
    barrierDismissible: true,
  );
}


void errorStatement(BuildContext context,String mes) {
  showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      content:Text(mes,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w700),),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("Tamam"))
      ],
    ),
    barrierDismissible: true,
  );
}