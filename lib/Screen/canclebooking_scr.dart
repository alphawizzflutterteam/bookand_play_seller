import 'package:bookplayapp/Helper/color.dart';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../Model/canclebookinghistoryModel.dart';
import '../Services/api_services/apiBasehelper.dart';
import '../Services/api_services/apiStrings.dart';
import '../Widget/custum_appbar.dart';
import 'canclebookingDetails.dart';

class CancleBookingScreen extends StatefulWidget {
  const CancleBookingScreen({super.key});

  @override
  State<CancleBookingScreen> createState() => _CancleBookingScreenState();
}

class _CancleBookingScreenState extends State<CancleBookingScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBooking();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            CustomAppBar(
                onPressedLeading: () {
                  Navigator.pop(context);
                },
                title: 'Cancel Booking'),
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
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        !loading?
                        cancleBookingHistory == null ?
                        Container(
                            height: MediaQuery.of(context).size.height / 2,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                'Booking Not Found',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )) :
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 1.4,
                          child: ListView.builder(
                            itemCount: cancleBookingHistory?.data.length ?? 0,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CancleBookingDetailsScreen(
                                          bookingId: cancleBookingHistory
                                              ?.data[index].bookingId
                                              .toString(),
                                        )),
                                  );
                                },
                                child: Card(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    height:
                                    MediaQuery.of(context).size.height * 0.18,
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    margin: const EdgeInsets.only(bottom: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white),
                                    child: Row(children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  // image: DecorationImage(
                                                  //     image: AssetImage('assets/images/Group 75122.png')),
                                                    borderRadius:
                                                    BorderRadius.circular(30)),
                                                child: const Image(
                                                    image: AssetImage(
                                                        'assets/images/Group 75122.png'),
                                                    fit: BoxFit.fill),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                helper(
                                                    key: 'Booking Id - ',
                                                    value:
                                                    '${cancleBookingHistory?.data[index].bookingId ?? ''}'),

                                                // helper(key: 'Title', value: '${bookingHistory?.data[index].title??''}'),

                                                helper(
                                                    key: 'Cancellation Date',
                                                    value:


                                                    '${cancleBookingHistory?.data[index].createdAt.day}-${cancleBookingHistory?.data[index].createdAt.month}-${cancleBookingHistory?.data[index].createdAt.year}'),

                                              Row(
                                                children: [
                                                  Column(

                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [

                                                    Text(
                                                      "Cancellation Reason",
                                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                    ),

                                                    Text(
                                                      "${cancleBookingHistory?.data[index].cancelReason ?? ''}",
                                                      style: TextStyle(fontSize: 12,),
                                                    ),
                                                  ],),
                                                ],
                                              )
                                              ],
                                            )),
                                      ),
                                    ]),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                     :
                        Container(height:

                        MediaQuery.of(context).size.height/1.4,
                          width: MediaQuery.of(context).size.width,
                          child:
                          Center(child: CircularProgressIndicator(),)
                          ,)

                      ],
                    ),
                  ),
                ),


              ),
            )
          ],
        ),
      ),
    );
  }

  CancleBookingHistory? cancleBookingHistory;
  var msg;
  Future<void> getBooking() async {

    setState(() {
      loading=true;
    });
    var userId;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userId = preferences.getString('userId');
    });
    var param = {
      'vendor_id': userId.toString(),
    };
    apiBaseHelper.postAPICall(getCancleBooking, param).then((getData) {
      bool error = getData['status'];
      msg = getData['message'];

      if (error) {
        setState(() {
          cancleBookingHistory =CancleBookingHistory.fromJson(getData);
        });

        setState(() {
          loading=false;
        });
      }
      else{
        setState(() {
          loading=false;
        });
      }
    });

  }
  Widget helper({required String key, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          key,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
  bool loading=false;

}

