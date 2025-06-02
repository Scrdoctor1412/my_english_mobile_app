import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/widget/complete/difficult_words/difficult_words_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class DifficultWordsScreen extends StatelessWidget {
  static const routeName = "/difficultWordsScreen";
  const DifficultWordsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DifficultWordsScreenViewmodel>(
      init: DifficultWordsScreenViewmodel(),
      builder: (controller) {
        controller.context = context;
        var screenWidth = MediaQuery.of(context).size.width;
        var screenHeight = MediaQuery.of(context).size.height;

        _appBar() {
          return AppBar(
            title: Text("Difficult words"),
          );
        }

        _wordItem({required Word word, required int index}) {
          return InkWell(
            onTap: () {
              controller.onTapToWordDetails(word);
            },
            child: Container(
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
                          word.word,
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
                    word.senses[0].definition,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      controller.onTapSaveWordToMyWordList(word: word);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Icon(
                        Icons.create_new_folder_rounded,
                        // color: ThemePrimary.grey.withAlpha(150),
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Divider(
                    color: ThemePrimary.grey.withAlpha(80),
                  ),
                ],
              ),
            ),
          );
        }

        _easyWordList() {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            width: screenWidth,
            // height: screenHeight,
            // height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Easy",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 8),
                ...List.generate(
                  controller.easyWordList.length,
                  (index) => _wordItem(
                      word: controller.easyWordList[index], index: index),
                )
                // Expanded(
                //   child: CustomScrollView(
                //     physics: NeverScrollableScrollPhysics(),
                //     slivers: [
                //       SliverList(
                //         delegate: SliverChildBuilderDelegate(
                //           (context, index) => _wordItem(
                //               word: controller.easyWordList[index],
                //               index: index),
                //           childCount: controller.easyWordList.length,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          );
        }

        _mediumWordList() {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            width: screenWidth,
            // height: screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Medium",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                ...List.generate(
                  controller.mediumWordList.length,
                  (index) => _wordItem(
                      word: controller.mediumWordList[index], index: index),
                )
                // Expanded(
                //   child: CustomScrollView(
                //     physics: NeverScrollableScrollPhysics(),
                //     slivers: [
                //       SliverList(
                //         delegate: SliverChildBuilderDelegate(
                //           (context, index) => _wordItem(
                //               word: controller.mediumWordList[index],
                //               index: index),
                //           childCount: controller.mediumWordList.length,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          );
        }

        _hardWordList() {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            width: screenWidth,
            // height: screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hard",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                ...List.generate(
                  controller.hardWordList.length,
                  (index) => _wordItem(
                      word: controller.hardWordList[index], index: index),
                )
                // Expanded(
                //   child: CustomScrollView(
                //     physics: NeverScrollableScrollPhysics(),
                //     slivers: [
                //       SliverList(
                //         delegate: SliverChildBuilderDelegate(
                //           (context, index) => _wordItem(
                //               word: controller.hardWordList[index],
                //               index: index),
                //           childCount: controller.hardWordList.length,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          );
        }

        _body() {
          // return Container(
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: 12,
          //   ),
          //   child: ListView.builder(
          //     padding: const EdgeInsets.symmetric(vertical: 12),
          //     itemBuilder: (context, index) => _wordItem(index),
          //     itemCount: controller.wordList.length,
          //   ),
          // );
          return SingleChildScrollView(
            child: Container(
              width: screenWidth,
              padding: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              child: Column(
                children: [
                  controller.easyWordList.isNotEmpty
                      ? _easyWordList()
                      : SizedBox(),
                  const SizedBox(
                    height: 12,
                  ),
                  controller.mediumWordList.isNotEmpty
                      ? _mediumWordList()
                      : SizedBox(),
                  const SizedBox(
                    height: 12,
                  ),
                  controller.hardWordList.isNotEmpty
                      ? _hardWordList()
                      : SizedBox(),
                ],
              ),
            ),
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
