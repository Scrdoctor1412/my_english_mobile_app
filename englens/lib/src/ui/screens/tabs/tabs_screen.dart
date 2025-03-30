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
        return Scaffold(body: Center(child: Text('hello world')));
      },
    );
  }
}
