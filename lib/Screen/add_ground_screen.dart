import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
import 'bottomScreen.dart';

class AddGroundScreen extends StatefulWidget {
  const AddGroundScreen({super.key});

  @override
  State<AddGroundScreen> createState() => _AddGroundScreenState();
}

class _AddGroundScreenState extends State<AddGroundScreen> {
  String? locationLink;
  TextEditingController nameCon = TextEditingController();
  TextEditingController priceCon = TextEditingController();
  TextEditingController descCon = TextEditingController();
  TextEditingController addressCon = TextEditingController();
  TextEditingController openTimeCon = TextEditingController();
  TextEditingController closeTimeCon = TextEditingController();
  TextEditingController selectballcontroller = TextEditingController();
  TextEditingController nomberofballcontroller = TextEditingController();
  TextEditingController holydaycontroller = TextEditingController();
  bool loading = false;
  bool network = false;
  List<Datum> facilityList = [];

  String? _selectedLocation;
  List<String> technician_typeList = [
    'Tennis',
    'Leather',
    'Tennis/Leather Both'
  ];
  var holidaydate;

  // File ?file;
  List<CatModel> catList = [];
  String catId = "";
  List<String> selectedFacility = [];
  List<String> selectedHoliday = [];
  List<File> imageList = [];
  FocusNode passNode = FocusNode();
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  String deviceDetails = "";

  pickFile() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        File file = File(image.path);
        imageList.add(file);
      });
    } else {
      Fluttertoast.showToast(msg: "Please Pick Again");
    }
  }

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

  void addGroundApi() async {
    await App.init();

    ///MultiPart request
    network = true;
    if (network) {
      try {
        Map<String, String> param = {
          "address_link": '${locationLink.toString()}',
          "holiday": holidaydate.toString(),
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
          "vendor_id": App.localStorage.getString("userId").toString(),
        };
        var request = http.MultipartRequest(
          'POST',
          Uri.parse("${baseUrl}ground_create"),
        );
        Map<String, String> headers = {
          "token": App.localStorage.getString("token").toString(),
          // "Content-type": "multipart/form-data"
        };

        if (imageList.isNotEmpty) {
          // request.files.add(await http.MultipartFile.fromPath('[]', file!.path));
          // print(request.files);

          for (var licenseImage in imageList) {
            print(licenseImage.path);
            request.files.add(
              http.MultipartFile(
                'image[]',
                licenseImage.readAsBytes().asStream(),
                licenseImage.lengthSync(),
                filename: path.basename(licenseImage.path),
                contentType: MediaType('image', 'jpeg'),
              ),
            );
          }
        }
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
          } else {
            Fluttertoast.showToast(msg: data['message'].toString());
          }
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
    getCategory();
    getfacility();
  }

  @override
  Widget build(BuildContext context) {
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
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    catId = e.id.toString();
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

                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: facilityList.map((e) {
                  //       return InkWell(
                  //         onTap: () {
                  //           if (selectedFacility.contains(e)) {
                  //             setState(() {
                  //               selectedFacility.remove(e);
                  //             });
                  //           } else {
                  //             setState(() {
                  //               selectedFacility.add(e);
                  //             });
                  //           }
                  //         },
                  //         child: Container(
                  //           color: selectedFacility.contains(e)
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
                  //                     color: selectedFacility.contains(e)
                  //                         ? Colors.white
                  //                         : Colors.black),
                  //           ),
                  //         ),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),

                  facilityList.isEmpty
                      ? Container(
                          height: 50,
                          child: Center(
                            child: Text('Facility Not Avaiable'),
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
                  //
                  TextFormField(
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
                  ),
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
                    decoration:
                        const BoxDecoration(color: Colors.white),
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
                        value: _selectedLocation,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedLocation = newValue.toString();
                            if (_selectedLocation == 'Tennis') {
                              setState(() {
                                selectballcontroller.text = 'tennis';
                                print(selectballcontroller.text);
                              });
                            } else if (_selectedLocation == 'Leather') {
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

                  Text(
                    "Images",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    onTap: () {
                      pickFile();
                    },
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: true,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "Pick Image",
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  imageList.isNotEmpty
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: imageList.map((e) {
                              return Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Image.file(
                                    e,
                                    height: 100,
                                    width: 100,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        imageList.remove(e);
                                      });
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Icon(
                                        Icons.close,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        )
                      : const SizedBox(),
                  // file==null?
                  //     SizedBox():Container(
                  //   height: 70,
                  //   width: MediaQuery.of(context).size.width,
                  //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.greyColor,
                  //   image: DecorationImage(image: FileImage(file!),fit: BoxFit.cover)
                  //   ),
                  //
                  // ),

                  SizedBox(
                    height: 10,
                  ),
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
                        if (nameCon.text == "") {
                          Fluttertoast.showToast(
                            msg: "Please Enter Ground Name",
                          );
                          return;
                        }
                        if (priceCon.text == "") {
                          Fluttertoast.showToast(
                            msg: "Please Enter Price",
                          );
                          return;
                        }
                        if (addressCon.text == "") {
                          Fluttertoast.showToast(
                            msg: "Please Enter Address",
                          );
                          return;
                        }
                        if (openTimeCon.text == "") {
                          Fluttertoast.showToast(
                            msg: "Please Select Open Time",
                          );
                          return;
                        }
                        if (closeTimeCon.text == "") {
                          Fluttertoast.showToast(
                            msg: "Please Select Close Time",
                          );
                          return;
                        }
                        if (catId == "") {
                          Fluttertoast.showToast(
                            msg: "Please Select Category",
                          );
                          return;
                        }
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
                            msg: "Please Select Number Ball",
                          );
                          return;
                        }
                        if (imageList.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Please Select Image",
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
                        addGroundApi();
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
    var request = http.Request('GET',
        Uri.parse('${baseUrl}ground_facility'));

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
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var datetimeee = DateFormat('yyyy-MM-dd').format(selectedDate);

        print("==================${datetimeee}");

        selectedHoliday.add(datetimeee);

        holidaydate = selectedHoliday.join(', ');

        holydaycontroller.text = holidaydate.toString();
        print(holidaydate);
      });
  }

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
