import 'package:englens/src/ui/widget/my_wordlists/bookmark/bookmark_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookmarkScreen extends StatelessWidget {
  static const routeName = "/bookmarkScreen";
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookmarkScreenViewmodel>(
      init: BookmarkScreenViewmodel(),
      builder: (controller) {
        _appBar() {
          return AppBar(
            title: Text(
              'Bookmarks',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
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
                      Tab(
                        text: "Lessons",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        _booksTab() {
          return Center(
            child: Text('books'),
          );
        }

        _lessonsTab() {
          return Center(
            child: Text('lessons'),
          );
        }

        _body() {
          return TabBarView(children: [
            _booksTab(),
            _lessonsTab(),
          ]);
        }

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: _appBar(),
            body: _body(),
          ),
        );
      },
    );
  }
}
