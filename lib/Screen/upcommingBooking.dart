import 'dart:convert';

import 'package:bookplayapp/Helper/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import '../Model/tranjectionHistoryModel.dart';
import '../Model/vendor_home_response.dart';
import '../Model/walletHistoryModel.dart';
import '../Services/api_services/apiBasehelper.dart';
import '../Services/api_services/apiStrings.dart';
import '../Widget/custum_appbar.dart';

class Upcoming_booking extends StatefulWidget {

  VendorHomeResponse?vendorHomeResponse;
   Upcoming_booking({Key? key,this.vendorHomeResponse}) : super(key: key);

  @override
  State<Upcoming_booking> createState() => _Upcoming_bookingState();
}

class _Upcoming_bookingState extends State<Upcoming_booking> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
                title: 'Upcomming Booking'),
            Positioned(top: 70, child: screenStackContainer(context)),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.11,
              ),
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
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
                      SizedBox(
                        height: 15,
                      ),

                      // widget.vendorHomeResponse==null?
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height,
                        child:

                        widget.vendorHomeResponse!.data.upcomingBooking.details.isEmpty
                            ? Container(
                          height: MediaQuery.of(context).size.height/2,

                          child: Center(
                          child: Text('History Not Available'),
                        ),
                            )
                            :

                        Container(
                          height: MediaQuery.of(context).size.height/1.2,

                          child: ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,

                            itemCount:
                            widget.vendorHomeResponse?.data.upcomingBooking.details.length ?? 0,
                            itemBuilder: (context, index) {
                              return

                                InkWell(
                                  onTap: (){

                                  },
                                  child: Card(
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
                                                  decoration: BoxDecoration(
                                                    // image: DecorationImage(
                                                    //     image: AssetImage('assets/images/Group 75122.png')),
                                                      borderRadius: BorderRadius.circular(30)),
                                                  child:const Image(
                                                      image: AssetImage('assets/images/Group 75122.png'),
                                                      fit: BoxFit.fill),
                                                ),
                                              ),
                                              Text(
                                                'Booking Id-${widget.vendorHomeResponse?.data.upcomingBooking.details[index].id??''}',
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
                                                  helper(key: 'Ground Title', value: '${widget.vendorHomeResponse?.data.upcomingBooking.details[index].groundTitle??''}'),
                                                  helper(key: 'Booking Date', value: '${widget.vendorHomeResponse?.data.totalBooking.details[index].bookingDate.year??''}-${widget.vendorHomeResponse?.data.totalBooking.details[index].bookingDate.month??''}-${widget.vendorHomeResponse?.data.totalBooking.details[index].bookingDate.day??''}'),
                                                  helper(key: 'Time', value: '${widget.vendorHomeResponse?.data.upcomingBooking.details[index].bookingFrom??''} To ${widget.vendorHomeResponse?.data.totalBooking.details[index].bookingTo??''}'),
                                                ],
                                              )),
                                        ),
                                      ]),
                                    ),
                                  ),
                                );




                            },
                          ),
                        ),
                      )

                      //     :
                      //
                      // Container(
                      //     height: MediaQuery
                      //         .of(context)
                      //         .size
                      //         .height / 1.3,
                      //     width: MediaQuery
                      //         .of(context)
                      //         .size
                      //         .width,
                      //     child: const Center(
                      //       child: CircularProgressIndicator(),)),
                    ]),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
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

}