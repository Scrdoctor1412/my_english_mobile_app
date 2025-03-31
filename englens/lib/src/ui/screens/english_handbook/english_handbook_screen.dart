import 'package:englens/src/ui/screens/english_handbook/english_handbook_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnglishHandbookScreen extends StatelessWidget {
  static const routeName = '/englishHandbookScreen';
  const EnglishHandbookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EnglishHandbookScreenViewmodel>(
      init: EnglishHandbookScreenViewmodel(),
      builder: (controller) {
        controller.context = context;
        _body() {
          return Center(
            child: Text('English handbook screen'),
          );
        }

        return Scaffold(
          body: _body(),
        );
      },
    );
  }
}
