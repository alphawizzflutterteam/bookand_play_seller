import 'package:bookplayapp/AuthView/forgotPassword.dart';
import 'package:bookplayapp/AuthView/loginPage.dart';
import 'package:bookplayapp/Helper/btn.dart';
import 'package:bookplayapp/Helper/color.dart';
import 'package:bookplayapp/Screen/bottomScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../AuthView/custonpageofapp.dart';
import '../Model/login_response.dart';
import '../Services/api_services/apiBasehelper.dart';
import '../Services/api_services/apiStrings.dart';

class SignUp_Scr extends StatefulWidget {
  const SignUp_Scr({super.key});

  @override
  State<SignUp_Scr> createState() => _SignUp_ScrState();
}

class _SignUp_ScrState extends State<SignUp_Scr> {
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            customAuthDegine(context, "Sign Up"),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.33),
              height: MediaQuery.of(context).size.height * 0.69,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Color(0xffF6F6F6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.person,
                        color: colors.secondary,
                      ),
                      hintText: 'Name',
                      contentPadding: const EdgeInsets.symmetric(vertical: 5),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                              color: colors.black12, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                              color: colors.black12, width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                              color: colors.black12, width: 2)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Name';
                      }
                      return null; // Return null if the input is valid
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailC,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.email,
                        color: colors.secondary,
                      ),
                      hintText: 'Email Id',
                      contentPadding: const EdgeInsets.symmetric(vertical: 5),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                              color: colors.black12, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                              color: colors.black12, width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                              color: colors.black12, width: 2)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Email Id';
                      } else if (!value.contains('@') ||
                          !value.contains("gmail.com")) {
                        return 'Please enter valid Email Id';
                      }
                      return null; // Return null if the input is valid
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    controller: mobilecontroller,
                    decoration: InputDecoration(

                      prefixIcon: const Icon(
                        Icons.call,
                        color: colors.secondary,
                      ),
                      hintText: 'Mobile Number',

                      counterText: "",
                      contentPadding: const EdgeInsets.symmetric(vertical: 5),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                              color: colors.black12, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                              color: colors.black12, width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                              color: colors.black12, width: 2)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Mobile Number';
                      } else if (value.length < 10) {
                        return 'Please enter valid Mobile Number';
                      }
                      return null; // Return null if the input is valid
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: _obscureText,
                    controller: passwordC,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: colors.secondary,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: colors.secondary,
                      ),
                      hintText: 'Password',
                      contentPadding: const EdgeInsets.symmetric(vertical: 5),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                              color: colors.black12, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                              color: colors.black12, width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                              color: colors.black12, width: 2)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      }
                      return null; // Return null if the input is valid
                    },
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              registerUser();
                            }
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.12),
                              child: FilledBtn(
                                title: 'Sign Up',
                              )),
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: colors.blackTemp),
                        ),

                        Text(
                          " Log In",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: colors.btn,
                          ),
                        ),

                        // TextButton(
                        //     onPressed: () {
                        //       // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen,));
                        //     },
                        //     child: const Text(
                        //       'Sign Up',
                        //       style: TextStyle(
                        //           color: colors.secondary,
                        //           fontSize: 15),
                        //     ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  bool _obscureText = true;

  Future<void> registerUser() async {
    isLoading = true;

    var param = {
      'email': emailC.text.toString(),
      'name': nameController.text,
      'mobile': mobilecontroller.text.toString(),
      'password': passwordC.text.toString(),
      'role_id': "6"
    };
    apiBaseHelper.postAPICall(getUserRegister, param).then((getData) {
      bool status = getData['status'];
      String msg = getData['message'];

      if (status) {
        Fluttertoast.showToast(msg: msg);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false);
        setState(() {
          isLoading = false;

        });
      } else {
        Fluttertoast.showToast(msg: msg);
        setState(() {
          isLoading = false;

        });
      }
    });
  }
}
