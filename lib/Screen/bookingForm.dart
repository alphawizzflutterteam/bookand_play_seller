import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../Helper/color.dart';
import '../Model/getSlotModel.dart';
import '../Services/api_services/apiBasehelper.dart';
import '../Services/api_services/apiStrings.dart';
import '../Widget/custum_appbar.dart';
class BookingForm extends StatefulWidget {
  String ?groundId;
   BookingForm({Key? key,this.groundId}) : super(key: key);

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {

  @override
  Widget build(BuildContext context) {
    return

      SafeArea(
        child: Scaffold(
            body:
            Stack(
              children: [
                CustomAppBar(
                    onPressedLeading: () {
                      Navigator.pop(context);
                    },
                    title: 'Booking Form'),
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
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Form(
                          key: formKey,
                          child: Column(children: [


                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Date",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              readOnly: true,
                              onTap: () {
                               sselectDate(context);
                              },
                              autofocus: false,
                              controller: datecontroller,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.calendar_month_sharp,
                                      color: Colors.grey),
                                  hintText: "Select Booking Date",
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(6.0)),
                                      borderSide: BorderSide(color: Colors.white)),
                                  contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide:
                                      BorderSide(color: Colors.white, width: 3.0))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Select Date';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Time",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            timeSlot2.isEmpty
                                ? Container(
                              height: 50,
                              child: Center(
                                child: Text('Please Select Date'),
                              ),
                            )
                                : Container(
                              height: 50,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: AlwaysScrollableScrollPhysics(),
                                itemCount: timeSlot2.length,
                                itemBuilder: (context, index) {



                                  var timeslot = timeSlot2[index].time;

                                  List<String>? timeParts = timeslot?.split(':');
                                  var timeslott = timeParts?[0];

                                  TimeOfDay currentTime = TimeOfDay(
                                      hour: int.parse(timeslott.toString()),
                                      minute: 0);
                                  TimeOfDay newTime = currentTime.replacing(
                                      hour: currentTime.hour + 1);

                                  var CheckTime =
                                      "${datecontroller.text} ${timeSlot2[index].time}:00.000";

                                  DateTime dateTimeofIndex =
                                  DateTime.parse(CheckTime);


                                  DateTime dateTimechek =
                                  DateTime.parse("2023-11-20 00:00:00.000");

                                  return


                                    dateTimeofIndex.isBefore(DateTime.now())
                                        ? SizedBox()
                                        : timeSlot2[index].isBooked != 1
                                        ? InkWell(
                                      onTap: () {

                                        tabIndex = index;
                                      setState(() {

                                      });
                                        var timeslotA =
                                            timeSlot2[index].time;
setState(() {

});
                                        List<String>? timeParts =
                                        timeslotA.split(':');
                                        var timeslott = timeParts[0];

                                        TimeOfDay currentTime1 =
                                        TimeOfDay(
                                            hour: int.parse(
                                                timeslott.toString()),
                                            minute: 0);
                                       selectTimeFrom =
                                        "${currentTime1.hour}:00";

                                        TimeOfDay newTime =
                                        currentTime.replacing(
                                            hour: currentTime1.hour +
                                                1);
                                        selectTimeTo =
                                        "${newTime.hour}:00";
                                      setState(() {

                                      });
                                      },
                                      child: Card(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color:
                                                tabIndex ==
                                                    index
                                                    ? Colors.black
                                                    : Colors.white,
                                                width: 2),
                                            color:
                                                timeSlot2[index]
                                                .isBooked !=
                                                1
                                                ? Colors.greenAccent
                                                : Colors.grey,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                blurRadius: 10,
                                                spreadRadius: 0,
                                              ),
                                            ],
                                            borderRadius:
                                            BorderRadius.circular(
                                                5.0),
                                          ),

                                          height: 40,

                                          // width: 105,

                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(5),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceEvenly,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${timeSlot2[index].time}',
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text(
                                                      'To',
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text(
                                                      '${newTime.hour}:00',
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                        : InkWell(
                                      onTap: () {
                                        Fluttertoast.showToast(
                                            msg:
                                            'This Time Slot Not Available Please Select Other Time Slot');
                                      },
                                      child: Card(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color:
                                                tabIndex ==
                                                    index
                                                    ? Colors.black
                                                    : Colors.white,
                                                width: 2),
                                            color:
                                                timeSlot2[index]
                                                .isBooked !=
                                                1
                                                ? Colors.greenAccent
                                                : Colors.grey,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                blurRadius: 10,
                                                spreadRadius: 0,
                                              ),
                                            ],
                                            borderRadius:
                                            BorderRadius.circular(
                                                5.0),
                                          ),

                                          height: 40,

                                          // width: 105,

                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(5),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceEvenly,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${timeSlot2[index].time}',
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text(
                                                      'To',
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text(
                                                      '${newTime.hour}:00',
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                },
                              ),
                            ),

                            SizedBox(
                              height: 70,
                            ),



                            InkWell(
                              onTap: () {

                                if (formKey.currentState!.validate()) {
                                  if (selectTimeFrom == null) {
                                    Fluttertoast.showToast(
                                        msg: 'Please Select Time Slot');
                                  } else {
                                  BookGround();
                                  }
                                }

                              },
                              child: Container(height: 40,width: MediaQuery.of(context).size.width/1.5,

                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),


                                  color: colors.secondary),
                                child: Center(child: Text('Book'),),
                              ),
                            ),

                            SizedBox(
                              height: 20,
                            ),

                          ]),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )


        ),
      );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  final formKey = GlobalKey<FormState>();
  String ?msg;
  int ?totalAmount;
  var selectTimeFrom;
  var selectTimeTo;
  int ?tabIndex=0;
  var checkTime;
  int?finalAmount;
  List<Slot> timeSlot2=[];
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
        DateFormat('yyyy-MM-dd').format(selectedDate);
    print("==================${datecontroller.text}");
    availableSlot();


    setState(() {

    });
  }
  TimeslotModel?timeslotModel;
  Future<void> availableSlot() async{
    print('get details');
    var param = {

      "ground_id":widget.groundId.toString(),
      "date":datecontroller.text

    };
    apiBaseHelper.postAPICall(AvailableTimeSlot, param).then((getData) {
      bool error = getData['status'];
      msg = getData['message'];

      if (error) {
        var finalresult=TimeslotModel.fromJson(getData);
        timeslotModel=finalresult;
        timeSlot2=timeslotModel!.data.slots;
setState(() {

});


      } else {

      }
    });

  }

  String ?msg1;
  Future<void> BookGround() async{
    var param = {

      'ground_id': widget.groundId.toString(),
      'booking_date': datecontroller.text,
      'booking_time_from': selectTimeFrom.toString(),
      'booking_time_to': selectTimeTo.toString(),
    };
    apiBaseHelper.postAPICall(BookingGround, param).then((getData) {
      print(getData);
      bool error = getData['status'];
      msg = getData['message'];

      if (error) {

        Fluttertoast.showToast(msg: msg.toString());
       Navigator.pop(context);


      } else {

      }
    });

  }
  TextEditingController datecontroller=TextEditingController();

}


