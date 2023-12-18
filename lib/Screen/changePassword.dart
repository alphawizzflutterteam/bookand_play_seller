import 'package:bookplayapp/Helper/appBar.dart';
import 'package:bookplayapp/Screen/backGround.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../helper/color.dart';

class ConfirmPasswordPage extends StatefulWidget {
  const ConfirmPasswordPage({super.key});

  @override
  State<ConfirmPasswordPage> createState() => _ConfirmPasswordPageState();
}

class _ConfirmPasswordPageState extends State<ConfirmPasswordPage> {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  CarouselController controller = CarouselController();
  int selected = 0;
  @override
  Widget build(BuildContext context) {
  return SafeArea(
  child: Stack(
  children: [
  CommonBgWidget(),
  Scaffold(
  backgroundColor: Colors.transparent,
  appBar: PreferredSize(
  preferredSize: Size.fromHeight(100),
  child: commonAppBar(context, text: "Change Password")),
  body: bodyWidget()),
  ],
  ),
  );
  }

  Widget bodyWidget() {
    return Form(
      key: _formKey,
      child: Container(

        child: SingleChildScrollView(
          child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                'Old Password',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                style: TextStyle(color: colors.black54),
                controller: oldPassword,
                cursorColor: Colors.black54,
                obscureText: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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
                    return "Old Password is required";
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'New Password',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                style: TextStyle(color: colors.black54),
                controller: newPassword,
                cursorColor: Colors.black54,
                obscureText: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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
                    return "New Password is required";
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Confirm Password',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                style: TextStyle(color: colors.black54),
                controller: confirmPassword,
                cursorColor: Colors.black54,
                obscureText: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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
                    return "Confirm Password is required";
                  } else if (v != newPassword) {
                    return "Password not match";
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
          bottomSheet: Container(
            padding: EdgeInsets.only(bottom: 40),
            child: InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, save the input.
                  _formKey.currentState!.save();
                  // Now, you can use the validated input, which is stored in _inputText.
                } else {}
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const Verification()),
                // );
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.2),
                width: MediaQuery.of(context).size.width * 0.6,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: colors.primary, width: 2),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: colors.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
    );
  }
}