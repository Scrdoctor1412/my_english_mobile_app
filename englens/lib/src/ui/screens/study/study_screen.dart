import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/study/study_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudyScreen extends StatelessWidget {
  static const routeName = '/studyScreen';
  const StudyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudyScreenViewmodel>(
      init: StudyScreenViewmodel(),
      builder: (controller) {
        controller.context = context;
        var screenWdith = MediaQuery.of(context).size.width;
        var screenHeight = MediaQuery.of(context).size.height;

        _customBackground() {
          return Container(
            width: screenWdith,
            height: screenHeight * 0.4,
            decoration: BoxDecoration(
              color: ThemePrimary.primaryOrange,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
          );
        }

        _bigContentBlock() {
          return InkWell(
            onTap: () {},
            child: Container(
              // width: screenWdith / 2,
              width: 158,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.lightGreenAccent,
                borderRadius: BorderRadius.circular(16),
              ),
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text('Sub title'),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 55,
                        height: 55,
                        child: Image.asset(
                          'assets/images/study/book_grammar.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }

        _smallContentBlock() {
          return InkWell(
            onTap: () {},
            child: Container(
              width: 158,
              height: 158,
              decoration: BoxDecoration(
                color: Color(0xffcbe7fb),
                borderRadius: BorderRadius.circular(16),
              ),
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text('Sub title'),
                  const Spacer(),
                  // const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 55,
                        height: 55,
                        child: Image.asset(
                          'assets/images/study/book_grammar.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }

        _contentGrid() {
          return Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      spacing: 16,
                      children: [
                        _bigContentBlock(),
                        _smallContentBlock(),
                      ],
                    ),
                    Column(
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _smallContentBlock(),
                        _smallContentBlock(),
                        _smallContentBlock(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        _bodyBlock() {
          return Container(
            width: screenWdith,
            // height: 200,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(30),
                  spreadRadius: 1.5,
                  blurRadius: 2,
                ),
              ],
            ),
            child: _contentGrid(),
          );
        }

        _body() {
          return Stack(
            children: [
              SizedBox(
                width: screenWdith,
                height: screenHeight,
              ),
              Positioned(
                top: 0,
                child: _customBackground(),
              ),
              Positioned(
                top: 60,
                left: 16,
                child: Container(
                  width: screenWdith,
                  child: Row(
                    children: [
                      Text(
                        'Let\'s study',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.folder_copy,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                top: 120,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: _bodyBlock(),
                ),
              ),
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
