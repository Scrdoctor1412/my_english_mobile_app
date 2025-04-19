import 'package:flutter/material.dart';

class SettingsItemContentWidget extends StatelessWidget {
  final String title;
  final Widget? trailing;
  const SettingsItemContentWidget({
    Key? key,
    required this.title,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        trailing ?? SizedBox.shrink(),
      ],
    );
  }
}
