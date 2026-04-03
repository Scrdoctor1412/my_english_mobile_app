import 'package:dotted_border/dotted_border.dart';
import 'package:englens/src/ui/screens/scan_to_translate/scan_to_translate_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanToTranslateScreen extends GetView<ScanToTranslateScreenViewmodel> {
  static const routeName = '/scanToTranslateScreen';
  const ScanToTranslateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    var screenWdith = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    _appBar() {
      return AppBar(
        title: Text('Translate'),
        centerTitle: true,
        // automaticallyImplyLeading: false,
      );
    }

    _customSearchBar() {
      return CustomSearchBar();
    }

    _pictureDisplay() {
      return controller.imageBytes != null
          ? Container(
              // height: 220,
              decoration: BoxDecoration(color: Colors.white),
              height: screenHeight * 0.55,
              width: screenWdith,
              child: Image.memory(controller.imageBytes!),
            )
          : DottedBorder(
              padding: EdgeInsets.symmetric(vertical: 100),
              dashPattern: [8, 8],
              radius: Radius.circular(32),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 220,
                      child: Image.asset(
                        'assets/images/scan_translate/picture_holder_2.png',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text('Add picture to start translate'),
                    const SizedBox(height: 26),
                    ElevatedButton(
                      onPressed: () {
                        controller.onTapShowBottomSheetMedia();
                      },
                      child: Text('Add picture'),
                    ),
                  ],
                ),
              ),
            );
    }

    _body() {
      return SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: screenHeight,
          child: Column(
            children: [
              // _customSearchBar(),
              const SizedBox(height: 22),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _pictureDisplay(),
              ),
              // const SizedBox(
              //   height: 26,
              // ),
              // const Spacer(),
              if (controller.imageBytes != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 190,
                        child: ElevatedButton(
                          onPressed: () {
                            // controller.onTapShowBottomSheetMedia();
                            controller.onTapShowBottomSheetTranslate();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.translate),
                              const SizedBox(width: 8),
                              Text(
                                'Scan Image',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 190,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.onTapShowBottomSheetMedia();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt),
                              const SizedBox(width: 8),
                              Text(
                                "Take picture",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.camera_alt),
      // ),
    );
  }
}
