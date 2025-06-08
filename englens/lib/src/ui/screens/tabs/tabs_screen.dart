import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/tabs/tabs_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabsScreen extends StatelessWidget {
  static const routeName = '/tabsScreen';
  const TabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabsScreenViewmodel>(
      init: TabsScreenViewmodel(),
      builder: (controller) {
        controller.context = context;

        _body() {
          return controller.tabsScreen[controller.tabIndex];
        }

        _bottomNavigationBar() {
          return NavigationBarTheme(
            data: NavigationBarThemeData(
              labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
                (Set<WidgetState> states) =>
                    states.contains(WidgetState.selected)
                        ? const TextStyle(
                            color: ThemePrimary.primaryOrange,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          )
                        : const TextStyle(color: Colors.black),
              ),
            ),
            child: NavigationBar(
              indicatorColor: ThemePrimary.lightOrange,
              onDestinationSelected: (index) {
                controller.onTapChangeScreen(index);
              },
              // labelTextStyle: ,
              surfaceTintColor: ThemePrimary.lightOrange,
              selectedIndex: controller.tabIndex,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              destinations: [
                NavigationDestination(
                    icon: Icon(
                      Icons.home,
                      color: controller.tabIndex == 0
                          ? Colors.white
                          : Colors.black,
                    ),
                    label: 'Home'),
                NavigationDestination(
                    icon: Icon(
                      Icons.school,
                      color: controller.tabIndex == 1
                          ? Colors.white
                          : Colors.black,
                    ),
                    label: 'Study'),
                // NavigationDestination(
                //     icon: Icon(
                //       Icons.translate,
                //       color: controller.tabIndex == 2
                //           ? Colors.white
                //           : Colors.black,
                //     ),
                //     label: 'Translate'),
                NavigationDestination(
                    icon: Icon(
                      Icons.book,
                      color: controller.tabIndex == 3
                          ? Colors.white
                          : Colors.black,
                    ),
                    label: 'Handbook'),
                NavigationDestination(
                    icon: Icon(
                      Icons.settings,
                      color: controller.tabIndex == 4
                          ? Colors.white
                          : Colors.black,
                    ),
                    label: 'Settings'),
              ],
            ),
          );
        }

        return Scaffold(
          body: _body(),
          bottomNavigationBar: _bottomNavigationBar(),
        );
      },
    );
  }
}
