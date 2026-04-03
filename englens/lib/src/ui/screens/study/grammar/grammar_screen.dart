import 'package:englens/src/core/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/study/grammar/grammar_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GrammarScreen extends GetView<GrammarScreenViewmodel> {
  static const routeName = '/grammarScreen';

  const GrammarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _appBar() {
      return AppBar(
        // backgroundColor: ThemePrimary.primaryOrange,
        title: Text('Grammar'),
      );
    }

    _progressIndicator(int progress) {
      return Stack(
        children: [
          SizedBox(
            height: 23,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: LinearProgressIndicator(
                value: progress / 100,
                backgroundColor: ThemePrimary.lightOrange,
                color: ThemePrimary.darkBlue,
                borderRadius: BorderRadius.circular(26),
              ),
            ),
          ),
          Positioned(
            left: 10,
            child: Text(
              '$progress %',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }

    _grammarRowItem({
      required String title,
      required String subTitle,
      required int index,
    }) {
      return InkWell(
        onTap: () {
          controller.onTapToGrammarLessons(index);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                subTitle,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              _progressIndicator(
                controller.listGrammarRowItem[index].progress.toInt(),
              ),
            ],
          ),
        ),
      );
    }

    _body() {
      return ListView.builder(
        itemCount: controller.listGrammarRowItem.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 15, left: 12, right: 12),
            child: _grammarRowItem(
              index: index,
              title: controller.listGrammarRowItem[index].title,
              subTitle: controller.listGrammarRowItem[index].subtitle,
            ),
          );
        },
      );
    }

    return Scaffold(appBar: _appBar(), body: _body());
  }
}
