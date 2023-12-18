import 'package:bookplayapp/Helper/common.dart';
import 'package:bookplayapp/Model/booking_detail_model.dart';
import 'package:bookplayapp/Services/api_services/apiBasehelper.dart';
import 'package:bookplayapp/Services/api_services/apiConstants.dart';
import 'package:bookplayapp/helper/color.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BookingDetailScreen extends StatefulWidget {
  String? bookingId;
  String? userId;
   BookingDetailScreen({super.key,this.bookingId,this.userId});

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  TextEditingController oldPassCon = TextEditingController();
  TextEditingController passCCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  bool loading = false;
  bool network = false;
  FocusNode passNode = FocusNode();
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  String deviceDetails = "";
  CarouselController controller = CarouselController();

  int selected = 0;
  BookingDetailModel? model;
  getBookingDetail() async {
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
      setState(() {
        loading = false;
      });
      if (response['status']) {
        model = BookingDetailModel.fromJson(response['data']);
      }else{
        Fluttertoast.showToast(msg:response['message']);
      }
    } else {
      setState(() {
        loading = false;
      });
      Fluttertoast.showToast(msg:"No Internet Connection");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBookingDetail();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
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
          title:Text(
            "Booking Detail",
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
            child: !loading?model!=null?SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  CarouselSlider(
                      items: model!.image!
                          .map(
                            (item) => ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        item,
                                      ),
                                      fit: BoxFit.fill)),
                            )),
                      )
                          .toList(),
                      carouselController: controller,
                      options: CarouselOptions(
                          scrollPhysics: const BouncingScrollPhysics(),
                          autoPlay: true,
                          aspectRatio: 1.8,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              selected = index;
                            });
                          })),
                  const SizedBox(
                    height: 10,
                  ),
                  sliderPointers(model!.image!, selected),
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

                          model?.bookedByVendor==1?SizedBox.shrink():
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
                                      model!.bookingName ?? "",
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
                                      model!.bookingMobile ?? "",
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: colors.secondary
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          model?.bookedByVendor==1?SizedBox.shrink():
                          const SizedBox(height: 15,),
                          model?.bookedByVendor==1?SizedBox.shrink():
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
                                    const SizedBox(height: 5,),
                                    Text(
                                      model!.bookingEmail ?? "",
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
                                    Text(
                                      model!.address ?? "",
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: colors.secondary
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          model?.bookedByVendor==1?SizedBox.shrink():
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
                                      model!.bookingDate ?? "",
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
                                      "${model!.bookingFrom} - ${model!.bookingTo}",
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: colors.secondary
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          model?.bookedByVendor==1?
                          const SizedBox(height: 15,):
                              SizedBox.shrink(),
                          model?.bookedByVendor==1?
                          Text('This is Offline Booking'):
                          SizedBox.shrink(),




                          const SizedBox(height: 15,),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
}
