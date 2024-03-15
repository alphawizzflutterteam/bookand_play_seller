import 'package:bookplayapp/Helper/color.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../Model/bookinghistory_Model.dart';
import '../Model/canclebookinghistoryModel.dart';
import '../Model/offlieBookingModel.dart';
import '../Services/api_services/apiBasehelper.dart';
import '../Services/api_services/apiStrings.dart';
import '../Widget/custum_appbar.dart';
import 'canclebookingDetails.dart';

class OfflineBooking extends StatefulWidget {
  const OfflineBooking({super.key});

  @override
  State<OfflineBooking> createState() => _OfflineBookingState();
}

class _OfflineBookingState extends State<OfflineBooking> {

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
                title: 'Offline Booking'),
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
                        OfflineBooking == null ?
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
                            itemCount: OfflineBooking?.data.length ?? 0,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {

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
                                                    image: DecorationImage(
                                                        image: NetworkImage('${OfflineBooking?.data[index].imgGround}'),fit: BoxFit.fill),
                                                    borderRadius: BorderRadius.circular(8)),
                                                // child: const Image(
                                                //     image: AssetImage(
                                                //         'assets/images/Group 75122.png'),
                                                //     fit: BoxFit.fill),
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
                                                    '${OfflineBooking?.data[index].id ?? ''}'),

                                                // helper(key: 'Title', value: '${bookingHistory?.data[index].title??''}'),

                                                helper(
                                                    key: 'Booking Date',
                                                    value:


                                                    '${OfflineBooking?.data[index].bookingDate.day}-${OfflineBooking?.data[index].bookingDate.month}-${OfflineBooking?.data[index].bookingDate.year}'),

                                                helper(
                                                    key: 'Time',
                                                    value:


                                                    '${OfflineBooking?.data[index].bookingFrom} To ${OfflineBooking?.data[index].bookingTo}'),


                                                OfflineBooking?.data[index].bookingCancelStatus==2?
                                                Container(height: 30,
                                                  width: MediaQuery.of(context).size.width,
decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),

color: colors.red,
),
                                                child: Center(child: Text('Booking is Canceled'),),
                                                ):

                                                InkWell(
                                                  onTap: () {

                                                    cancleBooking(OfflineBooking?.data[index].id.toString()??"");

                                                  },
                                                  child: Container(height: 30,
                                                    width: MediaQuery.of(context).size.width,
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),

                                                      color: colors.secondary,
                                                    ),
                                                    child: Center(child: Text('Click To cancel booking'),),
                                                  ),
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

  OfflineBookingModel? OfflineBooking;
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
    apiBaseHelper.postAPICall(getOfflineBooking, param).then((getData) {
      bool error = getData['status'];
      msg = getData['message'];

      if (error) {
        setState(() {
          OfflineBooking =OfflineBookingModel.fromJson(getData);
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

void cancleBooking(String booingId){

  var param = {
    'booking_id': booingId.toString(),
  };

  apiBaseHelper.postAPICall(getCancleBookingOfflineApi, param).then((getData) {
    bool error = getData['status'];
    msg = getData['message'];

    if (error) {
      Fluttertoast.showToast(msg: msg.toString());
      getBooking();
    }
    else{
      Fluttertoast.showToast(msg: msg.toString());

    }
  });
}

}

