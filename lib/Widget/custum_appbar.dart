
import 'package:bookplayapp/Helper/color.dart';
import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget{
  final String? title;
  final String? notificationIcon;
  final String? leadingImage;
  final VoidCallback? onPressedLeading;
  final VoidCallback? onPressedNotification;
  final int? index;

  const CustomAppBar({
    Key? key,
    this.title,
    this.notificationIcon,
    this.leadingImage,
    this.onPressedLeading,
    this.onPressedNotification,this.index

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return

      Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colors.primary,
              colors.secondary,
            ],
            // Define the colors
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: onPressedLeading,
                  child: leadingImage == null ? const Icon(Icons.arrow_back_ios, color: colors.whiteTemp,) :  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        color: colors.whiteTemp,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(leadingImage!, scale: 1.7),
                  ),
                ),
                title == null ? const Icon(
                  Icons.location_on,
                  size: 25.0,
                  color: colors.whiteTemp,
                ) : const SizedBox.shrink(),

                SizedBox(
                  width: MediaQuery.of(context).size.width/1.5,
                  child: Center(
                    child: Text(
                      title.toString(),
                      style: const TextStyle(
                        color: colors.whiteTemp,
                        fontSize: 20.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                notificationIcon != null ?InkWell(
                  onTap: () {

                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        color:colors.whiteTemp,
                        borderRadius: BorderRadius.circular(10)),
                    child:
                    Image.asset(notificationIcon!, scale: 1.5),
                  ),
                ): const SizedBox.shrink(),
              ],
            ),
          ],
        ),
      );
  }

}

Widget screenStackContainer(BuildContext context){
  return Stack(
    children: [
      Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            // Top-left corner radius
            topRight: Radius.circular(30),
            // Bottom-right corner with no rounding
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.007),          child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: const BoxDecoration(
          color: colors.whiteTemp,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            // Top-left corner radius
            topRight: Radius.circular(30),
            // Bottom-right corner with no rounding
          ),
        ),
      ),
      ),
    ],
  );
}