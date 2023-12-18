import 'package:bookplayapp/Helper/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customAuthDegine (BuildContext context, String title,){
  return Stack(children: [
    Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)),
        gradient: LinearGradient(
          colors: [colors.primary, colors.secondary],
          // Define the colors
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding:  EdgeInsets.only(top:80),
        child: Column(
          children: [
            Image.asset("assets/images/login.png", scale: 2),
            SizedBox(height: 10,),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 30,
            ),

          ],
        ),
      ),
    ),
    Container(
      // padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/3.18),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height/3.1,),

      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            // Top-left corner radius
            topRight: Radius.circular(30),
            // Bottom-right corner with no rounding
          ),
        ),
      ),
    ),
  ],);
}
Widget customAuthDegineforForget (BuildContext context, String title){
  return Stack(children: [
    Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)),
        gradient: LinearGradient(
          colors: [colors.primary, colors.secondary],
          // Define the colors
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/10),
        child: Column(
          children: [
            Image.asset("assets/images/forgot password.png", scale: 2),
            SizedBox(height: 10,),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 30,
            ),

          ],
        ),
      ),
    ),
    Container(
      // padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/3.18),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height/2.8,),

      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            // Top-left corner radius
            topRight: Radius.circular(30),
            // Bottom-right corner with no rounding
          ),
        ),
      ),
    ),
  ],);
}



Widget textView(String text, {TextAlign? textAlign, FontWeight? fontWeight}) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 18,
    ),
    textAlign: textAlign,
  );
}