import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/widget/my_wordlists/word_list/word_list_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class WordListScreen extends StatelessWidget {
  static const routeName = '/wordListScreen';
  const WordListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordListScreenViewmodel>(
      init: WordListScreenViewmodel(),
      builder: (controller) {
        _appBar() {
          return AppBar(
            title: Text(
              'Title User\'s Word List Name',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            centerTitle: true,
          );
        }

        _wordItem(int index) {
          return Container(
            padding: const EdgeInsets.only(
              right: 12,
              left: 12,
              top: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: index == 0
                  ? BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    )
                  : index == controller.wordList.length - 1
                      ? BorderRadius.only(
                          bottomRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        )
                      : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 5,
                      height: 26,
                      decoration: BoxDecoration(
                        color: ThemePrimary.primaryOrange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        controller.wordList[index].word,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  controller.wordList[index].senses[0].definition,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  color: ThemePrimary.grey.withAlpha(80),
                ),
              ],
            ),
          );
        }

        _body() {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemBuilder: (context, index) => _wordItem(index),
              itemCount: controller.wordList.length,
            ),
          );
        }

        return Scaffold(
          // backgroundColor: ,
          appBar: _appBar(),
          body: _body(),
        );
      },
    );
  }
}
