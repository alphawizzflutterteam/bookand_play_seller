
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../Helper/color.dart';
import '../Model/faqModel.dart';
import '../Services/api_services/apiBasehelper.dart';
import '../Services/api_services/apiStrings.dart';
import '../Widget/custum_appbar.dart';

class FaqScr extends StatefulWidget {
  const FaqScr({Key? key}) : super(key: key);

  @override
  State<FaqScr> createState() => _FaqScrState();
}

class _FaqScrState extends State<FaqScr> {
  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child: Scaffold(
        body:
        !isLoading?
        Stack(
          children: [
            CustomAppBar(
                onPressedLeading: () {
                  Navigator.pop(context);
                },
                title: 'Faq'),
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
                    padding: const EdgeInsets.only(left:15 , right: 15),
                    child: Column(children: [

                      Container(
                        padding: EdgeInsets.all(15),
                        height: MediaQuery.of(context).size.height/1.5,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8,),
                              child: faqTileDetails(
                                  question: "${FaqLList[index].title}", answer: '${FaqLList[index].description}', index: index+1),
                            );
                          },
                          itemCount: FaqLList.length,
                        ),
                      )

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
  int selected = -1;
  Widget faqTileDetails(
      {required String question, required String answer, required int index}) {
    return

      Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),),
            elevation: 1,
            child: Container(
              decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),

                  color: colors.whiteTemp
              ),
              child: ListTile(
                onTap: () {
                  setState(() {
                    if (selected == index) {
                      selected = -1;
                    } else {
                      selected = index;
                    }
                  });
                },
                title: Text(
                  question,
                  style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                ),
                trailing: Icon(selected == index
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down),
              ),
            ),
          ),
          selected == index
              ? Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 5),
              color: colors.greyColor,
              child: Html(data: answer,)
          )
              : Container(),
        ],
      );
  }

  bool isLoading=false;
  var datta;

  List<FaqList> FaqLList=[];



  Future<void> termsCondition() async {
    setState(() {
      isLoading = true;
    });

    apiBaseHelper.getAPICall(getFAQApi).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        FaqLList = FaqModel.fromJson(getData).data??[];
        setState(() {
          isLoading = false;
        });
      } else {
        isLoading = false;
      }
    });
  }

  }



