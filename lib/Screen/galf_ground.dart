import 'dart:convert';
import 'dart:io';
import 'package:bookplayapp/Helper/appBar.dart';
import 'package:bookplayapp/Helper/color.dart';
import 'package:bookplayapp/Screen/backGround.dart';
import 'package:bookplayapp/Services/api_services/apiConstants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../Helper/common.dart';
import '../Model/getbookingslotlist.dart';
import '../Model/ground_detail_response.dart';
import '../Services/api_services/apiBasehelper.dart';
import '../Services/api_services/apiStrings.dart';
import 'bookingForm.dart';
import 'bottomScreen.dart';
import 'edit_ground_form.dart';
import 'package:http/http.dart' as http;

class GolfGroungScreen extends StatefulWidget {
  const GolfGroungScreen({super.key, this.groundId});

  final String? groundId;

  @override
  State<GolfGroungScreen> createState() => _GolfGroungScreenState();
}

class _GolfGroungScreenState extends State<GolfGroungScreen> {
  CarouselController controller = CarouselController();
  int selected = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    groundDetails();
    getSlot();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          const CommonBgWidget(),
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(80),
                  child: commonAppBar(context,
                      text: "Golf Ground", isActionButton: false)),
              body: bodyWidget()),
        ],
      ),
    );
  }

  List list = [1, 2, 3];
  List getbanner = [];
  bool isGroundLoading = false;

  GroundDetailResponse? groundDetailResponse;

  Widget bodyWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(top: 35),
      decoration: const BoxDecoration(
        color: colors.white10,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          // Top-left corner radius
          topRight: Radius.circular(30),
          // Bottom-right corner with no rounding
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            groundDetailResponse == null
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : CarouselSlider(
                    items: getbanner
                        .map(
                          (item) => Stack(children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            item.toString(),
                                          ),
                                          fit: BoxFit.fill)),
                                )),
                            Positioned(
                              top: 10,
                              left: MediaQuery.of(context).size.width / 1.25,
                              child: groundDetailResponse!
                                      .data!.bannerImage!.isEmpty
                                  ? const SizedBox()
                                  : IconButton(
                                      onPressed: () {
                                        deleatebanner(groundDetailResponse!
                                            .data!
                                            .bannerImage![selected]
                                            .imageId
                                            .toString());
                                        setState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: colors.secondary,
                                      )),
                            ),
                          ]),
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
            sliderPointers(getbanner, selected),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: colors.secondary,
                  radius: 10,
                  child: Icon(
                    Icons.pin_drop_rounded,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Text(
                    '${groundDetailResponse?.data?.address}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Timing',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    helper(
                        value1: 'Opening Time and Closing Time',
                        value2:
                            '${groundDetailResponse?.data?.openingTime} TO ${groundDetailResponse?.data?.closingTime}'),
                    const SizedBox(
                      height: 10,
                    ),
                    helper(
                        value1: 'Holiday',
                        value2: '${groundDetailResponse?.data?.holiday ?? ""}'),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Facilities',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            groundDetailResponse?.data?.facility == []
                ? Container(
                    height: 50,
                    child: const Center(
                      child: Text('Facility Not Avaiable'),
                    ),
                  )
                : Row(
                    children: List<Widget>.generate(
                        groundDetailResponse?.data?.facility?.length ?? 0,
                        (index) => Card(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: colors.secondary,
                                      radius: 10,
                                      child: Icon(
                                        Icons.pin_drop_rounded,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      '${groundDetailResponse?.data?.facility?[index]}',
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                  ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Description',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Card(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ground',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${groundDetailResponse?.data?.title}',
                      style: const TextStyle(
                          fontSize: 13, color: colors.secondary),
                    ),
                    Container(
                      child: Text(
                        "${groundDetailResponse?.data?.description}",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Time Slots",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            groundDetailResponse?.data?.groundTimeSlotes?.isEmpty ?? false ?SizedBox() :  Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              children: <Widget>[...generate_tags()],
            ),
            Row(
              children: [
                Text(
                  "Offer Slots",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            getslotList.isEmpty
                ? Container(
                    height: 60,
                    child: const Center(
                      child:
                          Text('Time Slot Not Available Please Add Time Slot'),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: getslotList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              Row(
                                children: [
                                  const Text('Day'),
                                  const Spacer(),
                                  Text('${getslotList[index].day}')
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                children: [
                                  const Text('Open Time'),
                                  const Spacer(),
                                  Text('${getslotList[index].openingTime}')
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                children: [
                                  const Text('Close Time'),
                                  const Spacer(),
                                  Text('${getslotList[index].closingTime}')
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                children: [
                                  const Text('Offer Price'),
                                  const Spacer(),
                                  Text('${getslotList[index].offerPrice}')
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                children: [
                                  const Text(''),
                                  const Spacer(),
                                  InkWell(
                                      onTap: () {
                                        deleteOfferSlot("${getslotList[index].id}");
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 20,
                                      ))
                                ],
                              ),
                            ]),
                          ),
                        ),
                      );
                    },
                  ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BookingForm(groundId: widget.groundId.toString()),
                    ));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: colors.secondary,
                    borderRadius: BorderRadius.circular(40)),
                child: const Center(
                  child: Text(
                    'Booking Now',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                showOptions(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: colors.secondary,
                    borderRadius: BorderRadius.circular(40)),
                child: const Center(
                  child: Text(
                    'Add Ground Image',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isaddTimeslot = true;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: colors.secondary,
                    borderRadius: BorderRadius.circular(40)),
                child: const Center(
                  child: Text(
                    'Add New Offer Time Slot',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ),
            isaddTimeslot
                ? Form(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "Select Days",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: dayList.map((e) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectdays = e.toString();
                                    print('${selectdays}====${e.toString()}');
                                  });
                                },
                                child: Container(
                                  color: selectdays == e.toString()
                                      ? colors.btn
                                      : Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 7),
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    e,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                            color: selectdays == e.toString()
                                                ? Colors.white
                                                : Colors.black),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "Open Time",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
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
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "Close Time",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
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
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "Price",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: priceCon,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
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
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            if (selectdays == null) {
                              Fluttertoast.showToast(msg: 'Please Select Day');
                            } else if (openTimeCon.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: 'Please Select Open Time');
                            } else if (closeTimeCon.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: 'Please Select Close Time');
                            } else if (priceCon.text.isEmpty) {
                              Fluttertoast.showToast(msg: 'Please Enter Price');
                            } else {
                              addtimeSlot();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                color: colors.secondary,
                                borderRadius: BorderRadius.circular(40)),
                            child: const Center(
                              child: Text(
                                'Add Time Slot',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditGround(
                                  groundDetailResponse: groundDetailResponse),
                            ));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: colors.secondary,
                            borderRadius: BorderRadius.circular(40)),
                        child: const Center(
                          child: Text(
                            'Edit Ground',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showAlertDialog(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: colors.secondary,
                            borderRadius: BorderRadius.circular(40)),
                        child: const Center(
                          child: Text(
                            'Delete Ground',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget sliderPointers(List doteList, int currentIndex) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: doteList.asMap().entries.map((entry) {
          return GestureDetector(
            // onTap:()=> controller.carouselController.animateToPage(entry.key),
            child: Container(
              width: currentIndex == entry.key ? 25 : 12,
              height: 4.0,
              margin: const EdgeInsets.symmetric(
                horizontal: 3.0,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: currentIndex == entry.key
                      ? colors.secondary
                      : Colors.grey),
            ),
          );
        }).toList());
  }

  Widget helper({
    required String value1,
    required String value2,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            child: Row(
          children: [
            const Icon(
              Icons.circle,
              size: 10,
              color: colors.secondary,
            ),
            const SizedBox(
              width: 2,
            ),
            Text(
              value1,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        )),
        Text(
          value2,
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }

  Future<void> groundDetails() async {
    isGroundLoading = true;
    var parm = {'ground_id': widget.groundId ?? ''};
    apiBaseHelper
        .postAPICall(Uri.parse('${baseUrl}vendor_ground_details'), parm)
        .then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      print(getData);
      if (error) {
        // groundList = (getData['data'] as List).map((e) => GroundList.fromJson(e)).toList();
        groundDetailResponse = GroundDetailResponse.fromJson(getData);

        if (groundDetailResponse!.data!.bannerImage!.isEmpty) {
          getbanner.add(groundDetailResponse!.data!.mainImage);
          setState(() {});
        } else {
          for (int i = 0;
              i < groundDetailResponse!.data!.bannerImage!.length;
              i++) {
            getbanner.add(groundDetailResponse!.data!.bannerImage![i].image);
            setState(() {});
          }
        }
        isGroundLoading = false;

        setState(() {});
      } else {
        // groundList = [] ;
        Fluttertoast.showToast(msg: msg);
        isGroundLoading = false;
        setState(() {});
        //update();
      }
    });
  }

  Future<void> Deleteground() async {
    isGroundLoading = true;
    var parm = {'ground_id': widget.groundId ?? ''};
    apiBaseHelper.postAPICall(deleteGround, parm).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        Fluttertoast.showToast(msg: msg);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomNavBar()));
      } else {
        Fluttertoast.showToast(msg: msg);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomNavBar()));

        isGroundLoading = false;
        setState(() {});
        //update();
      }
    });
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = OutlinedButton(
      child: const Text(
        "Yes",
        style: TextStyle(color: colors.primary),
      ),
      onPressed: () {
        Deleteground();
      },
    );

    Widget okButton2 = OutlinedButton(
      child: const Text(
        "No",
        style: TextStyle(color: colors.primary),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the button

    AlertDialog alert = AlertDialog(
      title: const Text("Are You Sure?"),
      content: const Text("You Want To Delete Ground"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            okButton,
            okButton2,
          ],
        )
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> addbanner() async {
    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}ground_image_add'));
    request.fields.addAll(
        {'ground_id': '${groundDetailResponse?.data?.groundId.toString()}'});
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile!.path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);
      bool error = finalresult['status'];
      String msg = finalresult['message'];

      setState(() {});

      if (error) {
        Fluttertoast.showToast(msg: msg);
        Navigator.pop(context);
      } else {}
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> deleatebanner(String imageid) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseUrl}ground_image_delete'));
    request.fields.addAll({'image_id': '${imageid.toString()}'});
    print(request.url);
    print(request.fields);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);
      bool error = finalresult['status'];
      String msg = finalresult['message'];

      setState(() {});

      if (error) {
        Fluttertoast.showToast(msg: msg);
        Navigator.pop(context);
        setState(() {});
      } else {}
    } else {
      print(response.reasonPhrase);
    }
  }

  Future showOptions(
    BuildContext context,
  ) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Pic Banner From Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
        ],
      ),
    );
  }

  File? imageFile;

  Future getImageFromGallery() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 20);
    imageFile = File(image!.path);
    print(imageFile);
    setState(() {});
    addbanner();
