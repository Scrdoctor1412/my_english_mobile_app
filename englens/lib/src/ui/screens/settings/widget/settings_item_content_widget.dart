import 'package:flutter/material.dart';

class SettingsItemContentWidget extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final Widget? child;
  final Function? onTap;
  const SettingsItemContentWidget({
    Key? key,
    required this.title,
    this.trailing,
    this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child ??
        InkWell(
          onTap: () {
            onTap != null ? onTap!() : null;
          },
          child: Row(
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
          ),
        );
  }
}
