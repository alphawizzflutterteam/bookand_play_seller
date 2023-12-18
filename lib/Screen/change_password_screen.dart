import 'package:bookplayapp/Helper/common.dart';
import 'package:bookplayapp/Services/api_services/apiBasehelper.dart';
import 'package:bookplayapp/Services/api_services/apiConstants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Helper/color.dart';
import '../Widget/custum_appbar.dart';
import 'bottomScreen.dart';

// class ChangePasswordScreen extends StatefulWidget {
//   const ChangePasswordScreen({super.key});
//
//   @override
//   State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
// }
//
// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   TextEditingController oldPassCon = TextEditingController();
//   TextEditingController passCCon = TextEditingController();
//   TextEditingController passCon = TextEditingController();
//   bool loading = false;
//   bool network = false;
//   FocusNode passNode = FocusNode();
//   ApiBaseHelper apiBaseHelper = ApiBaseHelper();
//   String deviceDetails = "";
//   changePassword(type) async {
//     await App.init();
//     network = true;
//
//     if (network) {
//       Map param = {
//         "user_id": App.localStorage.getString("userId"),
//         "old_password": oldPassCon.text,
//         "new_password": passCon.text,
//       };
//
// //8827519680
//       //${loginUrl}badge/login.php
//       /* var response1 = await http
//           .post(Uri.parse("https://deraindore.in/api/Api/login"), body: param);
//       Map response = jsonDecode(response1.body);*/
//       var response = await apiBaseHelper.postAPICall(
//         Uri.parse("${baseUrl}change_password"),
//         param,
//       );
//       setState(() {
//         loading = false;
//       });
//       if (response['status']) {
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>BottomNavBar() ,))  ;
//        Fluttertoast.showToast(msg: response['message']);
//       } else {}
//     } else {
//       setState(() {
//         loading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return
//
//     SafeArea(
//       child: Scaffold(
//         appBar:
//
//         AppBar(
//           elevation: 0,
//           toolbarHeight: 70,
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(Icons.keyboard_arrow_left),
//           ),
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: Common.commonGradient(),
//             ),
//           ),
//           title: const Text(
//             "Change Password",
//           ),
//         ),
//         backgroundColor: const Color(0xff96E7F7),
//         body: Container(
//           width: double.infinity,
//           decoration: const BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(50),
//                 topRight: Radius.circular(50),
//               )),
//           padding: const EdgeInsets.only(top: 10),
//           child: Container(
//             decoration: const BoxDecoration(
//                 color: Color(0xfff3f3f3),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(50),
//                   topRight: Radius.circular(50),
//                 )),
//             padding: const EdgeInsets.all(20),
//             child:
//
//             SingleChildScrollView(
//               child:
//
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Text(
//                     "Old Password",
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   TextFormField(
//                     controller: oldPassCon,
//                     obscureText: true,
//                     keyboardType: TextInputType.visiblePassword,
//                     autofocus: true,
//                     textInputAction: TextInputAction.next,
//                     decoration: const InputDecoration(
//                       hintText: "Enter Old Password",
//                       fillColor: Colors.white,
//                       filled: true,
//                       enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white)),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white)),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     "New Password",
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   TextFormField(
//                     controller: passCon,
//                     obscureText: true,
//                     keyboardType: TextInputType.visiblePassword,
//                     autofocus: true,
//                     textInputAction: TextInputAction.next,
//                     decoration: const InputDecoration(
//                       hintText: "Enter New Password",
//                       fillColor: Colors.white,
//                       filled: true,
//                       enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white)),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white)),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     "Confirm Password",
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   TextFormField(
//                     controller: passCCon,
//                     obscureText: true,
//                     keyboardType: TextInputType.visiblePassword,
//                     autofocus: true,
//                     textInputAction: TextInputAction.next,
//                     decoration: const InputDecoration(
//                       hintText: "Enter Confirm Password",
//                       fillColor: Colors.white,
//                       filled: true,
//                       enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white)),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white)),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   Center(
//                     child: Common.commonButton(
//                       loading: loading,
//                       width: MediaQuery.of(context).size.width * 0.6,
//                       onPressed: () {
//                         if (oldPassCon.text == "") {
//                           Fluttertoast.showToast(
//                             msg: "Please Enter Old Password",
//                           );
//                           return;
//                         }
//
//
//                         if (passCon.text == "") {
//                           Fluttertoast.showToast(
//                             msg: "Please Enter new Password",
//                           );
//                           return;
//                         }
//                         if(passCCon.text==""){
//                             Fluttertoast.showToast(msg: "Please Enter Confirem Password")  ;
//                               return ;
//                         }
//
//                         if (passCon.text != passCCon.text) {
//                           Fluttertoast.showToast(
//                             msg: "Both password doesn't match",
//                           );
//                           return;
//                         }
//                         setState(() {
//                           loading = true;
//                         });
//                         changePassword("");
//                       },
//                       title: "Update",
//                       context: context,
//                     ),
//                   ),
//                 ],
//               ),
//
//
//             ),
//
//
//           ),
//         ),
//       ),
//     );
//
//
//   }
// }

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  TextEditingController oldPassCon = TextEditingController();
  TextEditingController passCCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  bool loading = false;
  bool network = false;
  FocusNode passNode = FocusNode();
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  String deviceDetails = "";
  changePassword(type) async {
    await App.init();
    network = true;

    if (network) {
      Map param = {
        "user_id": App.localStorage.getString("userId"),
        "old_password": oldPassCon.text,
        "new_password": passCon.text,
      };

//8827519680
      //${loginUrl}badge/login.php
      /* var response1 = await http
          .post(Uri.parse("https://deraindore.in/api/Api/login"), body: param);
      Map response = jsonDecode(response1.body);*/
      var response = await apiBaseHelper.postAPICall(
        Uri.parse("${baseUrl}change_password"),
        param,
      );
      setState(() {
        loading = false;
      });
      if (response['status']) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>BottomNavBar() ,))  ;
        Fluttertoast.showToast(msg: response['message']);
      } else {}
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Scaffold(
          body:

          Stack(children: [
            CustomAppBar(
                onPressedLeading: () {
                  Navigator.pop(context);
                },
                title: 'Change Password'),
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
                child:

                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25,right: 25),
                    child:

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Old Password",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Card(
                          child: TextFormField(
                            controller: oldPassCon,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              hintText: "Enter Old Password",
                            
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "New Password",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Card(
                          child: TextFormField(
                            controller: passCon,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              hintText: "Enter New Password",
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Confirm Password",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Card(
                          child: TextFormField(
                            controller: passCCon,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              hintText: "Enter Confirm Password",
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Common.commonButton(
                            loading: loading,
                            width: MediaQuery.of(context).size.width * 0.6,
                            onPressed: () {
                              if (oldPassCon.text == "") {
                                Fluttertoast.showToast(
                                  msg: "Please Enter Old Password",
                                );
                                return;
                              }


                              if (passCon.text == "") {
                                Fluttertoast.showToast(
                                  msg: "Please Enter new Password",
                                );
                                return;
                              }
                              if(passCCon.text==""){
                                Fluttertoast.showToast(msg: "Please Enter Confirem Password")  ;
                                return ;
                              }

                              if (passCon.text != passCCon.text) {
                                Fluttertoast.showToast(
                                  msg: "Both password doesn't match",
                                );
                                return;
                              }
                              setState(() {
                                loading = true;
                              });
                              changePassword("");
                            },
                            title: "Update",
                            context: context,
                          ),
                        ),
                      ],
                    ),




                  ),
                ),



              ),
            )
          ],),

        ),
      );

  }


}
