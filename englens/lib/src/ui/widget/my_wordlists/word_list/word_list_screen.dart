import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/widget/my_wordlists/word_list/word_list_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class WordListScreen extends StatelessWidget {
  static const routeName = '/wordListScreen';

  const WordListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordListScreenViewmodel>(
      init: WordListScreenViewmodel(),
      builder: (controller) {
        controller.context = context;
        _appBar() {
          return AppBar(
            title: Text(
              'Word list ${controller.title}',
              // style: TextStyle(color: Colors.black),
            ),
            // backgroundColor: Colors.white,
            // foregroundColor: Colors.black,
            centerTitle: true,
            actions: [
              if (controller.fromScreen == ToWordListFromScreen.neutral)
                IconButton(
                  onPressed: () {
                    controller.onTapToStudyWord();
                  },
                  icon: Icon(Icons.add),
                ),
              if (controller.isOnLongPress)
                IconButton(
                  onPressed: () {
                    // controller.onTapToStudyWord();
                    controller.onAcceptSelect();
                  },
                  icon: Icon(Icons.check),
                )
            ],
            leading: controller.isOnLongPress
                ? IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      controller.onCancelSelect();
                    },
                  )
                : null,
          );
        }

        _emptyWidget() {
          // return
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 260,
                height: 260,
                child: Image.asset('assets/images/empty_data.png'),
              ),
              Text(
                'You haven\'t add any words yet!',
                style: TextStyle(
                  color: ThemePrimary.grey.withAlpha(150),
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          );
        }

        _wordItem(int index) {
          return Slidable(
            endActionPane: controller.fromScreen == ToWordListFromScreen.neutral
                ? ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      // SlidableAction(
                      //   onPressed: (context) {
                      //     controller.onTapEditWord(index);
                      //   },
                      //   backgroundColor: ThemePrimary.primaryOrange,
                      //   foregroundColor: Colors.white,
                      //   icon: Icons.edit,
                      //   label: 'Edit',
                      // ),
                      SlidableAction(
                        onPressed: (context) {
                          controller.onTapDeleteWord(index);
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      )
                    ],
                  )
                : null,
            child: InkWell(
              onTap: () {
                controller.isOnLongPress
                    ? controller.onPressSelectOrDeselect(index)
                    : controller.onTapToWordDetails(controller.wordList[index]);
              },
              onLongPress: () {
                // print("on longf press");
                controller.onLongPress(index);
              },
              child: Container(
                padding: const EdgeInsets.only(
                  right: 12,
                  left: 12,
                  top: 10,
                ),
                decoration: BoxDecoration(
                  color: controller.wordSelected[index]
                      ? Colors.grey.shade300
                      : Colors.white,
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
                    // Divider(
                    //   color: ThemePrimary.grey.withAlpha(80),
                    // ),
                  ],
                ),
              ),
            ),
          );
        }

        _body() {
          return Stack(
            children: [
              controller.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : controller.wordList.isEmpty
                      ? Center(child: _emptyWidget())
                      : Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            itemBuilder: (context, index) => _wordItem(index),
                            itemCount: controller.wordList.length,
                            separatorBuilder: (context, index) => Container(
                              color: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Divider(
                                color: ThemePrimary.grey.withAlpha(80),
                              ),
                            ),
                          ),
                        ),
              if (controller.isOnLongPress &&
                  controller.fromScreen == ToWordListFromScreen.neutral) ...[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.onAcceptSelect();
                      },
                      child: Text("Learn now"),
                    ),
                  ),
                ),
              ],
            ],
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
