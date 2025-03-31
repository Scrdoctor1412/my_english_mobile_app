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
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Tabs'),
              ElevatedButton(
                onPressed: () {
                  controller.signout();
                },
                child: Text('Logout'),
              ),
            ],
          );
        }

        return Scaffold(
          body: _body(),
        );
      },
    );
  }
}
