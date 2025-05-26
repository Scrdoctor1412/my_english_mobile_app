import 'package:englens/src/data/models/user_word_list.dart';
import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/settings/widget/settings_item_content_widget.dart';
import 'package:englens/src/ui/screens/settings/widget/settings_item_widget.dart';
import 'package:englens/src/ui/widget/my_wordlists/my_wordlists_screen_viewmodel.dart';
import 'package:englens/src/utils/helper.dart';
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
        controller.context = context;
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

        _emptyWidget() {
          // return
          return Column(
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Image.asset('assets/images/empty_data.png'),
              ),
              Text(
                'You haven\'t add any word list yet!',
                style: TextStyle(
                  color: ThemePrimary.grey.withAlpha(150),
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          );
        }

        _body() {
          return Column(
            children: [
              SettingsItemWidget(
                title: "Word list",
                showShadow: false,
                themeData: ExpansionTileThemeData(
                  backgroundColor: Colors.transparent,
                  collapsedBackgroundColor: Colors.transparent,
                  collapsedShape: RoundedRectangleBorder(),
                  shape: RoundedRectangleBorder(),
                  childrenPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                ),
                children: controller.userWordList.length > 0
                    ? [
                        ...List.generate(
                          controller.userWordList.length,
                          (index) => SettingsItemContentWidget(
                            trailing: IconButton(
                              onPressed: () {
                                controller.onTapToWordList(
                                    controller.userWordList[index].id!,
                                    controller.userWordList[index].name);
                              },
                              icon: Icon(
                                Icons.chevron_right,
                              ),
                            ),
                            title: controller.userWordList[index].name,
                            onTap: () {
                              controller.onTapToWordList(
                                  controller.userWordList[index].id!,
                                  controller.userWordList[index].name);
                            },
                          ),
                        ),
                        SettingsItemContentWidget(
                          title: "hi",
                          child: InkWell(
                            onTap: () {
                              controller.onTapAddWordList();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 35,
                              child: Icon(
                                Icons.add,
                              ),
                            ),
                          ),
                        ),
                      ]
                    : [
                        SettingsItemContentWidget(
                          child: _emptyWidget(),
                          title: "lmao",
                        ),
                        SettingsItemContentWidget(
                          title: "hi",
                          child: InkWell(
                            onTap: () {
                              controller.onTapAddWordList();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 35,
                              child: Icon(
                                Icons.add,
                              ),
                            ),
                          ),
                        ),
                      ],
              ),
              Divider(
                color: ThemePrimary.grey.withAlpha(100),
              ),
              SettingsItemWidget(
                title: "Bookmark",
                showShadow: false,
                isNotExpandable: true,
                themeData: ExpansionTileThemeData(
                  backgroundColor: Colors.transparent,
                  collapsedBackgroundColor: Colors.transparent,
                  collapsedShape: RoundedRectangleBorder(),
                  shape: RoundedRectangleBorder(),
                ),
                // showTrailingIcon: false,
                // icon: Icons.chevron_right,
                trailing: Icon(Icons.chevron_right),
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
