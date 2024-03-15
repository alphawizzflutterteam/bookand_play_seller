import 'dart:convert';
import 'dart:developer';

import 'package:bookplayapp/Helper/color.dart';
import 'package:bookplayapp/Services/api_services/apiConstants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import '../Model/tranjectionHistoryModel.dart';
import '../Model/walletHistoryModel.dart';
import '../Services/api_services/apiBasehelper.dart';
import '../Services/api_services/apiStrings.dart';
import '../Widget/custum_appbar.dart';

class Wallet_Screen extends StatefulWidget {
  const Wallet_Screen({Key? key}) : super(key: key);

  @override
  State<Wallet_Screen> createState() => _Wallet_ScreenState();
}

class _Wallet_ScreenState extends State<Wallet_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getwallet();
    getBalance();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            CustomAppBar(
                onPressedLeading: () {
                  Navigator.pop(context);
                },
                title: 'Wallet'),
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Column(children: [
                      const SizedBox(
                        height: 15,
                      ),
                      const Text("Available Balance",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w400)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("\u{20B9} ${walletbalanco ?? "0"}",
                          style: const TextStyle(
                              fontSize: 25, color: Colors.green)),
                      const SizedBox(
                        height: 10,
                      ),

                      /*const Text( "Commission  Deductions",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w400,),),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("\u{20B9} ${commitionDituction?? "0"}",
                          style: const TextStyle(fontSize: 25,color: Colors.red)),
                      const SizedBox(height: 10,),


                      const SizedBox(
                        height: 10,
                      ),*/

                      const Text(
                        "Withdraw Balance",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      amountcontroller.text.isEmpty
                          ? const Text("\u{20B9} 0",
                              style:
                                  TextStyle(fontSize: 25, color: Colors.green))
                          : Text("\u{20B9} ${amountcontroller.text.toString()}",
                              style: const TextStyle(
                                  fontSize: 25, color: Colors.green)),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {});
                            showAlertDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: colors.secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              )),
                          child: const Text(
                            "Withdraw Balance",
                            style: TextStyle(
                              //decoration: TextDecoration.underline,
                              color: colors.whiteTemp,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Row(
                        children: [
                          Text("Transaction", style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      !loading
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height / 3.5,
                              child: walletHistory?.data.isEmpty ?? true
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              4,
                                      child: const Center(
                                        child: Text('History Not Available'),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount:
                                          walletHistory?.data.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: Container(
                                            height: 80,
                                            child: Row(children: [
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: colors.secondary),
                                                  child: const Icon(
                                                    Icons
                                                        .monetization_on_rounded,
                                                    color: colors.whiteTemp,
                                                    size: 15,
                                                  )),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "${walletHistory?.data[index].id}",
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                      "${walletHistory?.data[index].createdAt}",
                                                      style: const TextStyle(
                                                          fontSize: 10)),
                                                ],
                                              ),
                                              const Spacer(),
                                              Text(
                                                  "RS ${walletHistory?.data[index].amount}",
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                  )),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            ]),
                                          ),
                                        );
                                      },
                                    ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ]),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TransactionHistory? walletHistory;
  bool loading = true;

  Future<void> getBalance() async {
    var userId;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('userId');

    var param = {
      'vendor_id': userId.toString(),
    };
    print('_______${param}');
    setState(() {
      loading = true;
    });

    apiBaseHelper.postAPICall(getWithdrawalHistoryApi, param).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      log('${getData}');
      setState(() {
        loading = false;
      });
      if (error) {
        //Fluttertoast.showToast(msg: msg);
        walletHistory = TransactionHistory.fromJson(getData);
        setState(() {});
      } else {}
    });
  }

  var walletbalanco;
  var commitionDituction;
  var widrawalamount;

  Future<void> getwallet() async {
    var userId;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('userId');

    var param = {
      'vendor_id': userId.toString(),
    };
    setState(() {
      loading = true;
    });

    apiBaseHelper.postAPICall(vendorwallet, param).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      setState(() {
        loading = false;
      });
      if (error) {
        setState(() {
          walletbalanco = getData['data']['wallet'];
          commitionDituction = getData['data']['commission_detuction'];
          amountcontroller.text =
              getData['data']['withdrawal_amount'].toString();
        });
      } else {}
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        content: Container(
      width: 200,
      height: MediaQuery.of(context).size.height / 1.4,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Send Withdraw Request",
                style: TextStyle(
                    color: colors.secondary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              /*const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Withdraw Amount",
                    style: TextStyle(
                        color: colors.secondary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "\u{20B9} ${widrawalamount ?? '0'}/-",
                    style: const TextStyle(
                        color: colors.secondary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),*/
              const Divider(
                thickness: 3,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Bank Details :",
                    style: TextStyle(
                        color: colors.secondary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Amount",
                    style: TextStyle(
                      color: colors.blackTemp,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              TextFormField(
                // readOnly: true,
                controller: amountcontroller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.currency_rupee,
                    color: colors.secondary,
                  ),
                  hintText: 'Enter Amount',
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
                    return 'Please enter Amount';
                  }
                  // else if (!value.contains('@')||!value.contains("gmail.com")) {
                  //   return 'Please enter valid Email';
                  // }
                  return null; // Return null if the input is valid
                },
              ),
              const SizedBox(
                height: 3,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Account Holder Name",
                    style: TextStyle(
                      color: colors.blackTemp,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: accountnamecontroller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    color: colors.secondary,
                  ),
                  hintText: 'Enter Account Holder Name',
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
                    return 'Please enter Account Holder Name';
                  }
                  // else if (!value.contains('@')||!value.contains("gmail.com")) {
                  //   return 'Please enter valid Email';
                  // }
                  return null; // Return null if the input is valid
                },
              ),
              const SizedBox(
                height: 3,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Account No",
                    style: TextStyle(
                      color: colors.blackTemp,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: accountnumbercontroller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.numbers,
                    color: colors.secondary,
                  ),
                  hintText: 'Enter Account No',
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
                    return 'Please enter Account No';
                  }
                  // else if (!value.contains('@')||!value.contains("gmail.com")) {
                  //   return 'Please enter valid Email';
                  // }
                  return null; // Return null if the input is valid
                },
              ),
              const SizedBox(
                height: 3,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "IFSC Code",
                    style: TextStyle(
                      color: colors.blackTemp,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              TextFormField(
                maxLength: 11,
                textCapitalization: TextCapitalization.characters,
                controller: ifsccontroller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.food_bank,
                    color: colors.secondary,
                  ),
                  counterText: "",
                  hintText: 'IFSC Code',
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
                    return 'Please enter IFSC Code';
                  }
                  // else if (!value.contains('@')||!value.contains("gmail.com")) {
                  //   return 'Please enter valid Email';
                  // }

                  else if (value.length < 11) {
                    return 'Please enter valid IFSC Code';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              const SizedBox(
                height: 3,
              ),
              const Divider(
                thickness: 3,
                color: Colors.black,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            40,
                          ),
                          color: colors.secondary),
                      child: const Center(
                          child: Text(
                        'Cancel',
                        style: TextStyle(color: colors.whiteTemp),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        sendwidrrawalrequest();
                      }
                    },
                    child: Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            40,
                          ),
                          color: colors.secondary),
                      child: const Center(
                          child: Text(
                        'Send',
                        style: TextStyle(color: colors.whiteTemp),
                      )),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    ));

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> sendwidrrawalrequest() async {
    var userId;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('userId');

    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseUrl}withdrawal_request'));
    // var request = http.MultipartRequest(
    //     'POST', Uri.parse('${baseUrl}walletRequest'));
    request.fields.addAll({
      'vendor_id': '${userId.toString()}',
      'amount': '${amountcontroller.text.toString()}',
      'ifsc_code': '${ifsccontroller.text.toString()}',
      'account_name': '${accountnamecontroller.text.toString()}',
      'account_number': '${accountnumbercontroller.text.toString()}',
    });

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

        accountnamecontroller.clear();
        accountnumbercontroller.clear();
        ifsccontroller.clear();
        amountcontroller.clear();
      } else {
        Fluttertoast.showToast(msg: msg);
        Navigator.pop(context);
        accountnamecontroller.clear();
        accountnumbercontroller.clear();
        ifsccontroller.clear();
        amountcontroller.clear();
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  TextEditingController amountcontroller = TextEditingController();
  TextEditingController ifsccontroller = TextEditingController();
  TextEditingController accountnamecontroller = TextEditingController();
  TextEditingController accountnumbercontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
}
