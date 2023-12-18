import 'package:bookplayapp/Helper/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screen/notificationScreen.dart';


class getAppbar extends StatelessWidget {
  final VoidCallback? onTaped;
  final SizedBox? sizedBox;
  String? text;
  bool? istrue;

  getAppbar({this.onTaped, this.text, this.sizedBox, this.istrue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 10,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
                colors: [
                  colors.primary,
                  colors.primary,
                ],
                stops: [
                  0,
                  1,
                ]),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: istrue ?? false
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colors.whiteTemp.withOpacity(0.4)),
                      child: Icon(
                        Icons.arrow_back,
                        color: colors.whiteTemp,
                      ),
                    ),
                  )
                      : SizedBox()),

              Text(
                '${text}',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),

              // Icon(Icons.chat_rounded,color: Colors.white,),

              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colors.whiteTemp.withOpacity(0.4)),
                    child: Icon(
                      Icons.notifications_none,
                      color: colors.whiteTemp,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Padding(
          //     padding: const EdgeInsets.only(left: 0, right: 0),
          //     child: AppBar(
          //         flexibleSpace: Container(
          //             decoration: BoxDecoration(
          //             gradient: LinearGradient(
          //               begin: Alignment.bottomLeft,
          //               end: Alignment.bottomRight,
          //               colors: [
          //                 CustomColors.grade1,
          //                 CustomColors.grade,
          //               ],
          //
          //             ),
          //           ),
          //         ),
          //       centerTitle: true,
          //         leading: Icon(
          //           Icons.add,color:CustomColors.grade1,
          //         ),
          //         title: Text(
          //           '${text}',
          //           style: TextStyle(color: Colors.white, fontSize: 20),
          //         ),
          //         actions: [
          //           InkWell(
          //             onTap: () {
          //               Navigator.pop(context);
          //             },
          //             child: Padding(
          //               padding: const EdgeInsets.all(8),
          //               child: Container(
          //                 height: 45,
          //                 width: 45,
          //                 decoration: BoxDecoration(
          //                     borderRadius: BorderRadius.circular(10),
          //                     color:
          //                         CustomColors.AppbarColor1.withOpacity(0.4)),
          //                 child: Icon(
          //                   Icons.notifications_none,
          //                   color: CustomColors.AppbarColor1,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ])
          //
          //
          //     ),
        ),
      ],
    );
  }
}

Widget customAppBar(
    {required BuildContext context,
      VoidCallback? onTaped,
      required String text,
      required bool isTrue,
      bool? isActionIcon}) {
  return Container(
    padding: EdgeInsets.only(top: 10),
    color: colors.appbarColor,
    child: AppBar(
      elevation: 0,
      backgroundColor: colors.appbarColor,
      centerTitle: true,
      // flexibleSpace: Container(
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.only(bottomRight: Radius.circular(1),bottomLeft: Radius.circular(1)),
      //     gradient: LinearGradient(
      //         begin: Alignment.bottomLeft,
      //         end: Alignment.bottomRight,
      //         colors: [
      //         colors.appbarColor
      //         ],
      //         stops: [
      //           0,
      //           1,
      //         ]),
      //   ),
      // ),
      leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: isTrue
              ? Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: colors.primary,
            ),
          )
              : SizedBox()),
      title: Text(
        '${text}',
        style: TextStyle(color: colors.primary, fontSize: 20),
      ),
      actions: isActionIcon == true
          ? [
        Icon(CupertinoIcons.heart, color: colors.primary),
        SizedBox(
          width: 10,
        ),
        Icon(
          Icons.shopping_cart_outlined,
          color: colors.primary,
        ),
        SizedBox(
          width: 10,
        )
        // InkWell(
        //   onTap: (){
        //     Navigator.pop(context);
        //   },
        //   child: Padding(
        //     padding: const EdgeInsets.all(8),
        //     child: InkWell(
        //         onTap: (){
        //          // Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
        //         },
        //         child: Icon(Icons.search,color: colors.whiteTemp,)),
        //   ),
        // ),
      ]
          : [],
    ),
  );
}

Widget homeAppBar(BuildContext context,
    {required String text, required VoidCallback ontap}) {
  return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 10),
      //padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.transparent,
          // gradient: LinearGradient(
          //     begin: Alignment.centerLeft,
          //     end: Alignment.centerRight,
          //     colors: [colors.primary, colors.secondary]),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: ontap,
            child: Container(
              // margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.menu,
                color: colors.secondary,
              ),
            ),
          ),
          Container(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),


          InkWell(
            onTap: () {

              Navigator.push(context, MaterialPageRoute(builder: (context) => notificationScr(),));
            },
            child: Container(
              // margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.notifications_active_rounded,
                color: colors.secondary,
              ),
            ),
          ),

        ],
      ));
}

Widget commonAppBar(BuildContext context,
    {required String text, bool? isActionButton}) {
  return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 10),
      //padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
                 Navigator.pop(context);
            },
            child: Container(
              // margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.arrow_back,
                color: colors.secondary,
              ),
            ),
          ),
          Container(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          isActionButton == false
              ? Container(
            width: 40,
          )
              :

          InkWell(
            onTap: () {

              Navigator.push(context, MaterialPageRoute(builder: (context) => notificationScr(),));
            },
            child: Container(
              // margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.notifications_active_rounded,
                color: colors.secondary,
              ),
            ),
          ),
        ],
      ));
}

// class CustomAppbar extends StatefulWidget {
//   const CustomAppbar({super.key});

//   @override
//   State<CustomAppbar> createState() => _CustomAppbarState();
// }

// class _CustomAppbarState extends State<CustomAppbar> {
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }