import 'package:englens/src/data/models/user_word_list.dart';
import 'package:englens/src/data/repositories/user_words_repository.dart';
import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/widget/loading_dialog.dart';
import 'package:englens/src/ui/widget/my_wordlists/add_word_list_bottom_sheet/add_word_list_bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

String snakeCaseToNormal(String input) {
  return input
      .split('_') // Tách chuỗi bằng dấu gạch dưới
      .map(
        (word) => word[0].toUpperCase() + word.substring(1),
      ) // Viết hoa chữ cái đầu mỗi từ
      .join(' '); // Ghép lại các từ bằng dấu cách
}

void onTapPlayAudio({String audioUrl = ''}) async {
  try {
    final player = AudioPlayer();
    await player.setUrl(audioUrl);
    player.play();
  } catch (e) {
    debugPrint(e.toString());
  }
}

Future<void> showCustomAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  required Function() onAccept,
}) async {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          // height: context.size!.height * 0.3,
          height: 160,
          padding: const EdgeInsets.only(top: 12, left: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Text(content),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      // controller.signout();
                      onAccept();
                    },
                    child: Text('Ok'),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

Future<void> showCustomAlertDialog2({
  required BuildContext context,
  required String bodyContent,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Alert",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              Text(
                bodyContent,
                style: TextStyle(
                  color: ThemePrimary.primaryBlue,
                ),
              ),
              const SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Agree",
                      style: TextStyle(
                        color: ThemePrimary.lightBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

final _formKey = GlobalKey<FormState>();
final TextEditingController _wordListNameTxtController =
    TextEditingController();

Future<String> showGetTextInputDialog({required BuildContext context}) async {
  String res = "";
  var name = await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Enter name",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _wordListNameTxtController,
                  decoration: InputDecoration(
                    hintText: "Enter word list name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter word list name';
                    }
                    return null;
                  },
                ),
                // const SizedBox(height: 50),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context)
                              .pop(_wordListNameTxtController.text);
                          _wordListNameTxtController.text = "";
                        }
                      },
                      child: Text("Accept"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
  if (name != null) {
    res = name;
  }
  return res;
}

Future<dynamic> onTapShowUsersWordListBottomSheet(
    {required BuildContext context}) async {
  ShowLoadingDialog.showLoadingDialog(
      context: context, loadingText: "Loading...");

  ShowLoadingDialog.hideLoadingDialog(context: context);
  var id = await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return AddWordListBottomSheet();
    },
  );

  return id;
}

Future<String> loadAssets(String assetLink) async {
  final data = await rootBundle.loadString(assetLink);
  return data;
}
