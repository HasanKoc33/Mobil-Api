import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_api/API/API.dart';
import 'package:mobile_api/Page/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/User.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  User? user;
  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? mail =  await prefs.getString('eMail');
    Map<dynamic,dynamic>  data = await API.getUser(mail??"null");
    if(data['user']!=null){
      print(data['user']);
      user = User.fromJson(jsonDecode(data['user']));
      setState((){});
    }
  }

  @override
  initState(){
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: user!=null?Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.person,
                    color: Colors.blue,
                    size: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(user!.name,
                  style: TextStyle(fontSize: 25),
                  ),
                )
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(user!.eMail,
                style: TextStyle(fontSize: 25),
              ),
            ),

            SizedBox(
              height: 100,
            ),

            ElevatedButton(
                onPressed: ()=> cikis(),
                child:const Text(
                  "Çıkış Yap"
                )

            )
          ],
        ): const CircularProgressIndicator(),
      ),
    );
  }
  
  Future<void> cikis() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('eMail', "");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> LoginPage()));
  }
}
