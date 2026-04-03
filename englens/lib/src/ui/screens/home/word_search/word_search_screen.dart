import 'package:englens/src/core/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/home/word_search/word_search_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/english_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WordSearchScreen extends GetView<WordSearchScreenViewmodel> {
  static const routeName = '/wordSearhScreen';
  const WordSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    var screenWidth = MediaQuery.of(context).size.width;
    // var screenHeight = MediaQuery.of(context).size.height;

    _appBar() {
      return AppBar(title: Text('Search'));
    }

    _searchBar() {
      return Container(
        width: screenWidth,
        height: 65,
        child: Hero(
          tag: "search_text_field",
          child: Material(
            color: Colors.transparent,
            child: TextFormField(
              controller: controller.searchController,
              autofocus: true,
              onChanged: (value) {
                controller.onSearch(value);
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'What word will you search today?',
                hintStyle: TextStyle(
                  fontSize: 15,
                  color: ThemePrimary.grey,
                  fontWeight: FontWeight.w600,
                ),
                suffixIcon: Icon(Icons.search, color: ThemePrimary.grey),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.transparent.withAlpha(0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.transparent.withAlpha(0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.transparent.withAlpha(0),
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.transparent.withAlpha(0),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.transparent.withAlpha(0),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    _searchResult() {
      return ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            width: screenWidth,
            height: 230,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: InkWell(
              onTap: () {
                controller.onTapToWordDetails(index);
              },
              child: EnglishCard(word: controller.searchResult[index]),
            ),
          );
        },
        // separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemCount: controller.searchResult.length,
      );
    }

    _body() {
      return Column(
        children: [
          _searchBar(),
          controller.searchResult.isEmpty
              ? Container()
              : Expanded(child: _searchResult()),
        ],
      );
    }

    return Scaffold(appBar: _appBar(), body: _body());
  }
}
