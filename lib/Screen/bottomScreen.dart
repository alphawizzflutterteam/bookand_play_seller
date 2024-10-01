import 'package:bookplayapp/Helper/appBar.dart';
import 'package:bookplayapp/Helper/color.dart';
import 'package:bookplayapp/Helper/common.dart';
import 'package:bookplayapp/Screen/backGround.dart';
import 'package:bookplayapp/Screen/bookingsPage.dart';

import 'package:bookplayapp/Screen/change_password_screen.dart';
import 'package:bookplayapp/Screen/faq_view.dart';

import 'package:bookplayapp/Screen/homePage.dart';
import 'package:bookplayapp/Screen/notificationScreen.dart';

import 'package:bookplayapp/Screen/paymentHistory_scr.dart';
import 'package:bookplayapp/Screen/privacy_view.dart';
import 'package:bookplayapp/Screen/profile_screen.dart';
import 'package:bookplayapp/Screen/support.dart';
import 'package:bookplayapp/Screen/terms_condition_view.dart';
import 'package:bookplayapp/Screen/wallet_screen.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AuthView/loginPage.dart';
import '../Model/login_response.dart';
import '../Services/api_services/apiBasehelper.dart';
import '../Services/api_services/apiStrings.dart';
var username;
var imagefiledummy='';

class BottomNavBar extends StatefulWidget {
  int? dIndex;
  BottomNavBar({super.key, this.dIndex});
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  User? userData = User();




  List<Map<String, dynamic>> drawerList = [
    {
      'titlee': 'Home',
      'image': 'assets/images/home.png',
      "image1":'assets/images/HOME-1.png',
    },
    {
      'titlee': 'Wallet',
      'image': 'assets/images/Wallet-1.png',
      "image1":'assets/images/Wallet.png',

    },
    {
      'titlee': 'Payment History',
      'image': 'assets/images/Payment history-1.png',
      "image1":'assets/images/Payment history.png',

    },
    {
      'titlee': 'Privacy & Policy',
      'image': 'assets/images/Privacy Policy-1.png',
      "image1":'assets/images/Privacy Policy.png',

    },
    {
      'titlee': 'Terms & Conditions',
      'image': 'assets/images/Terms & Conditions.png',
      "image1":'assets/images/Group 75178.png',

    },
    {
      'titlee': 'Faq',
      'image': 'assets/images/FAQ-1.png',
      "image1":'assets/images/FAQ.png',

    },
    {
      'titlee': 'Contact Us',
      'image': 'assets/images/contact us-1.png',
      "image1":'assets/images/contact us.png',

    },
    {
      'titlee': 'Change Password',
      'image': 'assets/images/Change Password-1.png',
      "image1":'assets/images/Change Password.png',

    },
    {
      'titlee': 'Logout',
      'image': 'assets/images/LOGOUT-1.png',
      "image1":'assets/images/LOGOUT.png',

    },
    {
      'titlee': 'Delete Account',
      'image': 'assets/images/LOGOUT-1.png',
      "image1":'assets/images/LOGOUT.png',

    },
  ];

  List screenList = const [
    SizedBox(),
    Wallet_Screen(),
    PaymentHistoryScr(),
    Privecy_Policy(),
    TermsCondation(),
    FaqScr(),
    SupportScr(),
    ChangePasswordScreen(),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget? _child;
  int selectedIndex = 0;
  int currentIndex = 99;
  var currentIndexx = 0;
  @override
  void initState() {

    if (widget.dIndex != null) {
      selectedIndex = widget.dIndex!;
      _child = widget.dIndex == 1
          ? MyBookingsScreen()
          : widget.dIndex == 3
              ? Container()
              : Container();
    } else {
      _child = HomePageWidget();
    }

    super.initState();
    getProfile();
  }

  getdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString("name");
      print(username);
    });



  }
