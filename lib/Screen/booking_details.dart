import 'package:bookplayapp/Helper/appBar.dart';
import 'package:bookplayapp/Helper/color.dart';
import 'package:bookplayapp/Screen/backGround.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({super.key});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {


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

  List list = [1, 2, 3];

  Widget bodyWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(top: 35),
      decoration: const BoxDecoration(
        color: colors.white10,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          // Top-left corner radius
          topRight: Radius.circular(30),
          // Bottom-right corner with no rounding
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          CarouselSlider(
              items: list
                  .map(
                    (item) => ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                "assets/images/Group 75120.png",
                              ),
                              fit: BoxFit.fill)),
                    )),
              )
                  .toList(),
              carouselController: controller,
              options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlay: true,
                  aspectRatio: 1.8,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      selected = index;
                    });
                  })),
          SizedBox(
            height: 10,
          ),
          sliderPointers(list, selected),
          SizedBox(
            height: 10,
          ),
          Text(
            'Booking id - 01',
            style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          detailWidget()
        ],
      ),
    );
  }

  Widget detailWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: SingleChildScrollView(
        child: Column(
          children: [
            helper(
                value1: 'Name',
                value2: 'Shivansh Shukla',
                value3: 'Mobile Number',
                value4: '978694789'),
            SizedBox(
              height: 20,
            ),
            helper(
                value1: 'Email Id',
                value2: 'Shiv@Gmail.Com',
                value3: 'Address',
                value4: 'Vijay Nagar,Indore'),
            SizedBox(
              height: 20,
            ),
            helper(
                value1: 'Date',
                value2: 'Friday, 04 Oct.',
                value3: 'Time',
                value4: '1:00 PM TO 2:00 PM'),
            SizedBox(
              height: 20,
            ),
            helper(
                value1: 'Payment Details',
                value2: '2100/hr Via Phone Pay',
                value3: 'Payment Status',
                value4: 'Paid'),
          ],
        ),
      ),
    );
  }

  Widget sliderPointers(List doteList, int currentIndex) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: doteList.asMap().entries.map((entry) {
          return GestureDetector(
            // onTap:()=> controller.carouselController.animateToPage(entry.key),
            child: Container(
              width: currentIndex == entry.key ? 25 : 12,
              height: 4.0,
              margin: const EdgeInsets.symmetric(
                horizontal: 3.0,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: currentIndex == entry.key
                      ? colors.secondary
                      : Colors.grey),
            ),
          );
        }).toList());
  }

  Widget helper({
    required String value1,
    required String value2,
    required String value3,
    required String value4,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value1,
                style: TextStyle(fontSize: 14,fontWeight:FontWeight.bold ),
              ),
              Text(
                value2,
                style: TextStyle(fontSize: 12, color: colors.secondary),
              )
            ],
          ),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value3,
                style: TextStyle(fontSize: 14,fontWeight:FontWeight.bold),
              ),
              Text(
                value4,
                style: TextStyle(fontSize: 12, color: colors.secondary),
              )
            ],
          ),
        )
      ],
    );
  }


}
