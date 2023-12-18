import 'package:bookplayapp/AuthView/loginPage.dart';
import 'package:bookplayapp/Helper/btn.dart';
import 'package:bookplayapp/Helper/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Services/api_services/apiBasehelper.dart';
import '../Services/api_services/apiStrings.dart';
import 'custonpageofapp.dart';


class forgotPassword extends StatefulWidget {
  const forgotPassword({super.key});

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {

  final emailC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          customAuthDegineforForget(context,"Forgot Password ?"),
          // Container(
          //   height: MediaQuery.of(context).size.height * 0.4,
          //   width: MediaQuery.of(context).size.width,
          //   padding: EdgeInsets.symmetric(
          //       horizontal: MediaQuery.of(context).size.width * 0.25),
          //   decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //           begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter,
          //           colors: [colors.primary, colors.secondary])),
          //   child: Image(image: AssetImage("assets/images/login.png")),
          // ),
          // Container(
          //   margin:
          //   EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
          //   height: MediaQuery.of(context).size.height * 0.7,
          //   width: MediaQuery.of(context).size.width,
          //   decoration: BoxDecoration(
          //     color: Colors.black,
          //     borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          //   ),
          // ),


          Container(
            margin:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.33),
            height: MediaQuery.of(context).size.height * 0.69,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Color(0xffF6F6F6),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: ListView(
              children: [
                SizedBox(
                  height: 10,
                ),

Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
        Text('Enter Email associated'),
  ],
),
Row(
  mainAxisAlignment: MainAxisAlignment.center,

  children: [
        Text('with your account'),
  ],
),

                SizedBox(
                  height: 30,
                ),


                Form(
                  key: _formKey,
                  child: TextFormField(
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
                ),



                SizedBox(
                  height: 40,
                ),
                InkWell(

                  onTap: () {

if(_formKey.currentState!.validate()){
  forgotEmail(email:emailC.text );

}




                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.12),
                    child: FilledBtn(
                      title: 'Submit',
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
 bool isLoading = false;


  Future<void> forgotEmail(
      {required String email}) async {
    isLoading = true ;

    var param = {
      'email': email,
    };
    apiBaseHelper.postAPICall(forgotAPI, param).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];
      if (error) {
        Fluttertoast.showToast(msg: msg);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
      } else {

        Fluttertoast.showToast(msg: msg);

      }
      isLoading = false ;
    });
  }
}