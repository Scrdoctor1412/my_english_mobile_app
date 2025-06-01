import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/settings/widget/settings_item_content_widget.dart';
import 'package:flutter/material.dart';

class SettingsItemWidget extends StatelessWidget {
  final String title;
  final IconData? icon;
  final bool showTrailingIcon;
  final List<Widget>? children;
  final Widget? trailing;
  final bool isNotExpandable;
  final VoidCallback? onTap;
  final ExpansionTileThemeData _themeData;
  final bool showShadow;
  final List<Color>? gradient;

  SettingsItemWidget(
      {Key? key,
      this.children,
      required this.title,
      this.icon,
      this.showTrailingIcon = true,
      this.trailing,
      this.isNotExpandable = false,
      this.onTap,
      ExpansionTileThemeData? themeData,
      this.showShadow = true,
      this.gradient})
      : _themeData = themeData ??
            ExpansionTileThemeData(
              backgroundColor: Colors.white,
              collapsedBackgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              childrenPadding: const EdgeInsets.only(
                left: 22,
                right: 12,
                bottom: 12,
              ),
              iconColor: ThemePrimary.grey,
            ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    bool test = false;
    return ExpansionTileTheme(
      data: _themeData,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: showShadow
              ? [
                  BoxShadow(
                    color: Colors.black.withAlpha(60),
                    blurRadius: 12,
                    offset: Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: InkWell(
          onTap: onTap ?? () {},
          child: AbsorbPointer(
            absorbing: isNotExpandable,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradient ?? [Colors.transparent, Colors.transparent],
                ),
              ),
              child: ExpansionTile(
                // enabled: false,
                // enableFeedback: true,
                // collapsedBackgroundColor: Colors.white,
                showTrailingIcon: showTrailingIcon,
                trailing: trailing ?? null,
                initiallyExpanded: test,
                title: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                leading: icon != null
                    ? Icon(
                        icon,
                        color: ThemePrimary.grey,
                      )
                    : null,
                onExpansionChanged: (value) {
                  print(value);
                },
                children: [
                  ...children ?? [],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