// Navigator.pop(context) ;
  }

  bool isaddTimeslot = false;
  var selectdays;

  TextEditingController openTimeCon = TextEditingController();
  TextEditingController closeTimeCon = TextEditingController();

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

  TextEditingController priceCon = TextEditingController();

  Future<void> addtimeSlot() async {
    isGroundLoading = true;
    var parm = {
      'ground_id': widget.groundId.toString(),
      'day': selectdays.toString(),
      'opening_time': openTimeCon.text,
      'closing_time': closeTimeCon.text.toString(),
      'price': priceCon.text.toString(),
    };
    apiBaseHelper
        .postAPICall(Uri.parse('${baseUrl}add_offers_slots'), parm)
        .then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        Fluttertoast.showToast(msg: msg.toString());

        Navigator.pop(context);
        setState(() {
          isaddTimeslot = false;
        });
      } else {
        Fluttertoast.showToast(msg: msg.toString());
        setState(() {
          isaddTimeslot = false;
        });
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  List<SlotList> getslotList = [];
  GettimeslotList? gettimeslotList;

  Future<void> getSlot() async {
    isGroundLoading = true;
    var parm = {
      'ground_id': widget.groundId.toString(),
    };
    apiBaseHelper
        .postAPICall(Uri.parse('${baseUrl}get_offers_slots'), parm)
        .then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        setState(() {
          getslotList = GettimeslotList.fromJson(getData).data;

          print("================${getslotList.length}");
        });
      }
    });
  }

  Future<void> deleteOfferSlot(String slotId) async {
    isGroundLoading = true;
    var parm = {
      'time_slot_id': slotId.toString(),
    };
    apiBaseHelper
        .postAPICall(Uri.parse('${baseUrl}delete_offers_slots'), parm)
        .then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        Fluttertoast.showToast(msg: msg.toString());

        Navigator.pop(context);
      } else {}
    });
  }

  generate_tags() {
    return groundDetailResponse?.data?.groundTimeSlotes?.map((tag) => get_chip('${tag.fromTime} to ${tag.toTime}', tag.id ?? 0)).toList();
  }
  get_chip(name, int id) {
    int? index = groundDetailResponse?.data?.groundTimeSlotes?.indexWhere((element) => '${element.fromTime} to ${element.toTime}' == name  ) ;
    return Row(children: [
      Stack(children: [
        FilterChip(
          selected: true/*selected_tags.contains(name)*/,
          selectedColor: colors.secondary,
          disabledColor: colors.secondary,
          labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          label: Text("${name}"), onSelected: (bool value) {  },),
        Positioned(
            right: 0,
            top: 0,
            child: InkWell(
              onTap: (){
                deleteTimeSlot(id.toString());
              },
              child: Container(

                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.primary),
                  height: 15,
                  child: const Icon(Icons.remove,size: 15,)),
            ))
      ],),
      index == (groundDetailResponse!.data!.groundTimeSlotes!.length  - 1) ?  Padding(
        padding: const EdgeInsets.only(left: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: colors.primary),
            onPressed: (){
              addTiSlot(
                 context,
              ) ;
            }, child: const Text('AddMore')),
      ) : SizedBox()
    ],);
  }


  Future<void> deleteTimeSlot(String slotId) async {
    isGroundLoading = true;
    var parm = {
      'slot_id': slotId,
    };
    apiBaseHelper
        .postAPICall(Uri.parse('${baseUrl}delete_ground_slots'), parm)
        .then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        Fluttertoast.showToast(msg: msg.toString());

        Navigator.pop(context);
      } else {}
    });
  }

  Future<void> addTimeSlotApi() async {
    isGroundLoading = true;
    var parm = {
    'ground_id':widget.groundId.toString(),
    'from_time':fromTimeC.text,
    'to_time':toTimeC.text,
    };
    apiBaseHelper
        .postAPICall(Uri.parse('${baseUrl}create_ground_slots'), parm)
        .then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        Fluttertoast.showToast(msg: msg.toString());

        Navigator.pop(context);
      } else {}
    });
  }

  TextEditingController fromTimeC = TextEditingController();
  TextEditingController toTimeC = TextEditingController();

  Future addTiSlot(
      BuildContext context,
      ) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Material(
        child: CupertinoActionSheet(

          title: const Text('Add Time Slot',textAlign: TextAlign.left,),
          actions: [
            CupertinoActionSheetAction(
              child: Column(
                children: [
                  Row(children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller:fromTimeC,
                        keyboardType: TextInputType.visiblePassword,
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? picked =
                          await selectTime(context);
                          if (picked != null) {
                            DateTime dateTime = DateTime(2020, 10,
                                10, picked!.hour, picked!.minute);
                            setState(() {
                              fromTimeC
                                  .text =
                              "${DateFormat("HH").format(dateTime)}:00";

                              print(openTimeCon.text);
                            });
                          }
                        },
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: "From:",
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: toTimeC,
                        keyboardType: TextInputType.visiblePassword,
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? picked =
                          await selectTime(context);
                          if (picked != null) {
                            DateTime dateTime = DateTime(2020, 10,
                                10, picked!.hour, picked!.minute);
                            setState(() {
                              toTimeC.text =
                              "${DateFormat("HH").format(dateTime)}:00";

                              print(closeTimeCon.text);
                            });
                          }
                        },
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: "To:",
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                  ],),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: colors.primary),
                      onPressed: (){
                        if(fromTimeC.text.isEmpty){
                          Fluttertoast.showToast(msg: 'Please add fromTime');
                        }else if (toTimeC.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'Please add toTime');
                        }else {
                          Navigator.of(context).pop();
                          addTimeSlotApi();
                        }

                      }, child: const Text('Add'))

                ],
              ),
              onPressed: () {
                // close the options modal
                Navigator.of(context).pop();
                // get image from gallery
              },
            ),
          ],
        ),
      ),
    );
  }



}
