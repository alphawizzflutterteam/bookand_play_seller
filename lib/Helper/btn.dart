import 'dart:ui';

import 'package:bookplayapp/Helper/color.dart';
import 'package:flutter/material.dart';



class Btn extends StatelessWidget {
  final String? title;
  final VoidCallback? onPress;
  double? height;
  double? width;
  double? fSize;
  IconData? icon;
  Color? color;
  Btn(
      {Key? key,
        this.title,
        this.onPress,
        this.height,
        this.width,
        this.fSize,
        this.icon,
        this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: colors.lightgray,
                offset: Offset(
                  0.0,
                  3.0,
                ),
                blurRadius: 2.0,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            color: colors.whiteTemp,
            border: Border.all(color: colors.secondary, width: 2)),
        width: width ?? MediaQuery.of(context).size.width * 0.6,
        height: 50,
        child: Center(
            child: Text(
              "$title",
              style: TextStyle(
                  color: colors.btn,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}

class FilledBtn extends StatelessWidget {
  final String? title;
  final VoidCallback? onPress;
  double? height;
  double? width;
  double? fSize;
  IconData? icon;
  Color? color;
  FilledBtn(
      {Key? key,
        this.title,
        this.onPress,
        this.height,
        this.width,
        this.fSize,
        this.icon,
        this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              // BoxShadow(
              //   color: colors.lightgray,
              //   offset: Offset(
              //     0.0,
              //     3.0,
              //   ),
              //   blurRadius: 2.0,
              // ),
            ],
            borderRadius: BorderRadius.circular(30),
            color: colors.btn,
            // border: Border.all(color: colors.secondary, width: 2)
        ),
        height: 60,

        child: Center(
            child: Text(
              "$title",
              style: const TextStyle(
                  color: colors.whiteTemp,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}