import 'package:englens/src/theme/theme_primary.dart';
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
            title: Text(
              'My Word list',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
          );
        }

        _bodyItem({required String title, required Function() onTap}) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  onTap();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
              Divider(
                color: ThemePrimary.grey.withAlpha(100),
              ),
            ],
          );
        }

        _body() {
          return Column(
            children: [
              _bodyItem(
                title: "Word list",
                onTap: () {
                  controller.onTapToWordList();
                },
              ),
              _bodyItem(title: "Bookmark", onTap: () {}),
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
