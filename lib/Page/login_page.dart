import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_api/Page/RootPage.dart';
import 'package:mobile_api/Page/sing_in_page.dart';
import 'package:mobile_api/Util/statement.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API/API.dart';
import '../Constants/resimler.dart';
import 'HomePage.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var email = TextEditingController();
  var pass = TextEditingController();
  var progess = false;

  Future<void> loginControl() async {
    final prefs = await SharedPreferences.getInstance();
    var mail =  prefs.getString('eMail');
    if(mail!=null && mail.isNotEmpty){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>RootPage(1) ));
    }
  }

  @override
  void initState(){
    super.initState();
    loginControl();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                SizedBox(
                  height: size.height,
                  child: Image.asset(
                    Resimler.background,
                    fit: BoxFit.fitHeight,
                  ),
                ),


                Center(
                  child: Column(
                    children: [
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 25, sigmaX: 25),
                            child: SizedBox(
                              width: size.width * .9,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:const  EdgeInsets.all(15),
                                    child: Text(
                                      'Giris Yap',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black.withOpacity(.8),
                                      ),
                                    ),
                                  ),
                                  component(
                                    'E-posta...',
                                      email,
                                      TextInputType.emailAddress,
                                      Icon(
                                      Icons.email,
                                      color: Colors.black.withOpacity(.8),
                                      ),
                                    false
                                  ),
                                  component(
                                      'Parola...',
                                      pass,
                                      TextInputType.visiblePassword,
                                      Icon(
                                        Icons.password,
                                        color: Colors.black.withOpacity(.8),
                                      ),
                                    true,
                                  ),



                                  if(progess)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 25),
                                      child: CircularProgressIndicator(
                                        color: Colors.black.withOpacity(.1),
                                      ),
                                    ),
                                  if(!progess)
                                    InkWell(
                                      splashColor: Colors.transparent,

                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        HapticFeedback.lightImpact();
                                        giris();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          bottom: size.width * .05,
                                        ),
                                        height: size.width / 8,
                                        width: size.width / 1.25,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlue.withOpacity(.3),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: const Text(
                                          'Giris Yap',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),

                                  Row(
                                    children: [
                                      const Spacer(),
                                      TextButton(
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (_)=> SingInPage()));
                                          },
                                          child: const Text("hesabın yok mu kayıt ol")
                                      )
                                    ],
                                  ),


                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> giris() async {
    Map<dynamic,dynamic> data = await API.giris(email: email.text, pass: pass.text);
    print(data);
    if(data['status']){
      statement(context, data['message']);
      String eMail = data['eMail']??"";
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('eMail', eMail);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>RootPage(1) ));
    }else{
      errorStatement(context, data['message']);
    }
  }


  Widget component(String hintText, var controller, TextInputType type , Icon icon,bool pass) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 8,
      width: size.width / 1.25,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30,left: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.lightBlue.withOpacity(.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
        cursorHeight: 30,
        style: TextStyle(
          color: Colors.black.withOpacity(.9),
          fontSize: 22,
        ),
        obscureText:pass ,
        keyboardType: type,
        decoration: InputDecoration(
          suffixIcon: icon,
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(.5),
          ),
        ),
      ),
    );
  }

}




class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context,
      Widget child,
      AxisDirection axisDirection,
      ) {
    return child;
  }
}


