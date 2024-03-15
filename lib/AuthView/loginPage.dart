
import 'package:bookplayapp/AuthView/forgotPassword.dart';
import 'package:bookplayapp/Helper/btn.dart';
import 'package:bookplayapp/Helper/color.dart';
import 'package:bookplayapp/Screen/bottomScreen.dart';
import 'package:bookplayapp/Screen/signup%20Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/login_response.dart';
import '../Screen/otpverifyScreen.dart';
import '../Services/api_services/apiBasehelper.dart';
import '../Services/api_services/apiStrings.dart';
import 'custonpageofapp.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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

            //     Container(
            //       height: MediaQuery.of(context).size.height * 0.4,
            //       width: MediaQuery.of(context).size.width,
            //       padding: EdgeInsets.symmetric(
            //           horizontal: MediaQuery.of(context).size.width * 0.25),
            //       decoration: const BoxDecoration(
            //           gradient: LinearGradient(
            //               begin: Alignment.topCenter,
            //               end: Alignment.bottomCenter,
            //               colors: [colors.primary, colors.secondary])),
            //       child: const Image(image: AssetImage("assets/images/login.png")
            //       ),
            //     ),
            //
            //
            //
            //
            //
            // Container(
            //   margin:
            //   EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),
            //   height: MediaQuery.of(context).size.height * 0.7,
            //   width: MediaQuery.of(context).size.width,
            //   decoration: const BoxDecoration(
            //     color: Colors.black,
            //     borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            //   ),
            // ),

            customAuthDegine(context,"Login"),
            Container(
              margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.33),
              height: MediaQuery.of(context).size.height * 0.69,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Color(0xffF6F6F6),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30), topRight: Radius.circular(30),),
              ),
              child:



              ListView(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'Email',
                        groupValue: login,
                        onChanged: (value) {
                      updateLoginType(value ?? '');
                        },
                        activeColor: colors.secondary,
                      ),
                      const Text(


                        "Email",
                        style: TextStyle(
                            color: colors.blackTemp, fontSize: 15),

                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Radio(
                        value: 'Mobile no.',
                        groupValue: login,
                        onChanged: (value) {
                          updateLoginType(value??'');
                        },
                        activeColor: colors.secondary,
                      ),
                      const Text(
                        'Mobile No',
                        style: TextStyle(
                            color: colors.blackTemp, fontSize: 15),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),

num==0?
Column(children: [


                  TextFormField(
                    controller: emailC,
                    decoration: InputDecoration(

                      prefixIcon: const Icon(
                        Icons.email,
                        color: colors.secondary,
                      ),
                      hintText: 'Email',
                      contentPadding: const EdgeInsets.symmetric(vertical: 5),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide:
                          const BorderSide(color: colors.black12, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide:
                          const BorderSide(color: colors.black12, width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide:
                          const BorderSide(color: colors.black12, width: 2)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Email';
                      }
                      else if (!value.contains('@')||!value.contains("gmail.com")) {
                        return 'Please enter valid Email';
                      }
                      return null; // Return null if the input is valid
                    },
                  ),


                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: _obscureText,
                    controller: passwordC,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off,color: colors.secondary,),
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
                          borderSide:
                          const BorderSide(color: colors.black12, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide:
                          const BorderSide(color: colors.black12, width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide:
                          const BorderSide(color: colors.black12, width: 2)),
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
                    height: 5,
                  ),
                  InkWell(

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const forgotPassword()),
                      );
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      child:

                      const Text(
                        'Forgot Password ?',
                        style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold, color: colors.secondary),
                      ),



                    ),
                  ),



],):

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
        borderSide:
        const BorderSide(color: colors.black12, width: 2)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide:
        const BorderSide(color: colors.black12, width: 2)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide:
        const BorderSide(color: colors.black12, width: 2)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
    ),
  ),
  validator: (value) {
    if (value!.isEmpty) {
      return 'Please enter Mobile Number';
    }
    else if (value.length<10) {
      return 'Please enter valid Mobile Number';
    }
    return null; // Return null if the input is valid
  },
),



                  const SizedBox(
                    height: 70,
                  ),
                  isLoading ? const Center(child: CircularProgressIndicator(),) :InkWell(

                    onTap: () {
                     if(_formKey.currentState!.validate()){
if(num==0){
  loginUser();
}else{

  sendOtp();
}

                     }
                    },
                    child:

                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.12),
                      child:

                      num==0?
                      FilledBtn(
                        title: 'Login',
                      ):
                      FilledBtn(
                        title: 'Send OTP',
                      )

                    ),
                  ),



                  SizedBox(height: MediaQuery.of(context).size.height/10,),


                  InkWell(

                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp_Scr(),));


                    },
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: colors.blackTemp),
                        ),

                        Text(
                          " Sign Up",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: colors.btn),
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
                  SizedBox(height: 20,),

                ],
              ),



            )
          ],
        ),
      ),
    );
  }


  TextEditingController mobilecontroller =TextEditingController();
  bool isLoading = false ;

  bool _obscureText = true;
  Future<void> loginUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var  devvicekey = preferences.getString('deviceToken');

    setState(() {
      isLoading = true;
    });

    var param = {
      'email': emailC.text,
      'password': passwordC.text,
      'device_key': '${devvicekey.toString()}',
    };

    apiBaseHelper.postAPICall(getUserLogin, param).then((getData) async {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        Fluttertoast.showToast(msg: msg);

        User? userData = User();

        userData = User.fromJson(getData['user']);

        preferences.setString('userData', userData.toJson().toString());
        preferences.setBool('isLogin', true);
        preferences.setString('userId', getData['user']['id'].toString());
        preferences.setString('name', getData['user']['name'].toString());
        preferences.setString('mobile', getData['user']['mobile'].toString());
        preferences.setString('gmail', getData['user']['email'].toString());
        preferences.setString('address', getData['user']['address'].toString());

        // preferences.setString('userData', jsonEncode(getData['user']));


        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => BottomNavBar()),
                (Route<dynamic> route) => false);
        //String user = await SharedPre.getStringValue('userData');

        //var data = jsonDecode(user);
      } else {
        Fluttertoast.showToast(msg: msg);
      }
        });


    setState(() {
      isLoading = false;
    });
  }

  String login = 'Email';

  void updateLoginType(String value) {
    if (value == 'Email') {
      num = 0;
    } else {
      num = 1;
    }
    login = value;

    setState(() {

    });
  }

  int num = 0;



  Future<void> sendOtp() async {
    isLoading = true;

    var param = {
      'contact': mobilecontroller.text,
    };
    apiBaseHelper.postAPICall(sendOTPAPI, param).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        Fluttertoast.showToast(msg: msg);
Navigator.push(context, MaterialPageRoute(builder: (context) => Otpverify(otp:getData['otp'].toString(),mobile: mobilecontroller.text.toString(), ),));
        // Get.toNamed(otpScreen, arguments: [mobile, getData['otp']]);
      } else {
        Fluttertoast.showToast(msg: msg);
      }
      isLoading = false;
    });
  }
}