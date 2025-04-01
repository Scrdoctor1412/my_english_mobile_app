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
          return NavigationBar(
            indicatorColor: ThemePrimary.lightOrange,
            onDestinationSelected: (index) {
              controller.onTapChangeScreen(index);
            },
            selectedIndex: controller.tabIndex,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.school), label: 'Study'),
              NavigationDestination(
                  icon: Icon(Icons.translate), label: 'Translate'),
              NavigationDestination(icon: Icon(Icons.book), label: 'Handbook'),
              NavigationDestination(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
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
