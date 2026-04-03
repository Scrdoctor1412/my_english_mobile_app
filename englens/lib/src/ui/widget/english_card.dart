import 'package:auto_size_text/auto_size_text.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/core/utils/helper.dart';
import 'package:flutter/material.dart';

enum Classifier { verb, noun, adjective, adverb, indefiniteArticle }

class EnglishCard extends StatelessWidget {
  // String
  final Word word;
  EnglishCard({Key? key, required this.word}) : super(key: key);

  var statusColor = Colors.orange;

  void switchStatusColor() {
    switch (word.pos) {
      case "noun":
        statusColor = Colors.orange;
        break;
      case "verb":
        statusColor = Colors.red;
        break;
      case "adjective":
        statusColor = Colors.amber;
        break;
      case "adverb":
        statusColor = Colors.green;
        break;
      case "indefinite article":
        statusColor = Colors.pink;
        break;
      default:
        statusColor = Colors.indigo;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    //change status color
    switchStatusColor();
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      // height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: AutoSizeText(
                  word.word,
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                  maxLines: 2,
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Center(
                  child: Text(
                    word.pos,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              // IconButton(
              //   onPressed: () {
              //     onTapPlayAudio(audioUrl: word.phonetic);
              //   },
              //   icon: Icon(Icons.volume_up_rounded),
              // ),
              InkWell(
                onTap: () {
                  onTapPlayAudio(audioUrl: word.phonetic);
                },
                child: Icon(Icons.volume_up_rounded),
              ),
              const SizedBox(width: 12),
              // Text('/ə/'),
              word.phoneticText != ""
                  ? Text(word.phoneticText)
                  : Text('/$word.pronunciation!/'),
              if (word.phoneticAmText != "") ...[
                IconButton(
                  onPressed: () {
                    onTapPlayAudio(audioUrl: word.phonetic);
                  },
                  icon: Icon(Icons.volume_up_rounded),
                ),
                // Text('/ə/'),
                Text(word.phoneticAmText),
              ],
            ],
          ),
          Expanded(
            child: AutoSizeText(
              // 'used to show that somebody/something is a member of a group or profession',
              word.senses[0].definition,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
