import 'package:bookplayapp/Helper/color.dart';
import 'package:flutter/material.dart';

class CommonBgWidget extends StatefulWidget {
  const CommonBgWidget({super.key});

  @override
  State<CommonBgWidget> createState() => _CommonBgWidgetState();
}

class _CommonBgWidgetState extends State<CommonBgWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.13,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.25),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [colors.primary, colors.secondary])),
          ),
          Container(
            margin:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.12),
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
          ),
          Container(
            margin:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.13),
            height: MediaQuery.of(context).size.height * 0.89,
            width: MediaQuery.of(context).size.width,
            padding:const EdgeInsets.symmetric(horizontal: 20),
            decoration:const BoxDecoration(
              color: Color(0xffF6F6F6),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
          )
        ],
      ),
    );
  }
}