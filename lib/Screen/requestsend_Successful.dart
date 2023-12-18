import 'package:flutter/material.dart';

import '../helper/btn.dart';
import '../helper/color.dart';
class paymentSuccessful extends StatefulWidget {
  const paymentSuccessful({super.key});
  @override
  State<paymentSuccessful> createState() => _paymentSuccessfulState();
}

class _paymentSuccessfulState extends State<paymentSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () {
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                child: Image(image: AssetImage('assets/images/Group75302.png')),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Request Send Successful",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF131313),),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Lorem ipsum dolor sit amet consectetuer elit, sed diam Lorem ipsum dolor sit amet, consectetuer elit, sed diam",
                style: TextStyle(
                  fontSize: 16,
                  // fontWeight: FontWeight.bold,
                  color: Color(0xFF7B7A7A),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.13),
                child: FilledBtn(
                  title: 'Go To Home',
                  onPress: () {
                  },
                ),
              )
            ]
        ),
      ),
    );
  }
}