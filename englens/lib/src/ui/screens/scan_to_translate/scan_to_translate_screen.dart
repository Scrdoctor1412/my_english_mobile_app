import 'package:dotted_border/dotted_border.dart';
import 'package:englens/src/ui/screens/scan_to_translate/scan_to_translate_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanToTranslateScreen extends StatelessWidget {
  static const routeName = '/scanToTranslateScreen';
  const ScanToTranslateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScanToTranslateScreenViewmodel>(
      init: ScanToTranslateScreenViewmodel(),
      builder: (controller) {
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

        _body() {
          return Stack(
            children: [
              Container(
                height: screenHeight,
                width: screenWdith,
                padding: const EdgeInsets.all(12),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(8),
                  dashPattern: [6, 6],
                  child: SizedBox(),
                ),
              ),
              Center(
                child: InkWell(
                  onTap: () async {
                    controller.onTapShowBottomSheetMedia();
                  },
                  child: SizedBox(
                    width: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt),
                        const SizedBox(width: 8),
                        Text(
                          'Add picture',
                        ),
                      ],
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
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {},
          //   child: Icon(Icons.camera_alt),
          // ),
        );
      },
    );
  }
}
