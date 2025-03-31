import 'package:englens/src/ui/screens/settings/settings_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settingsScreen';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsScreenViewmodel>(
      init: SettingsScreenViewmodel(),
      builder: (controller) {
        controller.context = context;
        _body() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text('Settings screen'),
              ),
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
