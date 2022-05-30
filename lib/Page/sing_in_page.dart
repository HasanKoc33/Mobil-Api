import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_api/Util/statement.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API/API.dart';
import '../Constants/resimler.dart';
import '../Model/User.dart';
import 'login_page.dart';


class SingInPage extends StatefulWidget {
  const SingInPage({Key? key}) : super(key: key);

  @override
  State<SingInPage> createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  var email = TextEditingController();
  var pass = TextEditingController();
  var name = TextEditingController();
  var progess = false;


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
                                    padding: EdgeInsets.all(1),
                                    child: Text(
                                      'Giris Yap',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black.withOpacity(.8),
                                      ),
                                    ),
                                  ),
                                  component(
                                      'Ad Soyad...',
                                      name,
                                      TextInputType.text,
                                      Icon(
                                        Icons.person_add_alt_1,
                                        color: Colors.black.withOpacity(.8),
                                      ),
                                      false
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
                                        kayit();
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
                                          'Kayıt Ol',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
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

  Future<void> kayit() async {
    var user = User(
      eMail: email.text,
      name: name.text,
      pass: pass.text,
      yetgi: false
    );
    Map<dynamic,dynamic> data = await API.kayit(user: user);
    print(data);
    if(data['status']){
      // giriş başarılı

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> LoginPage() ));
      statement(context, data['message']);

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


