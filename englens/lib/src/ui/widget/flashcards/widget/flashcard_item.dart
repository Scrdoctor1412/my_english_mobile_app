import 'dart:async';

import 'package:englens/src/core/theme/theme_primary.dart';
import 'package:englens/src/core/utils/helper.dart';
import 'package:flutter/material.dart';

class FlashcardItem extends StatefulWidget {
  final String word;
  final String pos;
  final String? imgUrl;
  final String definition;
  final String? audioUrl;
  final Function() onTapCorrect;
  final Function() onTapIncorrect;
  final bool isVolumeOn;
  final bool? isFront;

  const FlashcardItem({
    Key? key,
    required this.word,
    required this.pos,
    this.imgUrl = '',
    required this.definition,
    required this.onTapCorrect,
    required this.onTapIncorrect,
    required this.isVolumeOn,
    this.audioUrl,
    this.isFront = true,
  }) : super(key: key);

  @override
  _FlashcardItemState createState() => _FlashcardItemState();
}

class _FlashcardItemState extends State<FlashcardItem>
    with SingleTickerProviderStateMixin {
  late AnimationController animController;
  late Animation<double> animation;
  late bool isFront;

  late Timer _timer;
  int _start = 3;
  bool isTimerCancel = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    animation = Tween<double>(begin: 0, end: 1).animate(animController);
    widget.isVolumeOn ? onTapPlayAudio(audioUrl: widget.audioUrl!) : null;
    isFront = widget.isFront!;
    startTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void toggleCard() {
    setState(() {
      if (isFront) {
        animController.forward();
      } else {
        animController.reverse();
      }
      if (mounted) {
        setState(() {
          _timer.cancel();
          _start = -1;
          isTimerCancel = true;
        });
      }
      isFront = !isFront;
    });
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_start <= 0) {
        setState(() {
          timer.cancel();
          isTimerCancel = true;
        });
        toggleCard();
      } else {
        if (mounted) {
          setState(() {
            _start--;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    Widget flashcardFront() {
      return Container(
        height: screenHeight * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(30),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    color: ThemePrimary.successGreen,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(26),
                      bottomRight: Radius.circular(26),
                    ),
                  ),
                ),
                const Spacer(),
                //word display
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    // controller.wordList[index].word,
                    widget.word,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),
                //word pos
                Container(
                  decoration: BoxDecoration(
                    color: ThemePrimary.primaryBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                  child: Text(
                    // controller.wordList[index].pos,
                    widget.pos,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                //reveal definition button
                const Spacer(),

                Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    color: ThemePrimary.successGreen,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Tap to see the definition',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 50,
              right: 0,
              left: 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: InkWell(
                  onTap: () {
                    if (widget.audioUrl != null) {
                      onTapPlayAudio(audioUrl: widget.audioUrl!);
                    }
                  },
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: ThemePrimary.successGreen,
                        width: 6.5,
                      ),
                    ),
                    child: Icon(
                      Icons.volume_up_rounded,
                      color: ThemePrimary.successGreen,
                    ),
                  ),
                ),
              ),
            ),
            _start < 0 && isTimerCancel
                ? SizedBox()
                : Positioned(
                    bottom: 60,
                    right: 0,
                    left: 0,
                    child: SizedBox(
                      height: 65,
                      width: 65,
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0.0, end: 1.0),
                                duration: Duration(seconds: 3),
                                builder: (context, value, _) {
                                  return CircularProgressIndicator(
                                    strokeWidth: 8,
                                    value: value,
                                    color: ThemePrimary.successGreen,
                                    backgroundColor: ThemePrimary.lightGreen,
                                  );
                                },
                              ),
                            ),
                          ),
                          Center(child: Text('$_start')),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      );
    }

    Widget flashcardBack() {
      return Container(
        height: screenHeight * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(30),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.imgUrl == '' || widget.imgUrl == null
                ? Container()
                : ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.network(widget.imgUrl!),
                  ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                // controller.wordList[index].senses[0].definition,
                widget.definition,
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 6),
            Container(
              height: 35,
              decoration: BoxDecoration(
                color: ThemePrimary.successGreen,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(50),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(-2, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(left: 12, right: 20),
              child: Icon(Icons.keyboard_return, color: Colors.white),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 75,
              decoration: BoxDecoration(
                // color: ThemePrimary.successGreen,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // controller.onTapIncorrect();
                        widget.onTapIncorrect();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(child: Divider(color: Colors.red)),
                                  Container(
                                    width: 39,
                                    height: 39,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    // padding: const EdgeInsets.all(12),
                                    alignment: Alignment.center,
                                    child: Icon(Icons.close, color: Colors.red),
                                  ),
                                  Expanded(child: Divider(color: Colors.red)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Incorrect',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // controller.onTapCorrect();
                        widget.onTapCorrect();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: ThemePrimary.successGreen,
                                    ),
                                  ),
                                  Container(
                                    width: 39,
                                    height: 39,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: ThemePrimary.successGreen,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    // padding: const EdgeInsets.all(12),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.check,
                                      color: ThemePrimary.successGreen,
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: ThemePrimary.successGreen,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Correct',
                            style: TextStyle(
                              color: ThemePrimary.successGreen,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      child: Center(
        child: GestureDetector(
          onTap: toggleCard,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Transform(
                transform: Matrix4.rotationY(animation.value * 3.14139),
                alignment: Alignment.center,
                child: animation.value < 0.5
                    ? flashcardFront()
                    : Transform.scale(
                        scaleX: -1,
                        scaleY: 1,
                        child: flashcardBack(),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}
