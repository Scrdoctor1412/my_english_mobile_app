import 'package:englens/src/data/models/word.dart';
import 'package:flutter/material.dart';

enum Classifier { verb, noun, adjective, adverb, indefiniteArticle }

class EnglishCard extends StatelessWidget {
  // String
  WordEntry word;
  EnglishCard({Key? key, required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        // vertical: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                word.word,
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.redAccent,
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
              )
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.volume_up_rounded),
              ),
              // Text('/ə/'),
              Text(word.phoneticText),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.volume_up_rounded),
              ),
              // Text('/ə/'),
              Text(word.phoneticAmText),
            ],
          ),
          Text(
            // 'used to show that somebody/something is a member of a group or profession',
            word.senses[0].definition,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
