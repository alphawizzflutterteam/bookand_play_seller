import 'package:bookplayapp/Helper/appBar.dart';
import 'package:bookplayapp/Helper/color.dart';
import 'package:flutter/material.dart';
class paymentHistory extends StatefulWidget {
  const paymentHistory({Key? key}) : super(key: key);

  @override
  State<paymentHistory> createState() => _paymentHistoryState();
}

class _paymentHistoryState extends State<paymentHistory> {
  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //       child: Scaffold(
  //           backgroundColor: colors.appbarColor,
  //           appBar: PreferredSize(
  //               preferredSize: Size.fromHeight(80),
  //               child: commonAppBar(context,
  //                   text: "Payment History", isActionButton: false)),
  //           body: Container(
  //             padding: EdgeInsets.symmetric(horizontal: 20),
  //             child: ListView(physics: BouncingScrollPhysics(), children: [
  //               SizedBox(
  //                 height: 10,
  //               ),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.25),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [colors.primary, colors.secondary])),

              ),
              Container(
                margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.12),
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                ),
              ),
              Container(
                margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.13),
                height: MediaQuery.of(context).size.height * 0.89,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xffF6F6F6),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15), topRight: Radius.circular(15)
    ),
                ),
          child:Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: ListView(physics: BouncingScrollPhysics(), children: [
    SizedBox(
    height: 10,
    ),
    Container(
    child: Text(
    'Transaction',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    )),
    SizedBox(
    height: 10,
    ),
    ListView.separated(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: 5,
    itemBuilder: (context, index) {
    return listTileWidget(index: index);
    },
    separatorBuilder: (context, index) {
    return SizedBox(
    height: 10,
    );
    },
    )
    ]
    )
    )
    )
    ]
    ),
    );
  }
  Widget listTileWidget({required int index}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/images/paymnet history.png'),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Transaction Id",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  child: Text(
                    'Shivansh Shukla',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),

                SizedBox(
                  height: 2,
                ),

                Text(
                  '04 feb 2022',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "123xxxx",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  child: Text(
                    'Rs 620',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Text(
                  'Paid',
                  style: TextStyle(fontSize: 12, color: Colors.green),
                ),
                SizedBox(
                  height: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
