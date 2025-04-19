import 'package:englens/src/ui/screens/study/expressions/expressions_screen_viewmode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpressionsScreen extends StatelessWidget {
  static const routeName = '/expressionsScreen';
  const ExpressionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExpressionsScreenViewModel>(
      init: ExpressionsScreenViewModel(),
      builder: (controller) {
        _body() {
          return Center(
            child: Text('Hi expressions'),
          );
        }

        return Scaffold(
          body: _body(),
        );
      },
    );
  }
}
