import 'package:bookplayapp/Helper/appBar.dart';
import 'package:bookplayapp/Screen/backGround.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../helper/color.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

List<String> listDetails = [
  "Vikas agrawal",
  "Bob John",
  "Niraj Vyas",
  "Lalit Pandit",
  "Babu sharma",
  "Tom gill",
  "Lalit Pandit",
];

class _NotificationPageState extends State<NotificationPage> {
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
                  preferredSize: Size.fromHeight(80),
                  child: commonAppBar(context, text: "bookings Details")),
              body: bodyWidget()),
        ],
      ),
    );
  }
  Widget bodyWidget() {
    return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ListView(physics: BouncingScrollPhysics(), children: [
              SizedBox(
                height: 10,
              ),
              Container(
                alignment:Alignment.centerLeft,child:Text('Today')),
              SizedBox(
                height: 10,
              ),
              Container(
                  alignment: Alignment.centerRight, child: Text('Clear All')),
              SizedBox(
                height: 10,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: listDetails.length,
                itemBuilder: (context, index) {
                  return listTileWidget(index: index);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
            ]
    ),
    );
  }

  Widget listTileWidget({required int index}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 5),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/images/notification image.png'),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  listDetails[index],
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'Just Now',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}