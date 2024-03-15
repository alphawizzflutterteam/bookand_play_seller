import 'package:bookplayapp/Helper/color.dart';
import 'package:bookplayapp/Screen/booking_detail_screen.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../Model/bookinghistory_Model.dart';
import '../Services/api_services/apiBasehelper.dart';
import '../Services/api_services/apiStrings.dart';
import 'canclebooking_scr.dart';
import 'offlinebooking.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({Key? key, this.isFrom}) : super(key: key);
  final bool? isFrom;

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}
class _MyBookingsScreenState extends State<MyBookingsScreen> {
  bool loading=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getBooking();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: bodyWidget(context: context));
  }
  Widget bodyWidget({required BuildContext context}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding:const EdgeInsets.symmetric(horizontal: 20),
      margin:const EdgeInsets.only(top: 35),
      decoration: const BoxDecoration(
        color: colors.white10,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(


          children: [


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [


                InkWell(
                    onTap:

                        () {


                      Navigator.push(context, MaterialPageRoute(builder: (context) => OfflineBooking(),));
                    },
                    child: Text("View Offline Booking",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: colors.primary))),

                InkWell(
                    onTap:

                    () {


                      Navigator.push(context, MaterialPageRoute(builder: (context) => CancleBookingScreen(),));
                    },
                    child: Text("View Cancel Booking",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: colors.primary))),

              ],
            ),


            SizedBox(height: 20,),

            !loading?
            bookingHistory?.data.isEmpty ?? true

                ?Container(height: MediaQuery.of(context).size.height/2,
            width: MediaQuery.of(context).size.width,
              child:


              Center(child:Text('Booking Not Found',style: TextStyle(fontWeight: FontWeight.bold),),)

            ):

                SizedBox(
                  height: MediaQuery.of(context).size.height/1.4,
                  child: ListView.builder(
                      itemCount: bookingHistory?.data.length??0,
                      itemBuilder: (context, index) {
                        return

                          InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  BookingDetailScreen(bookingId: bookingHistory?.data[index].id.toString(),userId:bookingHistory?.data[index].userId.toString() ,)),
                              );
                            },
                            child: Container(
                              padding:const EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height * 0.18,
                              width: MediaQuery.of(context).size.width * 0.9,
                              margin:const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15), color: Colors.white),
                              child: Row(children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          // height: 70,
                                          // width: 70,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage('${bookingHistory?.data[index].img}'),fit: BoxFit.fill),
                                              borderRadius: BorderRadius.circular(8)),
                                          // child:const Image(
                                          //     image: AssetImage('assets/images/Group 75122.png'),
                                          //     fit: BoxFit.fill),
                                        ),
                                      ),
                                      Text(
                                        'Booking Id-${bookingHistory?.data[index].id??''}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: colors.secondary),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          helper(key: 'Title', value: '${bookingHistory?.data[index].title??''}'),
                                          helper(key: 'Address', value: '${bookingHistory?.data[index].address??''}'),
                                          helper(key: 'Date', value: '${bookingHistory?.data[index].bookingDate.day}-${bookingHistory?.data[index].bookingDate.month}-${bookingHistory?.data[index].bookingDate.year}'),
                                          helper(key: 'Time', value: '${bookingHistory?.data[index].bookingFrom??''} To ${bookingHistory?.data[index].bookingTo??''}'),
                                        ],
                                      )),
                                ),
                              ]),
                            ),
                          );



                        },),
                ):
                Container(height:

                  MediaQuery.of(context).size.height/1.4,
                  width: MediaQuery.of(context).size.width,
                  child:
Center(child: CircularProgressIndicator(),)
                  ,)

          ],
        ),
      ),
    );
  }
  Widget myBookings() {
    return

      Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.18,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Row(children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(
                child: InkWell(
          onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => const BookingDetailsScreen()),
        // );
        },
                  child: Container(
                    decoration: BoxDecoration(
                      // image: DecorationImage(
                      //     image: AssetImage('assets/images/Group 75122.png')),
                        borderRadius: BorderRadius.circular(30)),
                    child: Image(
                        image: AssetImage('assets/images/Group 75122.png'),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
              Text(
                'Booking Id-',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: colors.secondary),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  helper(key: 'Name', value: 'Shivansh Shukla'),
                  helper(key: 'Mobile Number', value: '9758694798'),
                  helper(key: 'Email Id', value: 'mailto:shiv@gmail.com'),
                  helper(key: 'Address', value: 'Vijay Nagar, Indore'),
                  helper(key: 'Date', value: 'Friday, 04 Oct'),
                  helper(key: 'Time', value: '1:00 PM To 2:00 PM'),
                ],
              )),
        ),
      ]),
    );
  }

  Widget helper({required String key, required String value}) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 60,
          child: Text(
            "${key} -",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold


            ),
            maxLines: 1,
             overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width/3,
          child: Text(
            value,
            style: TextStyle(fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  BookingHistory?bookingHistory;
  var msg;
  Future <void>getBooking () async{

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
    apiBaseHelper.postAPICall(getBookind, param).then((getData) {
      bool error = getData['status'];
       msg = getData['message'];

      if (error) {


var finalresult=BookingHistory.fromJson(getData);

setState(() {
  bookingHistory=finalresult;
});

setState(() {
  loading=false;
});

      }else{

        setState(() {
          loading=false;

        });

      }

    });


  }


}