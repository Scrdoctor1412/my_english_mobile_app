import 'package:flutter/material.dart';
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
  final player = AudioPlayer();
  await player.setUrl(audioUrl);
  player.play();
}

void showCustomAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  required Function() onAccept,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          // height: context.size!.height * 0.3,
          height: 150,
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
