import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AuthView/custonpageofapp.dart';
import '../Helper/btn.dart';
import '../Helper/color.dart';
import '../Model/login_response.dart';
import '../Services/api_services/apiBasehelper.dart';
import '../Services/api_services/apiStrings.dart';
import 'bottomScreen.dart';

class Otpverify extends StatefulWidget {
  String? otp;
  String? mobile;

  Otpverify({Key? key, this.otp, this.mobile}) : super(key: key);

  @override
  State<Otpverify> createState() => _OtpverifyState();
}

class _OtpverifyState extends State<Otpverify> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      otp = widget.otp.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              customAuthDegineforForget(context, 'Verification'),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 2.7),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30), // Top-left corner radius
                      topRight: Radius.circular(30), // Top-right corner radius
                      // Bottom-right corner with no rounding
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        textView('Code has been sent to'),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "+91 ${widget.mobile.toString()}",
                          style: const TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'OTP: ${otp.toString()}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 30,
                        ),


                        PinCodeTextField(
                          //errorBorderColor:Color(0xFF5ACBEF),
                          //defaultBorderColor: Color(0xFF5ACBEF),
                          keyboardType: TextInputType.phone,

                          onChanged: (value) {
                            textotp = value.toString();
                          },

                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(15),
                            activeColor: colors.blackTemp,
                            inactiveColor: colors.verifieFieldColor,
                            fieldHeight: 60,
                            fieldWidth: 60,
                            activeFillColor: Colors.white,
                          ),
                          //pinBoxRadius:20,
                          appContext: context,
                          length: 4,
                        ),
                        textView("Haven't received the verification code?"),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                            onTap: () {
                              sendOtp();
                            },
                            child: const Text(
                              'Resend',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 10,
                        ),
                        InkWell(
                          onTap: () {
                            if (textotp == otp) {
                              verifyOTP();
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Please Fill Correct OTP');
                            }
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.12),
                              child: FilledBtn(
                                title: 'Verify',
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }

  var otp;
  var textotp;
  bool isLoading = false;

  Future<void> sendOtp() async {
    isLoading = true;

    var param = {
      'contact': widget.mobile.toString(),
    };
    apiBaseHelper.postAPICall(sendOTPAPI, param).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        Fluttertoast.showToast(msg: msg);

        setState(() {
          otp = getData['otp'].toString();
        });
        // Get.toNamed(otpScreen, arguments: [mobile, getData['otp']]);
      } else {}
      isLoading = false;
    });
  }

  Future<void> verifyOTP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var devvicekey = preferences.getString('deviceToken');
    setState(() {
      isLoading = true;
    });

    var param = {
      'contact': widget.mobile.toString(),
      'otp': otp.toString(),
      'device_key': "${devvicekey.toString()}"
    };
    apiBaseHelper.postAPICall(verifyOTPAPI, param).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        User? userData = User();

        userData = User.fromJson(getData['user']);

        preferences.setString('userData', userData.toJson().toString());
        preferences.setBool('isLogin', true);
        preferences.setString('userId', getData['user']['id'].toString());
        preferences.setString('name', getData['user']['name'].toString());
        preferences.setString('mobile', getData['user']['mobile'].toString());
        preferences.setString('gmail', getData['user']['email'].toString());
        preferences.setString('address', getData['user']['address'].toString());
        Fluttertoast.showToast(msg: msg);



        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => BottomNavBar()),
                (Route<dynamic> route) => false);
      } else {
        Fluttertoast.showToast(msg: msg);
      }
      isLoading = false;
    });
  }
}

class SharedPre {}
