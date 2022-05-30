import 'dart:convert';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API/API.dart';
import '../Model/User.dart';
import 'CartPage.dart';
import 'HomePage.dart';
import 'UserPage.dart';

class RootPage extends StatefulWidget {

  int secilen;
  RootPage(this.secilen);
  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  static List<Widget> sayfalar = <Widget>[
    CartPage(),
    HomePage(),
    UserPage()
  ];
  int secilen = 1;
  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? mail =  await prefs.getString('eMail');
    Map<dynamic,dynamic>  data = await API.getUser(mail??"null");
    if(data['user']!=null){
      print(data['user']);
      var user = User.fromJson(jsonDecode(data['user']));
      prefs.setInt("id", user.id!);
    }
  }

  @override
  initState(){
    secilen = widget.secilen;
    getUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: sayfalar[secilen],
      bottomNavigationBar:BottomNavyBar(
        selectedIndex: secilen,
        backgroundColor: Colors.blue,
        showElevation: true,
        // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
            secilen = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: const Icon(Icons.shopping_cart_outlined),
            title: Text(
              'Sepet',
              style: TextStyle(fontSize: width / 30),
            ),
            activeColor: Colors.black,
            inactiveColor:  Colors.white,
          ),

          BottomNavyBarItem(
              icon:const  Icon(Icons.home),
              title: Text(
                'Ana Sayfa',
                style: TextStyle(fontSize: width / 30),
              ),
            activeColor: Colors.black,
            inactiveColor:  Colors.white,),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text(
              'Hesap',
              style: TextStyle(fontSize: width / 30),
            ),
            activeColor: Colors.black,
            inactiveColor:  Colors.white,
          ),
        ],
      ),
    );
  }
}
