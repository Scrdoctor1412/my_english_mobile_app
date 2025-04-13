import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/home/word_search/word_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      height: 65,
      child: Hero(
        tag: "search_text_field",
        child: Material(
          color: Colors.transparent,
          child: TextField(
            onTap: () {
              Get.toNamed(WordSearchScreen.routeName);
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
              suffixIcon: Icon(
                Icons.search,
                color: ThemePrimary.grey,
              ),
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
}
