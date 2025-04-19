import 'package:flutter/material.dart';

class BigContentBlockWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color? color;
  final Widget? image;
  final VoidCallback? toScreen;

  const BigContentBlockWidget(
      {Key? key,
      required this.title,
      required this.subTitle,
      this.color,
      this.image,
      this.toScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWdith = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: toScreen,
      child: Container(
        // width: screenWdith / 2,
        // width: 158,
        // width: screenWdith / 2 - 22,
        width: screenWdith * 0.45,
        height: screenHeight * 0.34,
        decoration: BoxDecoration(
          color: color ?? Colors.lightGreenAccent,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(subTitle),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 65,
                  height: 65,
                  child: image ?? SizedBox(),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
