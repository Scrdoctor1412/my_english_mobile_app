import 'package:auto_size_text/auto_size_text.dart';
import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/home/leitner_daily_words/leitner_box/leitner_box_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeitnerBoxScreen extends StatelessWidget {
  static const routeName = '/leitnerBoxScreen';
  const LeitnerBoxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeitnerBoxScreenViewmodel>(
      init: LeitnerBoxScreenViewmodel(),
      builder: (controller) {
        _wordItemRow(int index) {
          __countDownDayTag() {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 2,
              ),
              child: Row(
                children: [
                  Text(
                    controller.countDownDayText,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.timelapse_sharp,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
            );
          }

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    "${index + 1}.${controller.wordList[index].word}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    // maxLines: 2,
                  ),
                ),
                // Text(
                //   "1.to do",
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                const Spacer(),
                __countDownDayTag(),
                IconButton(
                  onPressed: () {
                    controller.onTapDeleteWordFromLeitnerBox(index);
                  },
                  icon: Icon(
                    Icons.delete_forever_outlined,
                  ),
                ),
              ],
            ),
          );
        }

        Widget _body() {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 120,
                floating: true,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.lightBlueAccent,
                        Colors.lightBlue,
                        Colors.blue,
                        ThemePrimary.primaryBlue,
                      ],
                    ),
                  ),
                  child: FlexibleSpaceBar(
                    background: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 6,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 32,
                            height: 32,
                            child: IconButton(
                              // padding: EdgeInsets.zero,
                              // constraints: BoxConstraints(),
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Leitner box ${controller.title}',
                            style: TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '${controller.wordList.length} words',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverList.separated(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  child: _wordItemRow(index),
                ),
                separatorBuilder: (context, index) => SizedBox(height: 0),
                itemCount: controller.wordList.length,
                // itemCount: 100,
              ),
              // SliverFillRemaining(),
            ],
          );
        }

        return Scaffold(
          body: _body(),
        );
      },
    );
  }
}
