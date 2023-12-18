import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;
List<String> dayList = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"];
class Common {
  static Widget svgImage(image,{double? size,Color? color}){
    return SvgPicture.asset(
        image,
        semanticsLabel: 'Acme Logo',
      height: size,
      color: color,
      width: size,
    );
  }
  static Gradient commonGradient(){
    return const LinearGradient(
      colors: [Color(0xffF74CB0), Color(0xff96E7F7)],
      stops: [0, 1],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }
  static Widget commonButton({String title = "Btn",bool loading = false,double? width,double? height,BuildContext? context,VoidCallback? onPressed,Icon? icon}){
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color:const Color(0xff5ACBEF),
          borderRadius: BorderRadius.circular(40),
        ),
        child:icon!=null?
        ElevatedButton.icon(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
          icon: !loading?icon:const SizedBox(),
          label: !loading
              ? Text(
            title,
            style: Theme.of(context!).textTheme.bodyMedium!.copyWith(color: Colors.white),
          )
              :const CircularProgressIndicator(
            color: Colors.white,
          ),
        )
            :ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: !loading
              ? Text(
            title,
            style: Theme.of(context!).textTheme.bodyMedium!.copyWith(color: Colors.white),
          )
              :const CircularProgressIndicator(
            color: Colors.white,
          ),
        )

    );
  }
}
class Ui{
  static int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final bool isLeapYear = (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    const List<int> daysInMonth = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return daysInMonth[month - 1];
  }
  static int getOneDaysInMonth(int year, int month,String day) {
    int weekCount = 0;
    if (month == DateTime.february) {
      final bool isLeapYear = (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      int count = isLeapYear ? 29 : 28;
      for(int i = 1;i <= count;i++){
        DateTime tempDate = DateTime(year,month,i);
        String weekDay = DateFormat("EEEE").format(tempDate);
        if(weekDay==day){
          weekCount++;
        }
      }
    }else{
      const List<int> daysInMonth = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
      int count = daysInMonth[month - 1];
      for(int i = 1;i <= count;i++){
        DateTime tempDate = DateTime(year,month,i);
        String weekDay = DateFormat("EEEE").format(tempDate);
        print(weekDay);
        if(weekDay==day){
          weekCount++;
        }
      }
    }

    return weekCount;
  }
  static int getWeekDaysInDates(int year, int month,int start,int end,String day) {
    int weekCount = 0;
    for(int i = start;i <= end;i++){
      DateTime tempDate = DateTime(year,month,i);
      String weekDay = DateFormat("EEEE").format(tempDate);
      if(weekDay==day){
        weekCount++;
      }
    }
    return weekCount;
  }
  static Color parseColor(Color hexCode, {double? opacity,String? transColor}) {
    if(transColor!=null){
      try {
        return Color(int.parse(transColor.replaceAll("#", "0xFF"))).withOpacity(opacity ?? 1);
      } catch (e) {
        return hexCode.withOpacity(opacity ?? 1);
      }
    }else{
      return hexCode.withOpacity(opacity ?? 1);
    }

    /*try {
      return Color(int.parse(hexCode.replaceAll("#", "0xFF"))).withOpacity(opacity ?? 1);
    } catch (e) {
      return Color(0xFFCCCCCC).withOpacity(opacity ?? 1);
    }*/
  }
}
class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, // unused.
      TextEditingValue newValue,
      ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}
class App {
  static late SharedPreferences localStorage;
  static Future init() async {
    localStorage = await SharedPreferences.getInstance();
  }
}
class DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue prevText, TextEditingValue currText) {
    int selectionIndex;

    // Get the previous and current input strings
    String pText = prevText.text;
    String cText = currText.text;
    // Abbreviate lengths
    int cLen = cText.length;
    int pLen = pText.length;

    if (cLen == 1) {
      // Can only be 0, 1, 2 or 3
      if (int.parse(cText) > 3) {
        // Remove char
        cText = '';
      }
    } else if (cLen == 2 && pLen == 1) {
      // Days cannot be greater than 31
      int dd = int.parse(cText.substring(0, 2));
      if (dd == 0 || dd > 31) {
        // Remove char
        cText = cText.substring(0, 1);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if (cLen == 4) {
      // Can only be 0 or 1
      if (int.parse(cText.substring(3, 4)) > 1) {
        // Remove char
        cText = cText.substring(0, 3);
      }
    } else if (cLen == 5 && pLen == 4) {
      // Month cannot be greater than 12
      int mm = int.parse(cText.substring(3, 5));
      if (mm == 0 || mm > 12) {
        // Remove char
        cText = cText.substring(0, 4);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if ((cLen == 3 && pLen == 4) || (cLen == 6 && pLen == 7)) {
      // Remove / char
      cText = cText.substring(0, cText.length - 1);
    } else if (cLen == 3 && pLen == 2) {
      if (int.parse(cText.substring(2, 3)) > 1) {
        // Replace char
        cText = cText.substring(0, 2) + '/';
      } else {
        // Insert / char
        cText =
            cText.substring(0, pLen) + '/' + cText.substring(pLen, pLen + 1);
      }
    } else if (cLen == 6 && pLen == 5) {
      // Can only be 1 or 2 - if so insert a / char
      int y1 = int.parse(cText.substring(5, 6));
      if (y1 < 1 || y1 > 2) {
        // Replace char
        cText = cText.substring(0, 5) + '/';
      } else {
        // Insert / char
        cText = cText.substring(0, 5) + '/' + cText.substring(5, 6);
      }
    } else if (cLen == 7) {
      // Can only be 1 or 2
      int y1 = int.parse(cText.substring(6, 7));
      if (y1 < 1 || y1 > 2) {
        // Remove char
        cText = cText.substring(0, 6);
      }
    } else if (cLen == 8) {
      // Can only be 19 or 20
      int y2 = int.parse(cText.substring(6, 8));
      if (y2 < 19 || y2 > 20) {
        // Remove char
        cText = cText.substring(0, 7);
      }
    }

    selectionIndex = cText.length;
    return TextEditingValue(
      text: cText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
class AlertBox {
  final String title;
  final String content;
  final BuildContext context;

  AlertBox(this.title, this.content, this.context){
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context)
            .modalBarrierDismissLabel,
        transitionDuration: const Duration(milliseconds: 500),
        transitionBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
            ) =>
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0,-1),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.linear,
                ),
              ),
              child: child,
            ),
        pageBuilder: (BuildContext buildContext,
            Animation animation,
            Animation secondaryAnimation) {
          return SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.red[100],

                ),
                width: MediaQuery.of(context).size.width - 40,
                height: 60,
                padding: EdgeInsets.all(5),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                Text(title.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900,letterSpacing: 1,color: Colors.red),),
                                SizedBox(height: 5,),
                                Text(content.toString(),style: TextStyle(fontSize: 12,color: Colors.red))
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(buildContext);
                          },
                          child: Icon(
                            Icons.clear,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

}