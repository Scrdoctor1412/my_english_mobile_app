import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';

class WordDetailsScreen extends StatelessWidget {
  static const String routeName = '/wordDetailsScreen';
  const WordDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordDetailsScreenViewmodel>(
      init: WordDetailsScreenViewmodel(),
      builder: (controller) {
        controller.context = context;
        var screenWidth = MediaQuery.of(context).size.width;
        var screenHeight = MediaQuery.of(context).size.height;

        _appBar() {
          return AppBar(
            title: Text(controller.lessonTitle),
            bottom: controller.isFromLessonDetailsScreen
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(1),
                    child: Container(
                      // height: 200,
                      // color: Colors.grey,
                      child: LinearProgressIndicator(
                        value: controller.progressValue,
                      ),
                    ),
                  )
                : null,
          );
        }

        _wordDetails(int index) {
          var word = controller.isFromLessonDetailsScreen
              ? controller.words[index]
              : controller.onlyWord![index];
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                word.img != null && word.img != ""
                    ? Container(
                        width: screenWidth * 0.8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: Image.network('${word.img}'),
                        ),
                      )
                    : SizedBox(),
                const SizedBox(height: 20),
                Text(
                  word.word,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  '/${word.pronunciation != null && word.pronunciation != "" ? word.pronunciation : word.phoneticText == "" ? '' : word.phoneticText.split('/')[1]}/',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.indigo,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    word.pos,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.onTapSaveWordToMyWordList(word: word);
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: ThemePrimary.grey.withAlpha(60),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.photo_filter),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.onTapPlayAudio(word.phoneticAm);
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: ThemePrimary.grey.withAlpha(60),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.volume_up_outlined),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                Text(
                  word.senses[0].definition,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xfff7f9fc),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.question_answer_outlined),
                          const SizedBox(width: 8),
                          Text(
                            'Examples',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          word.senses[0].examples?.length ?? 0,
                          (egIndex) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: ThemePrimary.primaryOrange,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        word.senses[0].examples?[egIndex].x ??
                                            "",
                                        style: TextStyle(
                                          fontSize: 16,
                                          // color: Colors.grey,
                                        ),
                                        // maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        }

        _body() {
          return controller.isFromLessonDetailsScreen
              ? PageView.builder(
                  onPageChanged: (value) {
                    controller.onChangePage(value);
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16, left: 16),
                      child: index <= controller.words.length - 1
                          ? _wordDetails(index)
                          : SizedBox(),
                    );
                  },
                  itemCount: controller.tempWords.length,
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _wordDetails(0),
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
