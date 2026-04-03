import 'package:englens/src/ui/screens/study/pronunciation/pronunciation_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PronunciationScreen extends GetView<PronunciationScreenViewmodel> {
  static const routeName = '/pronunciationScreen';
  const PronunciationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _body() {
      return Center(child: Text('Hi'));
    }

    return Scaffold(body: _body());
  }
}
