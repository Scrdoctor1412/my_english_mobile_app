import 'package:englens/src/ui/screens/scan_to_translate/scan_to_translate_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanToTranslateScreen extends StatelessWidget {
  static const routeName = '/scanToTranslateScreen';
  const ScanToTranslateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScanToTranslateScreenViewmodel>(
      init: ScanToTranslateScreenViewmodel(),
      builder: (controller) {
        controller.context = context;
        _body() {
          return Center(
            child: Text('Scan to translate screen'),
          );
        }

        return Scaffold(
          body: _body(),
        );
      },
    );
  }
}
