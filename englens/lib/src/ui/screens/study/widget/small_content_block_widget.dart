import 'package:flutter/material.dart';

class SmallContentBlockWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color? color;
  final Widget? image;
  final VoidCallback? toScreen;

  const SmallContentBlockWidget({
    Key? key,
    required this.title,
    required this.subTitle,
    this.color,
    this.image,
    this.toScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWdith = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: toScreen,
      child: Container(
        width: screenWdith / 2 - 22,
        height: screenHeight * 0.2,
        decoration: BoxDecoration(
          color: color ?? Color(0xffe7f8ff),
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
            // const SizedBox(height: 12),
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
