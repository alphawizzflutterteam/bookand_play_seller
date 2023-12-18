import 'package:bookplayapp/Helper/appBar.dart';
import 'package:bookplayapp/Screen/backGround.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../helper/btn.dart';
import '../helper/color.dart';
class ground_form extends StatefulWidget {
  const ground_form({Key? key}) : super(key: key);

  @override
  State<ground_form> createState() => _ground_formState();
}

class _ground_formState extends State<ground_form> {
  CarouselController controller = CarouselController();
  int selected = 0;
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _inputText = '';
  int selectedIndex = 99;
  TextEditingController mobileController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          CommonBgWidget(),
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(80),
                  child: commonAppBar(context, text: "Ground Form")),
              body: bodyWidget()),
        ],
      ),
    );
  }
  Widget bodyWidget() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      //    padding: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: ListView(
            physics: BouncingScrollPhysics(),
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Add Location",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colors.testline ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(color: colors.black54),
                controller: address1Controller,
                cursorColor: Colors.black54,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  fillColor: Colors.white,
                  hintText: 'Enter Location',
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                ),
                validator: (v) {
                  if (v!.isEmpty) {
                    return "Enter Location is required";
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Add Open Time',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                style: TextStyle(color: colors.black54),
                controller: address1Controller,
                cursorColor: Colors.black54,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  fillColor: Colors.white,
                  hintText: '',
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                ),
                validator: (v) {
                  if (v!.isEmpty) {
                    return " .is required";
                  }
                },
              ),
              SizedBox(
                height:20,
              ),
              Text(
                'Add Close Time',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                style: TextStyle(color: colors.black54),
                controller: address1Controller,
                cursorColor: Colors.black54,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  fillColor: Colors.white,
                  hintText: '',
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                ),
                validator: (v) {
                  if (v!.isEmpty) {
                    return " . is required";
                  }
                },
              ),
              SizedBox(
                height:20,
              ),
              Text(
                'Add Holidays',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height:5,
              ),
              TextFormField(
                style: TextStyle(color: colors.black54),
                controller: address1Controller,
                cursorColor: Colors.black54,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  fillColor: Colors.white,
                  hintText: '',
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                ),
                validator: (v) {
                  if (v!.isEmpty) {
                    return " . is required";
                  }
                },
              ),
              SizedBox(
                height:20,
              ),
              Text(
                'Add Images',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height:5,
              ),
              TextFormField(
                style: TextStyle(color: colors.black54),
                controller: address1Controller,
                cursorColor: Colors.black54,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  fillColor: Colors.white,
                  hintText: ' ',
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                ),
                validator: (v) {
                  if (v!.isEmpty) {
                    return " . is required";
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Add Facilities',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height:5,
              ),
              TextFormField(
                style: TextStyle(color: colors.black54),
                controller: address1Controller,
                cursorColor: Colors.black54,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  fillColor: Colors.white,
                  hintText: ' Add Facilities',
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                ),
                validator: (v) {
                  if (v!.isEmpty) {
                    return " Add Facilities is required";
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Add Description',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height:5,
              ),
              TextFormField(
                style: TextStyle(color: colors.black54),
                controller: address1Controller,
                cursorColor: Colors.black54,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  fillColor: Colors.white,
                  hintText: '',
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: colors.black12, width: 2)),
                ),

                validator: (v) {
                  if (v!.isEmpty) {
                    return " .is required";
                  }
                },
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.13),
                child: FilledBtn(
                  title: 'submit',
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, save the input.
                      _formKey.currentState!.save();
                      // Now, you can use the validated input, which is stored in _inputText.
                      // print('Input Text: $_inputText');
                    }
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => college_details()),
                    // );

                  },
                ),

              ),
              SizedBox(
                height: 20,
              ),
            ]),
    ),
    );
  }
}



