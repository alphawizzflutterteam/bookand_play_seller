import 'dart:convert';

import 'package:bookplayapp/Helper/common.dart';
import 'package:bookplayapp/Services/api_services/apiBasehelper.dart';
import 'package:bookplayapp/Services/api_services/apiConstants.dart';
import 'package:bookplayapp/helper/color.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../Model/cancleBookindetailsModel.dart';

class CancleBookingDetailsScreen extends StatefulWidget {
  String? bookingId;
  String? userId;

  CancleBookingDetailsScreen({super.key,this.bookingId,this.userId});

  @override
  State<CancleBookingDetailsScreen> createState() => _CancleBookingDetailsScreenState();
}

class _CancleBookingDetailsScreenState extends State<CancleBookingDetailsScreen> {
  TextEditingController oldPassCon = TextEditingController();
  TextEditingController passCCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  bool loading = false;
  bool network = false;
  FocusNode passNode = FocusNode();
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  String deviceDetails = "";
  CarouselController controller = CarouselController();
  List crousalList=[];
  int selected = 0;
  CancelBookingsDetailsModel? cancleBookingModel;

  String? bookingName;
  String? bookinEmail;
  String? bookingMobile;
  String ?date;
  String ?time;
  String ?address;
  String ?vendorapprove;
  List SliderList=[];
  String ?canclebookId;
  getBookingDetail() async {
    print("wokingggggggggggg ");
    await App.init();
    network = true;
    setState(() {
      loading = true;
    });
    if (network) {
      Map param = {
        // "user_id": widget.userId,
        "booking_id": widget.bookingId,
      };
      var response = await apiBaseHelper.postAPICall(
        Uri.parse("${baseUrl}booking_details"), param,
      );
      if (response['status'] == true) {



        setState(() {



          bookingName=response['data']['booking_name'];
          bookinEmail=response['data']['booking_email'];
          bookingMobile=response['data']['booking_mobile'];
          date=response['data']['booking_date'];
          time='${response['data']['booking_from']} To ${response['data']['booking_to']}';;
          address=response['data']['address'];
          // SliderList.add(response['data']['address']);
          canclebookId=response['data']['booking_cancel_data']['id'].toString();
          vendorapprove=response['data']['booking_cancel_data']['approve_by_vendor'].toString();

          cancleBookingModel = CancelBookingsDetailsModel.fromJson(response['data']);

          print("booking nmae nene ${bookingName} ${canclebookId} ${date}");
        });
        setState(() {
          loading = false;
        });
      }else{
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBookingDetail();


    print(cancleBookingModel?.data?.bookingCancelData?.approveByVendor);
    print(cancleBookingModel?.data?.bookingCancelData?.approveByVendor.runtimeType);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 70,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon:const Icon(
                Icons.keyboard_arrow_left
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: Common.commonGradient(),
            ),
          ),
          title:Center(
            child: const Text(
              "Booking Detail",
            ),
          ),
        ),
        backgroundColor:const Color(0xff96E7F7),
        body: Container(
          width: double.infinity,
          decoration:const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              )
          ),
          padding:const EdgeInsets.only(top: 10),
          child: Container(
            decoration:const BoxDecoration(
                color: Color(0xfff3f3f3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                )
            ),
            padding:const EdgeInsets.all(20),
            child: !loading?cancleBookingModel!=null?Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                // CarouselSlider(
                //     items:cancleBookingModel?.data?.image?.map(
                //           (item) => ClipRRect(
                //           borderRadius: BorderRadius.circular(15),
                //           child: Container(
                //             decoration: BoxDecoration(
                //                 image: DecorationImage(
                //                     image: NetworkImage(
                //                       item,
                //                     ),
                //                     fit: BoxFit.fill)),
                //           )),
                //     )
                //         .toList(),
                //     carouselController: controller,
                //     options: CarouselOptions(
                //         scrollPhysics: const BouncingScrollPhysics(),
                //         autoPlay: true,
                //         aspectRatio: 1.8,
                //         viewportFraction: 1,
                //         onPageChanged: (index, reason) {
                //           setState(() {
                //             selected = index;
                //           });
                //         })),
                const SizedBox(
                  height: 10,
                ),
                // sliderPointers(cancleBookingModel?.data?.image ??[], selected),
                const SizedBox(height: 15,),
                Text(
                  "Booking ID - ${widget.bookingId}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 15,),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name",
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(
                                  bookingName ?? "",
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        color: colors.secondary
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Mobile Number",
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(
                                    bookingMobile ?? "",
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        color: colors.secondary
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),const SizedBox(height: 15,),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email ID",
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    bookinEmail ?? "",
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        color: colors.secondary
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Address",
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(height: 5,),
                                  SizedBox(
                                    child: Text(
                                      address ?? "",
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: colors.secondary
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15,),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date",
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(
                                    date??"",
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        color: colors.secondary
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Time",
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(
                                    "${time??''}",
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        color: colors.secondary
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 70,),

                vendorapprove=="0"?

                Row(
                   mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                  children: [
                    InkWell(
                      onTap: () {
                        print("raj");
                        
                        
                        statusupddddate('1');
                        setState(() {

                        });
                      },
                      child: Container(height: 50,
                        width: 150,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                            color: colors.secondary
                        ),
                        child: Center(child: Text('Approve')),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        print("raj1");
                        statusupddddate('2');
                        setState(() {
                        });
                      },
                      child: Container(height: 50,
                        width: 150,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                            color: Colors.red
                        ),
                        child: Center(child: Text('Disapprove')),
                      ),
                    ),
                  ],)
                    :



                InkWell(
                  onTap: () {

                  },
                  child: Container(height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                        color:

                        vendorapprove=="1"?
                        colors.secondary:
                            Colors.red
                    ),
                    child: Center(child:

                    vendorapprove=="1"?
                    Text('Approved'):

                    Text('Disapprove')

                    ),
                  ),
                )


              ],
            ):const SizedBox():const Center(child: CircularProgressIndicator(),),
          ),
        ),
      ),
    );
  }

  Widget sliderPointers(List doteList, int currentIndex) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(doteList.length, (index) =>   GestureDetector(
          // onTap:()=> controller.carouselController.animateToPage(entry.key),
          child: Container(
            width: currentIndex == index ? 25 : 12,
            height: 4.0,
            margin: const EdgeInsets.symmetric(
              horizontal: 3.0,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: currentIndex == index
                    ? colors.secondary
                    : Colors.grey),
          ),
        )).toList());
  }

  Future<void> statusupddddate(String Statuss) async {

    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}cancel_booking_status_update'));
    request.fields.addAll({
      'cancel_booking_id': "${canclebookId.toString()}",
      'status': Statuss.toString()
    });

print(request.url);
print(request.fields);
    http.StreamedResponse response = await request.send();
print("11");
    if (response.statusCode == 200) {


      var result =await response.stream.bytesToString();
      var finalresult= jsonDecode(result);
      bool error=finalresult['status'];
      String msg=finalresult['message'];

      setState(() {

      });
      if(error){

        Fluttertoast.showToast(msg: msg);
        Navigator.pop(context);
      }else{

        Fluttertoast.showToast(msg: msg);
        Navigator.pop(context);


      }
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
