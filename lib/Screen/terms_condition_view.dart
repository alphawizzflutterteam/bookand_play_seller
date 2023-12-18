import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../Helper/color.dart';
import '../Services/api_services/apiBasehelper.dart';
import '../Services/api_services/apiStrings.dart';
import '../Widget/custum_appbar.dart';
class TermsCondation extends StatefulWidget {
  const TermsCondation({Key? key}) : super(key: key);

  @override
  State<TermsCondation> createState() => _TermsCondationState();
}

class _TermsCondationState extends State<TermsCondation> {

  @override
  Widget build(BuildContext context) {
    return

      SafeArea(
      child: Scaffold(
        body:
        !isLoading?
        Stack(
          children: [
            CustomAppBar(
                onPressedLeading: () {
                  Navigator.pop(context);
                },
                title: 'Terms & Conditions'),
            Positioned(top: 70, child: screenStackContainer(context)),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.11,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: colors.whiteTemp,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    // Top-left corner radius
                    topRight: Radius.circular(30),
                    // Bottom-right corner with no rounding
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Column(children: [

                      Html(data: datta,),
                    ]),
                  ),
                ),
              ),
            )
          ],
        ):

            Container(height: MediaQuery.of(context).size.height/1.5,

            child: Center(child: CircularProgressIndicator(),),
            )
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    termsCondition();
  }
  var datta;

bool isLoading=false;
  Future<void> termsCondition() async{
    setState(() {
      isLoading=true;
    });

    apiBaseHelper.getAPICall(getTermsAPI).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        datta = getData['data'][0]['description'];
       setState(() {
         isLoading=false;

       });
      } else {
        isLoading=false;

      }

    });
  }

}


