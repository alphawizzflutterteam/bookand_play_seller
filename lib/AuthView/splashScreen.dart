import 'dart:async';

import 'package:bookplayapp/AuthView/loginPage.dart';
import 'package:bookplayapp/Helper/color.dart';
import 'package:bookplayapp/Screen/bottomScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? uid;
  String? type;
  bool? isSeen;
  @override
  void initState() {
    print("u id in splash screeen-----------${uid}");
    // TODO: implement initState
    /*  Future.delayed(Duration(seconds: 2), () async {
      // SharedPreferences prefs  = await SharedPreferences.getInstance();
      // bool? isLogin  =  prefs.getBool('isLogin');
      // print("is login trueee--------${isLogin}");
      // if(isLogin ?? false) {
      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomScreen()));
      //  } else{
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => UserAgreement()));
      //  }
    });
      Timer(Duration(seconds: 3), () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));});*/
    checkLogin ();
    super.initState();
  }

  checkLogin () async{
    Timer(const Duration(seconds: 3),() async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool? isLogin =  preferences.getBool('isLogin');

      if(isLogin ?? false){

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar(),));
      }else {

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [colors.primary, colors.secondary])),
        padding: EdgeInsets.symmetric(horizontal: 40),
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: Image.asset("assets/images/SPLASH SCREEN.png",
                fit: BoxFit.cover)),
      ),
    );
  }
}