var userId;

  Future <void> getProfile () async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userId = preferences.getString('userId');
    }
      );
    print('1');
    var param = {
      'user_id': userId.toString(),
    };
    print('2');

    apiBaseHelper.postAPICall(getProfileApi, param).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        print('3');

        print('${getData['data']['address']}');

        username = getData['data']['first_name'].toString();
        imagefiledummy=getData['data']['user_image'].toString();
        setState(() {

        });
        print('4');

      } else {
      }

    });
  }

  removesession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.remove('userId');
    await preferences.remove('mobile');
    await preferences.remove('gmail');
    await preferences.remove('address');
    await preferences.remove('name');
    await preferences.remove('isLogin');
    await preferences.remove('deviceToken');

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:





      WillPopScope(
        onWillPop: () async {
    showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
    return AlertDialog(
    title: Text("Confirm Exit"),
    content: Text("Are you sure you want to exit?"),
    actions: <Widget>[
    ElevatedButton(
    style: ElevatedButton.styleFrom(backgroundColor: colors.secondary),
    child: Text("YES"),
    onPressed: () {
    SystemNavigator.pop();
    },
    ),
    ElevatedButton(
    style: ElevatedButton.styleFrom(backgroundColor: colors.secondary),
    child: Text("NO"),
    onPressed: () {
    Navigator.of(context).pop();
    },
    )
    ],
    );
    });
    return true;
    },

        child: Scaffold(



            key: _scaffoldKey,
            backgroundColor:const Color(0xff96E7F7),
            drawer: Drawer(
              child: ListView(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                        colors.primary,
                        colors.secondary,
                      ])),
                  child: Row(children: [
                    const SizedBox(
                      width: 25,
                    ),
                  CircleAvatar(
                      backgroundColor: colors.whiteTemp,
                      radius: 40,
                      child: CircleAvatar(
                        radius: 37,
                        backgroundColor: colors.primary,
                        backgroundImage: NetworkImage("${imagefiledummy}"),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Hello!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: colors.whiteTemp),
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(

                            '${username??""}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: colors.whiteTemp),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: drawerList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          currentIndexx = index;
                        });
                        if (currentIndexx == 0) {
                          Navigator.pop(context);
                        } else if (currentIndexx == 1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => screenList[index],
                              ));
                        } else if (currentIndexx == 2) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => screenList[index],
                              ));
                        } else if (currentIndexx == 3) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => screenList[index],
                              ));
                        }

                        else if (currentIndexx == 4) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => screenList[index],
                              ));
                        }
                        else if (currentIndexx == 5) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => screenList[index],
                              ));
                        }
                        else if (currentIndexx == 6) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => screenList[index],
                              ));
                        }
                        else if (currentIndexx == 7) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => screenList[index],
                              ));
                        }
                        else if (currentIndexx == 8) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Confirm Sign Out"),
                                  content: Text("Are you sure to sign out?"),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: colors.primary),
                                      child: Text("YES"),
                                      onPressed: () async {
                                        setState(() {
                                          removesession();
                                        });
                                        Navigator.pop(context);
                                        // SystemNavigator.pop();
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => LoginPage(),
                                            ));
                                      },
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: colors.primary),
                                      child: Text("NO"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        }
                        else if (currentIndexx == 9) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Confirm Delete Account"),
                                  content: Text("Are you sure to Delete Account?"),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: colors.primary),
                                      child: Text("YES"),
                                      onPressed: () async {
                                        _deleteAccount();
                                      },
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: colors.primary),
                                      child: Text("NO"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: currentIndexx == index
                                  ? const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                          colors.primary,
                                          colors.secondary,
                                        ])
                                  : const LinearGradient(colors: [
                                      Colors.transparent,
                                      Colors.transparent
                                    ])),
                          child: Row(children: [
                            const SizedBox(
                              width: 25,
                            ),
                            Container(
                                width: 30,
                                height: 30,
                                // margin: EdgeInsets.all(10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: currentIndexx == index
                                        ? Colors.white
                                        : colors.secondary,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child:
                                  currentIndexx == index?
                                      Image.asset("${drawerList[index]["image"]}"):
                                      Image.asset("${drawerList[index]["image1"]}"),
                                )),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              '${drawerList[index]["titlee"]}',
                              style: TextStyle(
                                  color: currentIndexx == index
                                      ? colors.whiteTemp
                                      : Colors.black),
                            )
                          ]),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 5,
                )
              ]),
            ),
            appBar: selectedIndex == 2?null:AppBar(
              elevation: 0,
              toolbarHeight: 70,
              leading: Center(
                child: InkWell(
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: Container(
                    // margin: EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.menu,
                      color: colors.secondary,
                    ),
                  ),
                ),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: Common.commonGradient(),
                ),
              ),
              actions: [
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const notificationScr(),
                          ));
                    },
                    child: Container(
                      // margin: EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.notifications_active_rounded,
                        color: colors.secondary,
                      ),
                    ),
                  ),
                ),const SizedBox(width: 10,)
              ],
              title: Center(
                child: Text(
                  selectedIndex == 2
                      ? "Account"
                      : selectedIndex == 1
                          ? "Bookings"
                          : "Home",
                ),
              ),
            ),
            body: selectedIndex == 2?_child:Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    )),
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xfff3f3f3),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        )),
                    child: _child)),
            bottomNavigationBar: CurvedNavigationBar(
                color: colors.secondary,
                backgroundColor: colors.whiteTemp,
                items: const [
                  CurvedNavigationBarItem(
                      child: ImageIcon(AssetImage('assets/images/home.png'),
                          color: colors.whiteTemp),
                      label: 'Home',
                      labelStyle: TextStyle(color: colors.whiteTemp)),
                  CurvedNavigationBarItem(
                      child: ImageIcon(AssetImage('assets/images/calender.png'),
                          color: colors.whiteTemp),
                      label: 'Bookings',
                      labelStyle: TextStyle(color: colors.whiteTemp)),
                  CurvedNavigationBarItem(
                      child: ImageIcon(AssetImage('assets/images/profile.png'),
                          color: colors.whiteTemp),
                      label: 'Account',
                      labelStyle: TextStyle(color: colors.whiteTemp)),
                ],
                onTap: _handleNavigationChange),
          ),
      ),

    );
  }

  String? msg;
  User usedata = User();
  Future<void> _deleteAccount() async{
    // var obj = await SharedPre.getObjs(SharedPre.userData);
    // usedata = User.fromJson(obj);
    // var param = {
    //   'user_id': usedata.id.toString(),
    // };
    print("DeleteAccount----------->");
    // print("DeleteAccount----------->$param");
    // apiBaseHelper.postAPICall(DeleteAccount, param).then((getData) {
    //   print("--ffffffffffffff--------->${getData}");
    //   bool error = getData['status'];
    //   msg = getData['message'];
    //   if (error) {
    //     Fluttertoast.showToast(msg: msg.toString());
    //     setState(() {
    //       removesession();
    //     });
    //     Navigator.pop(context);
    //     // SystemNavigator.pop();
    //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    //   } else {
    //     Fluttertoast.showToast(msg: msg.toString());
    //   }
    // });
  }

  void _handleNavigationChange(int index) {
    setState(() {
      setState(() {
        selectedIndex = index;
        print("=selectindex===============${selectedIndex}");
      });
      switch (index) {
        case 0:
          _child = HomePageWidget();
          break;
        case 1:
          _child = MyBookingsScreen();
          break;
        case 2:
          _child = ProfileScreen();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.bounceOut,
        switchOutCurve: Curves.bounceIn,
        duration: Duration(milliseconds: 100),
        child: _child,
      );
    });
  }
}

class DrawerIconTab extends StatefulWidget {
  final IconData? icon;
  final String? titlee;
  final int? tabb;
  final int? indexx;

  DrawerIconTab({Key? key, this.icon, this.titlee, this.tabb, this.indexx})
      : super(key: key);

  @override
  State<DrawerIconTab> createState() => _DrawerIconTabState();
}

class _DrawerIconTabState extends State<DrawerIconTab> {
  var Select = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          gradient: widget.indexx == widget.tabb
              ? LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [colors.secondary, colors.white10])
              : null),
      // color:
      //     widget.indexx == widget.tabb ? colors.secondary : Colors.transparent,
      child: Row(
        children: [
          SizedBox(
            width: 13,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3), shape: BoxShape.circle),
            height: 40,
            width: 40,
            child: Center(
                child: Icon(
              widget.icon,
              color: widget.indexx == widget.tabb ? Colors.amber : Colors.grey,
              size: 20,
            )),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            '${widget.titlee}',
            style: TextStyle(
                fontSize: 15,
                fontWeight: widget.indexx == widget.tabb
                    ? FontWeight.bold
                    : FontWeight.normal,
                color:
                    widget.indexx == widget.tabb ? Colors.black : Colors.grey),
          ),
        ],
      ),
    );
  }
}
