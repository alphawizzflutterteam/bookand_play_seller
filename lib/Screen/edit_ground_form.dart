// import 'package:bookplayapp/Helper/appBar.dart';
// import 'package:bookplayapp/Screen/backGround.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import '../Model/ground_detail_response.dart';
// import '../Services/api_services/apiBasehelper.dart';
// import '../Services/api_services/apiConstants.dart';
// import '../Services/api_services/apiStrings.dart';
// import '../helper/btn.dart';
// import '../helper/color.dart';
//
// class edit_ground extends StatefulWidget {
//   GroundDetailResponse?groundDetailResponse;
//   edit_ground({Key? key,this.groundDetailResponse,t}) : super(key: key);
//
//   @override
//
//   State<edit_ground> createState() => _edit_groundState();
// }
//
// class _edit_groundState extends State<edit_ground> {
//
//
//   CarouselController controller = CarouselController();
//   int selected = 0;
//   TextEditingController address1Controller = TextEditingController();
//   TextEditingController timefromController = TextEditingController();
//   TextEditingController timetoController = TextEditingController();
//
//   TextEditingController discruptioncontroller = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   String _inputText = '';
//   int selectedIndex = 99;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   address1Controller.text= widget.groundDetailResponse?.data?.address.toString()??'';
//   timefromController.text= widget.groundDetailResponse?.data?.openingTime.toString()??'';
//   timetoController.text= widget.groundDetailResponse?.data?.closingTime.toString()??'';
//     discruptioncontroller.text= widget.groundDetailResponse?.data?.description.toString()??'';
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Stack(
//         children: [
//           CommonBgWidget(),
//           Scaffold(
//               backgroundColor: Colors.transparent,
//               appBar: PreferredSize(
//                   preferredSize: Size.fromHeight(80),
//                   child: commonAppBar(context, text: "Edit Ground Form")),
//               body: bodyWidget()),
//         ],
//       ),
//     );
//   }
//
//   Widget bodyWidget() {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//       //    padding: EdgeInsets.symmetric(horizontal: 20),
//       child: Form(
//         key: _formKey,
//         child: ListView(
//             physics: BouncingScrollPhysics(),
//             //crossAxisAlignment: CrossAxisAlignment.center,
//             //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 "Edit Location",
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: colors.testline),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               TextFormField(
//                 style: TextStyle(color: colors.black54),
//                 controller: address1Controller,
//                 cursorColor: Colors.black54,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//                   fillColor: Colors.white,
//                   hintText: 'Edit Location',
//                   focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                   errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                 ),
//                 validator: (v) {
//                   if (v!.isEmpty) {
//                     return "Location is required";
//                   }
//                 },
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 'Edit Open Time',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextFormField(
//                 maxLength: 2,
//                 style: TextStyle(color: colors.black54),
//                 controller: timefromController,
//                 cursorColor: Colors.black54,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//                   fillColor: Colors.white,
//                   hintText: '',
//                   focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                   errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//               counterText: ""
//                 ),
//                 validator: (v) {
//                   if (v!.isEmpty) {
//                     return "Open Time is Required";
//                   }
//                   else if(int.parse(v)>24)
//                     {
//                       return "Time Should Not Greater Than 24";
//                     }
//                 },
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 'Edit Close Time',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextFormField(
//                 maxLength: 2,
//                 style: TextStyle(color: colors.black54),
//                 controller: timetoController,
//                 cursorColor: Colors.black54,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//                   fillColor: Colors.white,
//                   hintText: '',
//                   focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                   errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                counterText: ""
//                 ),
//                 validator: (v) {
//                   if (v!.isEmpty) {
//                     return "Close Time is required";
//                   }
//                   else if(int.parse(v)>24)
//                   {
//                     return "Time Should Not Greater Than 24";
//                   }
//                 },
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 'Edit Holidays',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextFormField(
//                 style: TextStyle(color: colors.black54),
//                 controller: address1Controller,
//                 cursorColor: Colors.black54,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//                   fillColor: Colors.white,
//                   hintText: '',
//                   focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                   errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                 ),
//                 validator: (v) {
//                   if (v!.isEmpty) {
//                     return "Holidays is required";
//                   }
//                 },
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 'Edit Images',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextFormField(
//                 style: TextStyle(color: colors.black54),
//                 controller: address1Controller,
//                 cursorColor: Colors.black54,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//                   fillColor: Colors.white,
//                   hintText: ' ',
//                   focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                   errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                 ),
//                 validator: (v) {
//                   if (v!.isEmpty) {
//                     return "Image is required";
//                   }
//                 },
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 'Edit Facilities',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextFormField(
//                 style: TextStyle(color: colors.black54),
//                 controller: address1Controller,
//                 cursorColor: Colors.black54,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//                   fillColor: Colors.white,
//                   hintText: ' Edit Facilities',
//                   focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                   errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                 ),
//                 validator: (v) {
//                   if (v!.isEmpty) {
//                     return " Edit Facilities is required";
//                   }
//                 },
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 'Edit Description',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextFormField(
//                 style: TextStyle(color: colors.black54),
//                 controller: discruptioncontroller,
//                 cursorColor: Colors.black54,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//                   fillColor: Colors.white,
//                   hintText:
//                       'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
//                   focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                   errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colors.black12, width: 2)),
//                 ),
//                 validator: (v) {
//                   if (v!.isEmpty) {
//                     return "Descruption is required";
//                   }
//                 },
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(
//                     horizontal: MediaQuery.of(context).size.width * 0.13),
//                 child: FilledBtn(
//                   title: 'submit',
//                   onPress: () {
//                     if (_formKey.currentState!.validate()) {
//                       // If the form is valid, save the input.
//                       _formKey.currentState!.save();
//                       // Now, you can use the validated input, which is stored in _inputText.
//                       // print('Input Text: $_inputText');
//                     }
//                     // Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(builder: (context) => college_details()),
//                     // );
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//             ]),
//       ),
//     );
//   }
//
//   Future<void> Deleteground() async {
//
//
//     var parm ={
//
//
//     };
//     apiBaseHelper.postAPICall(updateGround,parm).then((getData) {
//       bool error = getData['status'];
//       String msg = getData['message'];
//
//
//       if (error) {
//
//         Navigator.pop(context);
//
//
//       } else {
//
//         Fluttertoast.showToast(msg: msg);
//
//
//         setState(() {
//
//         });
//         //update();
//       }
//     });
//   }
// }
import 'dart:async';
import 'dart:convert';

import 'package:bookplayapp/Helper/color.dart';
import 'package:bookplayapp/Helper/common.dart';
import 'package:bookplayapp/Model/cat_model.dart';
import 'package:bookplayapp/Services/api_services/apiBasehelper.dart';
import 'package:bookplayapp/Services/api_services/apiConstants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';

import '../Model/getfaciluityModel.dart';
import '../Model/ground_detail_response.dart';
import 'bottomScreen.dart';

class EditGround extends StatefulWidget {
  GroundDetailResponse? groundDetailResponse;

  EditGround({super.key, this.groundDetailResponse});

  @override
  State<EditGround> createState() => _EditGroundState();
}

class _EditGroundState extends State<EditGround> {
  TextEditingController nameCon = TextEditingController();
  TextEditingController priceCon = TextEditingController();
  TextEditingController descCon = TextEditingController();
  TextEditingController addressCon = TextEditingController();
  TextEditingController openTimeCon = TextEditingController();
  TextEditingController closeTimeCon = TextEditingController();
  bool loading = false;
  bool network = false;
  List<Datum> facilityList = [];
  List<CatModel> catList = [];
  String catId = "";
  List<String> selectedFacility = [];
  List<String> selectedHoliday = [];

  // List<File> imageList = [];
  FocusNode passNode = FocusNode();
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  String deviceDetails = "";

//   pickFile() async {
//     final ImagePicker picker = ImagePicker();
// // Pick an image.
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         File file = File(image!.path);
//         imageList.add(file);
//       });
//     } else {
//       Fluttertoast.showToast(msg: "Please Pick Again");
//     }
//   }

  getCategory() async {
    await App.init();
    network = true;

    if (network) {
      var response = await apiBaseHelper.getAPICall(
        Uri.parse("${baseUrl}ground_category"),
      );
      if (response['status']) {
        for (var v in response['data']) {
          catList.add(CatModel.fromJson(v));
        }
        if (catList.isNotEmpty) {
          // catId = catList.first.id.toString();
        }
      } else {
        Fluttertoast.showToast(msg: response['message']);
      }
    } else {
      setState(() {
        loading = false;
      });
      Fluttertoast.showToast(msg: "No Internet Connection");
    }
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

  void updateGroundApi() async {
    await App.init();

    ///MultiPart request
    network = true;
    if (network) {
      try {
        Map<String, String> param = {
          "address_link": '${locationLink.toString()}',
          "holiday": selectedHoliday.join(','),
          "ball_type": selectballcontroller.text,
          "ball_given": nomberofballcontroller.text,
          "title": nameCon.text,
          "opening_time": openTimeCon.text,
          "closing_time": closeTimeCon.text,
          "address": addressCon.text,
          "facilities": selectedFacility.join(","),
          "description": descCon.text,
          "default_price": priceCon.text,
          "category_id": catId.toString(),
          "ground_id":
              widget.groundDetailResponse?.data?.groundId.toString() ?? '',
        };
        var request = http.MultipartRequest(
          'POST',
          Uri.parse("${baseUrl}ground_update"),
        );
        Map<String, String> headers = {
          "token": App.localStorage.getString("token").toString(),
          // "Content-type": "multipart/form-data"
        };

        request.headers.addAll(headers);
        request.fields.addAll(param);
        print(request.fields.toString());
        print("request: " + request.toString());
        var res = await request.send();
        print("This is response:" + res.toString());
        setState(() {
          loading = false;
        });
        print(res.statusCode);
        final respStr = await res.stream.bytesToString();
        print(respStr.toString());
        if (res.statusCode == 200) {
          Map data = jsonDecode(respStr.toString());
          if (data['status']) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNavBar(),
                ));
            Fluttertoast.showToast(msg: data['message'].toString());
          } else {}
        }
      } on TimeoutException catch (_) {
        Fluttertoast.showToast(msg: "Something Went Wrong".toString());

        setState(() {
          loading = true;
        });
      }
    } else {
      Fluttertoast.showToast(msg: "No Internet Connection".toString());

      setState(() {
        loading = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getfacility();
    getCategory();
    setState(() {
      nameCon.text = widget.groundDetailResponse?.data?.title ?? '';
      addressCon.text = widget.groundDetailResponse?.data?.address ?? '';
      priceCon.text =
          widget.groundDetailResponse?.data?.defaultPrice.toString() ?? '';
      descCon.text = widget.groundDetailResponse?.data?.description ?? '';
      closeTimeCon.text = widget.groundDetailResponse?.data?.closingTime ?? '';
      openTimeCon.text = widget.groundDetailResponse?.data?.openingTime ?? '';
      holydaycontroller.text = widget.groundDetailResponse?.data?.holiday ?? '';

      nomberofballcontroller.text =
          widget.groundDetailResponse?.data?.ballGiven.toString() ?? '';
      _selectedBall = widget.groundDetailResponse?.data?.ballType == 'Tennis' ||
          widget.groundDetailResponse?.data?.ballType == 'Leather' ||
          widget.groundDetailResponse?.data?.ballType == 'Tennis/Leather Both' ?widget.groundDetailResponse?.data?.ballType : null;

      setState(() {
        catId = widget.groundDetailResponse?.data?.categoryId.toString() ?? '';

        print("=getcat===========${catId}");
      });

      for (int i = 0;
          i < widget.groundDetailResponse!.data!.facility!.length;
          i++) {
        selectedFacility.add(widget.groundDetailResponse!.data!.facility![i]);
        setState(() {});
      }

      var holyday = widget.groundDetailResponse!.data!.holiday!;
      selectedHoliday = holyday.split(',');

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 70,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_arrow_left),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: Common.commonGradient(),
            ),
          ),
          title: const Text(
            "Ground Form",
          ),
        ),
        backgroundColor: const Color(0xff96E7F7),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              )),
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            decoration: const BoxDecoration(
                color: Color(0xfff3f3f3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                )),
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Ground Name",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: nameCon,
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "Enter Ground Name",
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Price",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: priceCon,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "Enter Price",
                      fillColor: Colors.white,
                      counterText: '',
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Address",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    onTap: () {
                      showPlacePicker();
                    },
                    readOnly: true,
                    minLines: 3,
                    maxLines: 5,
                    controller: addressCon,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "Enter Address",
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Open Time",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: openTimeCon,
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay? picked = await selectTime(context);
                      if (picked != null) {
                        DateTime dateTime = DateTime(
                            2020, 10, 10, picked!.hour, picked!.minute);
                        setState(() {
                          openTimeCon.text =
                              "${DateFormat("HH").format(dateTime)}:00";
                          print(openTimeCon.text);
                        });
                      }
                    },
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "_:_",
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Close Time",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: closeTimeCon,
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay? picked = await selectTime(context);
                      if (picked != null) {
                        DateTime dateTime = DateTime(
                            2020, 10, 10, picked!.hour, picked!.minute);
                        setState(() {
                          closeTimeCon.text =
                              "${DateFormat("HH").format(dateTime)}:00";
                          print(closeTimeCon.text);
                        });
                      }
                    },
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "_:_",
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Category",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  catList.isEmpty
                      ? Container(
                          height: 50,
                          child: Center(
                            child: Text('Categorys Not Avaiable'),
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: catList.map((e) {
                              print(
                                  "cati indec id =========${e.id.toString()} ${catId}");
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    catId = e.id.toString();

                                    print(catId);
                                    print(catId.runtimeType);
                                  });
                                },
                                child: Container(
                                  color: catId == e.id.toString()
                                      ? colors.btn
                                      : Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 7),
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    e.title ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                            color: catId == e.id.toString()
                                                ? Colors.white
                                                : Colors.black),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    "Facility",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  facilityList.isEmpty
                      ? SizedBox(
                          height: 40,
                          child: Center(
                            child: Text("Facility Not Avaiable"),
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: facilityList.map((e) {
                              return InkWell(
                                onTap: () {
                                  if (selectedFacility.contains(e.title)) {
                                    setState(() {
                                      selectedFacility.remove(e.title);
                                    });
                                  } else {
                                    setState(() {
                                      selectedFacility.add(e.title);
                                    });
                                  }
                                },
                                child: Container(
                                  color: selectedFacility.contains(e.title)
                                      ? colors.btn
                                      : Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 7),
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    e.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                            color: selectedFacility
                                                    .contains(e.title)
                                                ? Colors.white
                                                : Colors.black),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Holiday",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: dayList.map((e) {
                  //       return InkWell(
                  //         onTap: () {
                  //           if (selectedHoliday.contains(e)) {
                  //
                  //             setState(() {
                  //               selectedHoliday.remove(e);
                  //             });
                  //           } else {
                  //             setState(() {
                  //               selectedHoliday.add(e);
                  //             });
                  //           }
                  //         },
                  //         child: Container(
                  //           color: selectedHoliday.contains(e)
                  //               ? colors.btn
                  //               : Colors.white,
                  //           padding: const EdgeInsets.symmetric(
                  //               horizontal: 15, vertical: 7),
                  //           margin: const EdgeInsets.only(right: 10),
                  //           child: Text(
                  //             e,
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .labelLarge!
                  //                 .copyWith(
                  //                 color: selectedHoliday.contains(e)
                  //                     ? Colors.white
                  //                     : Colors.black),
                  //           ),
                  //         ),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),

                  /*TextFormField(
                    onTap: () {
                      _selectDate(context);
                    },
                    readOnly: true,
                    controller: holydaycontroller,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "Select Holiday Date",
                      fillColor: Colors.white,
                      counterText: '',
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),*/
                  Container(height: 55, width: double.maxFinite,color: colors.whiteTemp,
                    child:  Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: selectedHoliday.isEmpty ?  InkWell(
                            onTap: (){
                              _selectDate(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text('Select Holiday Date',style: TextStyle(color: Colors.black87.withOpacity(0.6),fontSize: 16),),
                            ),
                          ):
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: List<Widget>.generate(selectedHoliday.length, (index) {
                              return SizedBox(
                                height: 50,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 5),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.secondary),
                                      padding: const EdgeInsets.all(10),
                                      child: Text(selectedHoliday[index]),),
                                    Positioned(
                                        right: 0,
                                        top: 0,
                                        child: InkWell(
                                          onTap: (){
                                            print(index);
                                            selectedHoliday.removeAt(index);
                                            setState(() {

                                            });
                                          },
                                          child: Container(

                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.primary),
                                              height: 15,
                                              child: const Icon(Icons.remove,size: 15,)),
                                        ))
                                  ],),
                              );
                            }),),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: (){
                                _selectDate(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.secondary),
                                padding: const EdgeInsets.all(10),
                                child: const Center(child: Icon(Icons.add),),),
                            ))
                      ],
                    ),),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Type Of Ball",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        focusColor: colors.grad1Color,
                        dropdownDecoration: BoxDecoration(
                            border: Border.all(color: colors.blackTemp)),

                        isExpanded: true,

                        hint: SizedBox(
                            width: MediaQuery.of(context).size.width / 2.1,
                            child: Text(
                              'Select Ball Type',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(color: Colors.black),
                            )),
                        // Not necessary for Option 1
                        value: _selectedBall,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedBall = newValue.toString();
                            if (_selectedBall == 'Tennis') {
                              setState(() {
                                selectballcontroller.text = 'tennis';
                                print(selectballcontroller.text);
                              });
                            } else if (_selectedBall == 'Leather') {
                              setState(() {
                                selectballcontroller.text = 'leather';
                                print(selectballcontroller.text);
                              });
                            } else {
                              setState(() {
                                selectballcontroller.text =
                                    'tennis/leather both';
                                print(selectballcontroller.text);
                              });
                            }
                          });
                        },
                        items: technician_typeList.map((location) {
                          return DropdownMenuItem(
                            child: new Text(location),
                            value: location,
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Number Of Ball",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  TextFormField(
                    controller: nomberofballcontroller,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "Number Of Ball",
                      fillColor: Colors.white,
                      counterText: '',
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  // Text(
                  //   "Images",
                  //   style: Theme.of(context).textTheme.bodyLarge,
                  // ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  // TextFormField(
                  //   onTap: () {
                  //     pickFile();
                  //   },
                  //   keyboardType: TextInputType.visiblePassword,
                  //   readOnly: true,
                  //   textInputAction: TextInputAction.next,
                  //   decoration: const InputDecoration(
                  //     hintText: "Pick Image",
                  //     fillColor: Colors.white,
                  //     filled: true,
                  //     enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.white)),
                  //     focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.white)),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  // imageList.isNotEmpty
                  //     ? SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: imageList.map((e) {
                  //       return Stack(
                  //         alignment: Alignment.topRight,
                  //         children: [
                  //           Image.file(
                  //             e,
                  //             height: 100,
                  //             width: 100,
                  //           ),
                  //           InkWell(
                  //             onTap: () {
                  //               setState(() {
                  //                 imageList.remove(e);
                  //               });
                  //             },
                  //             child: Container(
                  //               color: Colors.white,
                  //               padding: const EdgeInsets.all(5.0),
                  //               child: const Icon(
                  //                 Icons.close,
                  //                 size: 20,
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       );
                  //     }).toList(),
                  //   ),
                  // )
                  //     : const SizedBox(),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    minLines: 3,
                    maxLines: 5,
                    controller: descCon,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "Enter Description",
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Common.commonButton(
                      loading: loading,
                      width: MediaQuery.of(context).size.width * 0.6,
                      onPressed: () {
                        // if (nameCon.text == "") {
                        //   Fluttertoast.showToast(
                        //     msg: "Please Enter Ground Name",
                        //   );
                        //   return;
                        // }
                        // if (priceCon.text == "") {
                        //   Fluttertoast.showToast(
                        //     msg: "Please Enter Price",
                        //   );
                        //   return;
                        // }
                        // if (addressCon.text == "") {
                        //   Fluttertoast.showToast(
                        //     msg: "Please Enter Address",
                        //   );
                        //   return;
                        // }
                        // if (openTimeCon.text == "") {
                        //   Fluttertoast.showToast(
                        //     msg: "Please Select Open Time",
                        //   );
                        //   return;
                        // }
                        // if (closeTimeCon.text == "") {
                        //   Fluttertoast.showToast(
                        //     msg: "Please Select Close Time",
                        //   );
                        //   return;
                        // }
                        // if (catId =="") {
                        //   Fluttertoast.showToast(
                        //     msg: "Please Select Category",
                        //   );
                        //   return;
                        // }
                        if (selectedFacility.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Please Select Facility",
                          );
                          return;
                        }

                        if (holydaycontroller.text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Please Select Holiday Date",
                          );
                          return;
                        }
                        if (selectballcontroller.text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Please Select Ball Type",
                          );
                          return;
                        }
                        if (nomberofballcontroller.text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Please Enter Ball Number",
                          );
                          return;
                        }
                        if (descCon.text == "") {
                          Fluttertoast.showToast(
                            msg: "Please Enter Description",
                          );
                          return;
                        }

                        setState(() {
                          loading = true;
                        });
                        updateGroundApi();
                        //changePassword("");
                      },
                      title: "Submit",
                      context: context,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  GetFacility? getFacility;

  Future<void> getfacility() async {
    var request = http.Request('GET', Uri.parse('${baseUrl}ground_facility'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);
      String msg = finalresult['message'];
      bool error = finalresult['status'];
      if (error) {
        getFacility = GetFacility.fromJson(finalresult);

        for (int i = 0; i < getFacility!.data.length; i++) {
          facilityList.add(getFacility!.data[i]);
          setState(() {});
        }

        setState(() {});
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2400),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        var datetimeee = DateFormat('yyyy-MM-dd').format(selectedDate);

        print("==================${datetimeee}");

        selectedHoliday.add(datetimeee);

        //holidaydate = selectedHoliday.join(', ');

       // holydaycontroller.text = holidaydate.toString();
        print(holidaydate);
      });
    }
  }

  TextEditingController selectballcontroller = TextEditingController();
  TextEditingController nomberofballcontroller = TextEditingController();
  TextEditingController holydaycontroller = TextEditingController();

  String? _selectedBall;
  List<String> technician_typeList = [
    'Tennis',
    'Leather',
    'Tennis/Leather Both'
  ];

  var holidaydate;
  String? locationLink;

  void showPlacePicker() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker("AIzaSyDPsdTq-a4AHYHSNvQsdAlZgWvRu11T9pM")));

    // Check if the user picked a place
    if (result != null) {
      setState(() {
        addressCon.text = '${result.formattedAddress}';
        print(addressCon.text);

        lat = "${result.latLng!.latitude}";
        lang = "${result.latLng!.longitude}";

        locationLink =
            "https://www.google.com/maps/search/?api=1&query=$lat,$lang";
      });
    }
  }

  var lat;
  var lang;
}
