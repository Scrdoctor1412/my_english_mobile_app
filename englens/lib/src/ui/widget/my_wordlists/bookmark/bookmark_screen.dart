import 'package:auto_size_text/auto_size_text.dart';
import 'package:englens/src/core/extensions/string_extensions.dart';
import 'package:englens/src/core/theme/theme_primary.dart';
import 'package:englens/src/ui/widget/flashcards/flashcards_screen.dart';
import 'package:englens/src/ui/widget/flashcards/flashcards_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/my_wordlists/bookmark/bookmark_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen_viewmodel.dart';
import 'package:englens/src/core/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class BookmarkScreen extends StatelessWidget {
  static const routeName = "/bookmarkScreen";
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookmarkScreenViewmodel>(
      init: BookmarkScreenViewmodel(),
      builder: (controller) {
        var screenWidth = MediaQuery.of(context).size.width;
        var screenHeight = MediaQuery.of(context).size.height;

        _appBar() {
          return AppBar(
            title: Text('Bookmarks', style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  // padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade300,
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelColor: Colors.black,
                    dividerColor: Colors.transparent,
                    // unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(
                        // child: Text('Books'),
                        text: "Books",
                      ),
                      Tab(text: "Lessons"),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        _emptyWidget() {
          // return
          return Container(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset('assets/images/empty_data.png'),
                ),
                Text(
                  'No data found',
                  style: TextStyle(
                    color: ThemePrimary.grey.withAlpha(150),
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          );
        }

        _bookmarkBooksItem(int index) {
          return InkWell(
            onTap: () {
              controller.onTapGetToLessonDetails(index);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                    child: Image.asset(
                      "assets/images/learning_category/${controller.bookmarkedBooks[index].title}.jpg",
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.bookmarkedBooks[index].title
                              .snakeCaseToNormal(),

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 3,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.menu_book_rounded,
                              color: ThemePrimary.successGreen,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${controller.bookmarkedBooks[index].lessons!.length} Lesson',
                            ),
                            const SizedBox(width: 12),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        _LessonLearnFlow(int index) {
          __lessonLearnItem({
            required String title,
            required String assetImagePath,
            required VoidCallback onTap,
          }) {
            return GestureDetector(
              onTap: onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ThemePrimary.primaryBlue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(42),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Center(
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: Image.asset(
                          assetImagePath,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(title),
                ],
              ),
            );
          }

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: Divider(thickness: 2, color: ThemePrimary.grey),
                ),
                __lessonLearnItem(
                  title: 'Review',
                  assetImagePath: 'assets/icons/review_blue.png',
                  onTap: () {
                    Get.toNamed(
                      WordDetailsScreen.routeName,
                      arguments: WordDetailsScreenViewmodelArgs(
                        words: controller.bookmarkedLessons[index].wordList!,
                        lessonTitle: controller.bookmarkedLessons[index].title,
                        isFromLessonDetailsScreen: true,
                      ),
                    );
                  },
                ),
                Expanded(
                  child: Divider(thickness: 2, color: ThemePrimary.grey),
                ),
                __lessonLearnItem(
                  title: 'Flashcards',
                  assetImagePath: 'assets/icons/flashcards_blue.png',
                  onTap: () {
                    Get.toNamed(
                      FlashcardsScreen.routeName,
                      arguments: FlashcardsScreenArgs(
                        title: controller.bookmarkedLessons[index].title,
                        wordList: controller.bookmarkedLessons[index].wordList!,
                      ),
                    );
                  },
                ),
                Expanded(
                  child: Divider(thickness: 2, color: ThemePrimary.grey),
                ),
              ],
            ),
          );
        }

        _bookmarkLessonItem(int index) {
          return Container(
            width: screenWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            // height: screenHeight,
            child: ExpansionTileTheme(
              data: ExpansionTileThemeData(
                collapsedBackgroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.transparent),
                ),
                collapsedShape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.transparent),
                ),
                collapsedIconColor: Colors.black,
                iconColor: Colors.black,
                collapsedTextColor: Colors.black,
              ),
              child: ExpansionTile(
                title: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.bookmarkedLessonTopicTitle[index],
                        style: TextStyle(color: Colors.blue),
                      ),
                      Text(
                        controller.bookmarkedLessons[index].lesson
                            .snakeCaseToNormal(),

                        // 'Lesson ${index + 1}',
                        style: TextStyle(fontSize: 15),
                      ),
                      // const SizedBox(height: 8),
                      AutoSizeText(
                        // '${controller.lessons[0].wordList?.length} words',
                        controller.bookmarkedLessons[index].title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                trailing: SizedBox(
                  width: screenWidth * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // IconButton(
                      //   onPressed: () {
                      //     // controller.onTapBookmarkLesson(index);
                      //   },
                      //   icon: Icon(
                      //     Icons.bookmark_add_outlined,
                      //     color: controller.isBookmarkLessons[index]
                      //         ? ThemePrimary.primaryBlue
                      //         : Colors.black,
                      //   ),
                      // ),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: Icon(Icons.chevron_right),
                      // ),
                      Icon(
                        Icons.chevron_right,
                        // color: ThemePrimary.grey,
                      ),
                    ],
                  ),
                ),
                children: [_LessonLearnFlow(index)],
              ),
            ),
          );
          // return Container(
          //   child: Row(
          //     children: [
          //       // Icon(Icons.image_search_sharp),

          //       const SizedBox(
          //         width: 12,
          //       ),
          //       Column(
          //         children: [
          //           Text(
          //             snakeCaseToNormal(
          //                 controller.bookmarkedLessons[index].title),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // );
        }

        _booksTab() {
          return controller.isLoading
              ? CircularProgressIndicator()
              : controller.bookmarkedBooks.isEmpty
              ? Center(child: _emptyWidget())
              : Padding(
                  padding: const EdgeInsets.only(top: 32, left: 12, right: 12),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                // controller.onTapDeleteWordList(
                                //     controller.userWordList[index].id!);
                                controller.onTapDeleteBookmarkBook(index);
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                              spacing: 2,
                            ),
                          ],
                        ),
                        child: _bookmarkBooksItem(index),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 20),
                    itemCount: controller.bookmarkedBooks.length,
                  ),
                );
        }

        _lessonsTab() {
          return controller.isLoading
              ? CircularProgressIndicator()
              : controller.bookmarkedLessons.isEmpty
              ? Center(child: _emptyWidget())
              : Padding(
                  padding: const EdgeInsets.only(top: 32, left: 12, right: 12),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                // controller.onTapDeleteWordList(
                                //     controller.userWordList[index].id!);
                                controller.onTapDeleteBookmarkLesson(index);
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                              spacing: 2,
                            ),
                          ],
                        ),
                        child: _bookmarkLessonItem(index),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 20),
                    itemCount: controller.bookmarkedLessons.length,
                  ),
                );
        }

        _body() {
          return TabBarView(children: [_booksTab(), _lessonsTab()]);
        }

        return DefaultTabController(
          length: 2,
          child: Scaffold(appBar: _appBar(), body: _body()),
        );
      },
    );
  }
}
