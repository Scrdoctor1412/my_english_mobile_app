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
            automaticallyImplyLeading: false,
          );
        }

        _body() {
          return ListView(
            children: [
              Container(
                height: screenHeight * 0.55,
                padding: const EdgeInsets.all(12),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(8),
                  dashPattern: [6, 6],
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        controller.onTapShowBottomSheetMedia();
                      },
                      child: Text(
                        '+ Add picture',
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
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {},
          //   child: Icon(Icons.camera_alt),
          // ),
        );
      },
    );
  }
}
