import 'package:bookplayapp/Helper/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/_payment_history_Model.dart';
import '../Model/tranjectionHistoryModel.dart';
import '../Model/walletHistoryModel.dart';
import '../Services/api_services/apiBasehelper.dart';
import '../Services/api_services/apiStrings.dart';
import '../Widget/custum_appbar.dart';
class PaymentHistoryScr extends StatefulWidget {
  const PaymentHistoryScr({Key? key}) : super(key: key);

  @override
  State<PaymentHistoryScr> createState() => _PaymentHistoryScrState();
}

class _PaymentHistoryScrState extends State<PaymentHistoryScr> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBalance();
  }
  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Scaffold(
          body:
          // ?Center(child: CircularProgressIndicator()):
          Stack(children: [
            CustomAppBar(
                onPressedLeading: () {
                  Navigator.pop(context);
                },
                title: 'Payment History'),
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
                    SizedBox(height: 30,),
                    Row(
                      children: [

                        Text("Transaction",style: TextStyle(fontSize: 25)),
                      ],
                    ),







                    walletHistory?.data.isEmpty ?? true
                          ?

                    Container(
                      height: MediaQuery.of(context).size.height/1.2,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                        child: Text('History Not Available'),
                      ),
                          )
                          :

                      Container(
                        child: ListView.builder(
                          shrinkWrap: true,

                          itemCount:
                          walletHistory?.data.length ?? 0,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Container(

                                height: 80,


                                child: Row(children: [
                                  SizedBox(width: 15,),
                                  Container(height: 30,width: 30,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                          color: colors.secondary
                                      ),
                                      child: Icon(Icons.monetization_on_rounded,color: colors.whiteTemp,size: 15,)
                                  ),
                                  SizedBox(width: 15,),
                                  Column(

                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text("${walletHistory?.data[index].id}", style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                                      Text("${walletHistory?.data[index].createdAt}", style: TextStyle(fontSize: 10)),

                                    ],),

                                  Spacer(),

                                  Text("RS ${walletHistory?.data[index].amount}", style: TextStyle(fontSize: 15,)),

                                  SizedBox(width: 10,),

                                ]),
                              ),
                            );
                          },
                        ),
                      ),

                  ]),
                ),
              ),
              ),
            )
          ],),

        ),
      );

  }

  TransactionHistory?walletHistory;
  Future <void> getBalance() async{

    var userId;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId =  preferences.getString('userId');


    var param = {
      'vendor_id': userId.toString(),

    };


    apiBaseHelper.postAPICall(getTransactionApi, param).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];
      if (error) {
//Fluttertoast.showToast(msg: msg);
        walletHistory = TransactionHistory.fromJson(getData);
setState(() {

});
      }else {
      }

    });
  }

}
