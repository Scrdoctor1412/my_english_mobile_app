import 'package:englens/src/ui/widget/my_wordlists/my_wordlists_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyWordlistsScreen extends StatelessWidget {
  static const routeName = '/myWordListScreen';
  const MyWordlistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyWordlistsScreenViewmodel>(
      init: MyWordlistsScreenViewmodel(),
      builder: (controller) {
        _appBar() {
          return AppBar(
            title: Text('My wordlists'),
          );
        }

        _body() {
          return Column(
            children: [
              Center(
                child: Text('Hello my wordlist'),
              ),
            ],
          );
        }

        return Scaffold(
          appBar: _appBar(),
          body: _body(),
        );
      },
    );
  }
}
