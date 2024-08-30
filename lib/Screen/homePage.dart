import 'dart:convert';
import 'dart:developer';

import 'package:bookplayapp/Helper/color.dart';
import 'package:bookplayapp/Helper/common.dart';
import 'package:bookplayapp/Screen/add_ground_screen.dart';
import 'package:bookplayapp/Screen/galf_ground.dart';
import 'package:bookplayapp/Screen/totalBookingScreen.dart';
import 'package:bookplayapp/Screen/totalearning.dart';
import 'package:bookplayapp/Services/api_services/apiConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/groundListResponse.dart';
import '../Model/homeCatResponse.dart';
import '../Model/vendor_home_response.dart';
import '../Services/api_services/apiBasehelper.dart';
import '../Services/api_services/apiStrings.dart';
import 'bottomScreen.dart';
import 'previous_booking.dart';
import 'upcommingBooking.dart';
class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  List<HomeCatList> catList = [];

  List<String> imgList = [
    'assets/images/Group 75120.png',
    'assets/images/Group 75121.png',
    'assets/images/Group 75122.png',
    'assets/images/Group 75123.png',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeCategory();
    vendorHomeData();
    getProfile();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddGroundScreen()));
          if(result!=null){
            homeGround(catList[catCurrentIndex].id.toString() ?? '');
          }
          },
        backgroundColor: colors.btn,
        child:const Icon(Icons.add),
      ),
      body: isLoading?const Center(child: CircularProgressIndicator(),) :



        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.only(top: 20),
          child:
          RefreshIndicator(
            onRefresh: ()async {
              homeCategory();
              vendorHomeData();
              getProfile();

            },
            child: ListView(
              children: [
                Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  elevation: 2,
                  child: TextFormField(
                    onChanged: (value) {


                      searchLeads(value);
                    },
                    decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Search Ground',
                      hintStyle: const TextStyle(color: colors.test,fontSize: 13,fontWeight: FontWeight.bold),
                      prefixIcon: const Icon(
                        Icons.search,size: 25,
                        color: Colors.black,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_month_sharp,color: Colors.black,)
                        ,onPressed: () {
                        setState(() {

                        });
                        _showMyDialog();

                      },),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white, width: 1)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white, width: 1)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [


                    InkWell(
                        onTap: () {

                          Navigator.push(context, MaterialPageRoute(builder: (context) =>Totalbooking(vendorHomeResponse: vendorHomeResponse),));


                        },
                        child: topContainer(title: 'Booking', value: '${vendorHomeResponse?.data.totalBooking.count??0}')),


                    InkWell(

                        onTap: () {


                          Navigator.push(context, MaterialPageRoute(builder: (context) =>Upcoming_booking(vendorHomeResponse: vendorHomeResponse),));
                        },

                        child: topContainer(title: 'Upcoming Bookings', value: '${vendorHomeResponse?.data.upcomingBooking.count??0}')),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [


                    InkWell(
                        onTap: () {

                          Navigator.push(context, MaterialPageRoute(builder: (context) =>Total_earning(vendorHomeResponse: vendorHomeResponse),));


                        },
                        child: topContainer(title: 'Total Earning', value: '${vendorHomeResponse?.data.totalEarning.count??0}')),

                    InkWell(

                        onTap: () {

                          Navigator.push(context, MaterialPageRoute(builder: (context) =>Previousbooking( vendorHomeResponse: vendorHomeResponse),));


                        },
                        child: topContainer(title: 'Previous Bookings', value: '${vendorHomeResponse?.data.previousBooking.count??0}'))
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                catList.isEmpty?Container(
                  height: 60,
                  child: Center(child: Text("Categories Not Found"),),):
                // getCatListView(),


                SingleChildScrollView(

                  child: Row(
                    children: [

                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width/1.2



                        ,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: catList.length??0,
                          itemBuilder: (context, index) {
                            return


                              InkWell(
                                onTap: () {

                                  selectedCategory(index);


                                },
                                child: Card(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:

                                      catCurrentIndex==index?colors.secondary:
                                      Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 10,
                                          spreadRadius: 0,
                                        ),
                                      ],
                                      borderRadius:
                                      BorderRadius.circular(5.0),
                                    ),
                                    height: 40,
                                    width: 105,
                                    child: Center(
                                      child:

                                      Text(
                                        '${catList[index].title}',
                                        style: TextStyle(fontSize: 13),

                                      ),
                                    ),
                                  ),
                                ),
                              );


                          },
                        ),
                      ),
                    ],
                  ),
                ),


                const SizedBox(height: 2,),
                sliderPointers (),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'My Ground',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                groundList.isEmpty?SizedBox(

                  height: MediaQuery.of(context).size.height/5,
                  child: const Center(child: Text("No Ground Found Please add the ground",style: TextStyle(fontWeight: FontWeight.bold),),),
                ):
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.all(0),
                    itemCount: groundList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10.0,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  GolfGroungScreen(groundId: groundList[index].id.toString(),)),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey,
                              image: DecorationImage(
                                  image: NetworkImage(groundList[index].image!),
                                  fit: BoxFit.fill)),
                          child: Container(
                            margin: const EdgeInsets.only(top: 100),
                            color: Colors.transparent.withOpacity(0.3),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  groundList[index].title ?? '',
                                  style:const  TextStyle(color: Colors.white, fontSize: 14),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width/3.5,
                                      child: Text(

                                        groundList[index].address ?? '',
                                        style: TextStyle(

                                          color: Colors.white, fontSize: 12,


                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),


        ),
    );
  }
  int catCurrentIndex = 0 ;
  bool isGroundLoading =false ;

  Widget helperSection({required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(blurRadius: 0.1, color: Colors.grey.withOpacity(0.3))
      ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            color: colors.secondary,
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }


  Widget getCatListView() {

    return  SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: List.generate(/*catC.catList.length*/4, (index) {

        return InkWell(
          onTap: (){
            selectedCategory(index);
            setState(() {

            });
          },
          child: Card(
            child: Container(
              height: 35,
              width: 100,
              decoration: BoxDecoration(
                color: catList.isNotEmpty&&( catList[index].isSelected ?? false)? Colors.grey.withOpacity(0.5) : colors.whiteTemp,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/images/hockey.png',scale:1.5),
                  Text(catList.isNotEmpty?catList[index].title ?? '':"")
                ],
              ),

            ),
          ),
        );
      })),
    );

  }


  void selectedCategory(int index){
    catCurrentIndex = index ;
    catList.forEach((element) {element.isSelected = false ;});
    catList[index].isSelected = true ;
    homeGround(catList[index].id.toString() ?? '');
    // homeGround(catList[index].id.toString() ?? '');
  }

  Widget sliderPointers () {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        catList
            .asMap()
            .entries
            .map((entry) {
          return GestureDetector(
            // onTap:()=> controller.carouselController.animateToPage(entry.key),
            child: Container(
              width: catCurrentIndex == entry.key ? 25 : 12,
              height: 4.0,
              margin: const EdgeInsets.symmetric(
                horizontal: 3.0,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: catCurrentIndex == entry.key
                      ? colors.secondary
                      : Colors.grey
              ),
            ),
          );
        }).toList());
  }


  Widget topContainer({required String title, required String value}) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Stack(
        children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.4,
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(blurRadius: 0.1, color: Colors.grey.withOpacity(0.3))
            ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                )),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              backgroundColor: colors.secondary,
              radius: 21,
              child: Text(
                value,
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool isLoading = false ;
  List<GroundList> groundList = [];
  String? userId;


  VendorHomeResponse ? vendorHomeResponse ;



  Future <void> getProfile () async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
     var userId = preferences.getString('userId');
    }
    );
    print('1');
    var param = {
      'user_id': userId.toString(),
    };
    print('2');

    apiBaseHelper.postAPICall(getProfileApi, param).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        print('3');

        print('${getData['data']['address']}');

        setState(() {
          username = getData['data']['first_name'].toString();
          imagefiledummy=getData['data']['user_image'].toString();
        });
        setState(() {

        });
        print('4');

      } else {
      }

    });
  }

  Future<void> vendorHomeData() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();

    userId =  preferences.getString('userId');

    print('${userId}');


    var param = {
      'vendor_id': userId.toString(),
    };
    apiBaseHelper.postAPICall(getVendorHomeData, param).then((getData) async {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        vendorHomeResponse = VendorHomeResponse.fromJson(getData);

        // SharedPre.setValue('userData', jsonEncode(getData['user']));
        // String user = await SharedPre.getStringValue('userData');

        //var data = jsonDecode(user);
      } else {

      }
      setState(() {
        isLoading = false;
      });    });
  }

  Future<void> homeCategory() async {
    apiBaseHelper.getAPICall(homeCategoryAPI).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];
      if (error) {
        catList = (getData['data'] as List).map((e) => HomeCatList.fromJson(e)).toList();

        setState(() {

        });

      } else {
      }

    });
    homeGround('');
  }


  Future<void> homeGround(String catId) async {

    isGroundLoading = true ;
    await App.init();
    var parm ={
      'vendor_id' : App.localStorage.getString("userId") ?? '131'
    };

    apiBaseHelper.postAPICall(Uri.parse('${baseUrl}ground_listing?category_id=$catId'),parm).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      print(getData);
      if (error) {
        groundList = (getData['data'] as List).map((e) => GroundList.fromJson(e)).toList();
        isGroundLoading = false ;

        setState(() {

        });

      } else {
        groundList = [] ;
        isGroundLoading = false ;
        setState(() {

        });
        //update();
      }
    });
  }

  searchLeads(String value) {
    if (value.isEmpty) {
      homeGround("");
     setState(() {

     });
    }

    else{
      final suggestions = groundList.where((element) {
        final defautPrice=element.defaultPrice.toString().toLowerCase();
        final leadsTitle = element.title.toString().toLowerCase();
        final leadsPhone = element.address.toString().toLowerCase();
        final leadCategory = element.categoryTitle.toString().toLowerCase();
        final leadFacility = element.facility.toString().toLowerCase();
        // final leadsId = element.agreementid.toString().toLowerCase();
        final input = value.toLowerCase();
        return leadsTitle.contains(input) || leadsPhone.contains(input) || leadFacility.contains(input) || leadCategory.contains(input)||defautPrice.contains(input)
        // || leadsId.contains(input)
            ;
      }).toList();
      groundList = suggestions;
     setState(() {

     });
    }
  }



  Future <void> searchbytimeslot () async{



    var param = {
      'category_id': "${timeslotSectcat.toString()}",
      'date': "${datecontroller.text.toString()}",
      'time': '${timeController.text.toString()}'
    };

    apiBaseHelper.postAPICall(SearchbytimeSlotAPI, param).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {



        groundList = (getData['data'] as List).map((e) => GroundList.fromJson(e)).toList();
        datecontroller.clear();
        timeController.clear();
      setState(() {

      });
Navigator.pop(context);


      } else {
        Navigator.pop(context);

        Fluttertoast.showToast(msg: msg.toString());
        groundList.clear();
        setState(() {

        });
      }
    });
  }
  final formKey = GlobalKey<FormState>();
  var timeslotSectcat;

  TextEditingController   datecontroller=TextEditingController();
  TextEditingController   timeController=TextEditingController();
  var selectCatIddd;
  DateTime selectedDate = DateTime.now();
  Future<void> sselectDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(

      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate)

      selectedDate = picked;
    datecontroller.text=
        DateFormat('dd-MM-yyyy').format(selectedDate);
    print("==================${datecontroller.text}");


   setState(() {

   });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return
        StatefulBuilder(builder: (context, setState) {

          return

            AlertDialog(

                backgroundColor: Colors.white,
                actions:[


                  Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Text('Search By Time Slot',style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 20,),
                          catList.isEmpty
                              ? SizedBox(
                            height: 50,
                            width: MediaQuery.of(context)
                                .size
                                .width,
                            child: const Center(
                              child: Text(
                                  'Categories Not Available'),
                            ),
                          )
                              : SingleChildScrollView(
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(
                                      context)
                                      .size
                                      .width /
                                      1.5,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection:
                                    Axis.horizontal,
                                    physics:
                                    const AlwaysScrollableScrollPhysics(),
                                    itemCount: catList
                                        .length ??
                                        0,
                                    itemBuilder:
                                        (context, index) {
                                      return InkWell(
                                        onTap: () {

                                          setState(() {
                                            timeslotSectcat =
                                                index;
                                          });


                                          selectCatIddd =
                                              catList[
                                              index]
                                                  .id;

                                        },
                                        child: Card(
                                          child:
                                          Container(
                                            decoration:
                                            BoxDecoration(
                                              color: timeslotSectcat ==
                                                  index
                                                  ?
                                              Colors.blue
                                                  : Colors
                                                  .white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors
                                                      .grey
                                                      .withOpacity(0.5),
                                                  blurRadius:
                                                  10,
                                                  spreadRadius:
                                                  0,
                                                ),
                                              ],
                                              borderRadius:
                                              BorderRadius.circular(
                                                  5.0),
                                            ),
                                            height: 40,
                                            width: 105,
                                            child: Center(
                                              child: Text(
                                                '${catList[index].title}',
                                                style: TextStyle(
                                                    fontSize:
                                                    13,
                                                    color: timeslotSectcat == index
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10)),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: TextFormField(
                                onTap: () {
                                  sselectDate(context);
                                },
                                readOnly: true,
                                controller:
                                datecontroller,
                                decoration: InputDecoration(
                                    hintText: " Select Date",
                                    border: InputBorder.none,
                                    contentPadding:
                                    EdgeInsets.only(top: 15),
                                    suffixIcon: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons
                                            .calendar_month_sharp,
                                        color: Colors.black,
                                      ),
                                    )),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty) {
                                    return ' Please Select Date';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10)),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: TextFormField(
                                readOnly: true,
                                onTap:() async {


                                  TimeOfDay? picked = await selectTime(context);
                                  if (picked != null) {
                                    DateTime dateTime = DateTime(
                                        2020, 10, 10, picked!.hour, picked!.minute);
                                    setState(() {
                                      timeController.text =
                                      "${DateFormat("HH").format(dateTime)}:00";
                                      print(timeController.text);
                                    });
                                  }
                                },

                                controller:
                                timeController,
                                decoration: InputDecoration(
                                    counterText: "",
                                    hintText: " Time",
                                    border: InputBorder.none,
                                    contentPadding:
                                    EdgeInsets.only(top: 15),
                                    suffixIcon: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons
                                            .watch_later_outlined,
                                        color: Colors.black,
                                      ),
                                    )),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty) {
                                    return ' Please Enter Time';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue),
                                child: const Text("Back"),
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue),
                                child: const Text("Search"),
                                onPressed: () {
                                  if (formKey.currentState!
                                      .validate()) {
                                    if (
                                    selectCatIddd ==
                                        null) {
                                      Fluttertoast.showToast(
                                          msg:
                                          "Select Category");
                                    } else {


                                      searchbytimeslot();
                                    }
                                  }
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ]
            );

        },);





      },
    );
  }
  Future<TimeOfDay?> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext? context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context!).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });

    return picked;
  }
}