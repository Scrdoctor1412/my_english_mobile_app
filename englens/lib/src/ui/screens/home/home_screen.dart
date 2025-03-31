import 'package:englens/src/ui/screens/home/home_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/homeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenViewmodel>(
      init: HomeScreenViewmodel(),
      builder: (controller) {
        controller.context = context;
        _body() {
          return Center(
            child: Text('Home screen'),
          );
        }

        return Scaffold(
          body: _body(),
        );
      },
    );
  }
}
