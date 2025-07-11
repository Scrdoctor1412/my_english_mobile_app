import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/widget/complete/complete_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CompleteScreen extends StatelessWidget {
  static const routeName = '/completeScreen';
  const CompleteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompleteScreenViewmodel>(
      init: CompleteScreenViewmodel(),
      builder: (controller) {
        _appBar() {
          return AppBar(
            title: Text(
              controller.title,
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                controller.onGetBack();
              },
              icon: Icon(Icons.arrow_back),
            ),
          );
        }

        _body() {
          return Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Image.asset('assets/images/complete_medal.png'),
                ),
                const SizedBox(height: 120),
                Text(
                  'You\'ve finished ${controller.praiseTypeText} successfully!',
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                controller.type == CompleteScreenType.flashcard
                    ? controller.listMapWordIncorrectKeys.isNotEmpty
                        ? TextButton(
                            onPressed: () {
                              controller.onTapToDifficultWords();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'See ${controller.listMapWordIncorrectKeys.length} difficult words',
                                  style: TextStyle(fontSize: 22),
                                ),
                                Icon(Icons.chevron_right),
                              ],
                            ),
                          )
                        : SizedBox()
                    : SizedBox(),
                const SizedBox(height: 90),
                if (controller.type != CompleteScreenType.leitnerBox) ...[
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.onTapToReview();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                          // horizontal: 80,
                          vertical: 12,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.reviewButtonTypeText,
                            style: TextStyle(fontSize: 20),
                          ),
                          controller.type == CompleteScreenType.wordReview
                              ? const Icon(Icons.refresh_outlined)
                              : const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.onTapResetFlashCards();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                          // horizontal: 80,
                          vertical: 12,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.flashcardButtonTypeText,
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 6),
                          controller.type == CompleteScreenType.flashcard
                              ? const Icon(Icons.refresh_outlined)
                              : const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        }

        return PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {
            if (didPop) {
              return;
            }
            controller.onGetBack();
          },
          child: Scaffold(
            appBar: _appBar(),
            body: _body(),
          ),
        );
      },
    );
  }
}
