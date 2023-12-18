import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/color.dart';

Widget customAuthDegine (BuildContext context, String title, {String? image}){
  return Stack(children: [
    Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      decoration:  BoxDecoration(
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
        padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/11),
        child: Column(
          children: [
            Image.asset('assets/image/verification.png', scale: 2),const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 26
              ),
            ),
            const SizedBox(
              height: 20,
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
