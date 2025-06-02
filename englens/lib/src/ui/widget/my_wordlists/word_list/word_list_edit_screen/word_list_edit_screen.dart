import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/widget/my_wordlists/word_list/word_list_edit_screen/word_list_edit_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WordListEditScreen extends StatelessWidget {
  static const routeName = "/wordListEditScreen";
  const WordListEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordListEditScreenViewmodel>(
      init: WordListEditScreenViewmodel(),
      builder: (controller) {
        _appBar() {
          return AppBar(
            title: Text("Edit"),
          );
        }

        _textFormFieldItem(
            {required String labelText,
            required String hintText,
            required TextEditingController controller}) {
          return TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: ThemePrimary.grey),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: labelText,
              hintText: hintText,
            ),
          );
        }

        _body() {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Column(
              spacing: 16,
              children: [
                _textFormFieldItem(
                  labelText: "Word",
                  hintText: "enter word name",
                  controller: controller.wordController,
                ),
                // _textFormFieldItem(),
                // _textFormFieldItem(),
              ],
            ),
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
