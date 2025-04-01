import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/home/word_search/word_search_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WordSearchScreen extends StatelessWidget {
  static const routeName = '/wordSearhScreen';
  const WordSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordSearchScreenViewmodel>(
      builder: (controller) {
        controller.context = context;
        var screenWidth = MediaQuery.of(context).size.width;
        var screenHeight = MediaQuery.of(context).size.height;

        _appBar() {
          return AppBar(
            title: Text('Search'),
          );
        }

        _body() {
          return Column(
            children: [
              Container(
                width: screenWidth,
                height: 65,
                child: Hero(
                  tag: "search_text_field",
                  child: Material(
                    color: Colors.transparent,
                    child: TextField(
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
              ),
            ],
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
