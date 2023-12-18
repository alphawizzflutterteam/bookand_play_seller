import 'package:bookplayapp/Helper/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/_payment_history_Model.dart';
import '../Model/notificationModel.dart';
import '../Services/api_services/apiBasehelper.dart';
import '../Services/api_services/apiStrings.dart';
import '../Widget/custum_appbar.dart';
class notificationScr extends StatefulWidget {
  const notificationScr({Key? key}) : super(key: key);

  @override
  State<notificationScr> createState() => _notificationScrState();
}

class _notificationScrState extends State<notificationScr> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettNotification();
  }
  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Scaffold(
          body:

          Stack(children: [



            CustomAppBar(
                onPressedLeading: () {
                  Navigator.pop(context);
                },
                title: 'Notifications'),
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
                child:

                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25,right: 25),
                    child: Column(children: [
                      SizedBox(height: 10,),
                      Row(
                        children: [



                          Text("Today",style: TextStyle(fontSize: 17)),

                        ],
                      ),


SizedBox(height: 20,),

                      !loading?


                  notificationModel?.data.isEmpty ?? true?
                          Container(
                            width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height/1.3,

                        child: Center(child: Text("Notification Not Avaiable",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),),

                      ):

                              Container(
                                height: MediaQuery.of(context).size.height/1.3,
                                child: ListView.builder(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:notificationModel?.data.length??0,

                                  itemBuilder: (context, index) {

                                  return  Card(

                                    child: Container(

                                      width: MediaQuery.of(context).size.width,

                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(children: [

                                         Row(children: [
                                           SizedBox(width: 5,),
                                           Text('${notificationModel?.data[index].createdAt.day??''}-${notificationModel?.data[index].createdAt.month??''}-${notificationModel?.data[index].createdAt.year??''}',style: TextStyle(fontSize: 10),),

                                         ],),

                                          ListTile(


                                            title:Text('${notificationModel?.data[index].title??''}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
leading: Container(
  width: 40,
  height: 40,
  decoration: BoxDecoration(borderRadius:BorderRadius.circular(20),

  color: colors.secondary
  ),

  child: Center(child: Icon(Icons.notifications_active)),),

subtitle: Text('${notificationModel?.data[index].message??''}',style: TextStyle(fontSize: 12,),),
                                          )
                                        ]),
                                      ),


                                    ),

                                  );

                                },),
                              )
:  Container(

                          height: MediaQuery.of(context).size.height/1.4,
                          width: MediaQuery.of(context).size.width,

                          child: Center(child: CircularProgressIndicator()))
                    ]),
                  ),
                ),
              ),
            )
          ],),

        ),
      );

  }
  var msg;


  NotificationModel?notificationModel;
  Future <void> gettNotification() async{

    setState(() {
      loading=true;
    });

    var userId;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId =  preferences.getString('userId');


    var param = {
      'user_id': userId.toString(),

    };


    apiBaseHelper.postAPICall(getNotification, param).then((getData) {
      bool error = getData['status'];
       msg = getData['message'];
      if (error) {
//Fluttertoast.showToast(msg: msg);
        notificationModel =NotificationModel.fromJson(getData);
        setState(() {
          loading=false;
        });
setState(() {

});
      }else {

        setState(() {
          loading=false;
        });
      }

    });
  }
  bool loading=false;

}
