import 'dart:io';
import 'dart:typed_data';

import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/service/local_word_service.dart';
import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/widget/loading_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

enum MediaType { camera, gallery }

class ScanToTranslateScreenViewmodel extends GetViewModelBase {
  final ImagePicker _picker = ImagePicker();
  Uint8List? imageBytes;
  File? imageFile;
  List<Word> words = [];

  List<IconData> icons = [
    Icons.camera_alt,
    Icons.image,
  ];
  List<String> bottomOptions = [
    'Take pictures with Camera',
    'Choose image from Gallery',
  ];

  @override
  void onInit() {
    super.onInit();
    words = LocalWordService.getAllWordsFromLocal();
  }

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imageFile = File(image.path);
        imageBytes = await image.readAsBytes();
        update();
        // _processImage();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _captureImage() async {
    try {
      var images = await CunningDocumentScanner.getPictures(
        isGalleryImportAllowed: true,
        noOfPages: 1,
      );
      if (images != null && images.length > 0) {
        imageFile = File(images.first);
        imageBytes = await imageFile!.readAsBytes();
        update();
        // _processImage();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> _processImage() async {
    try {
      final inputImage = InputImage.fromFilePath(imageFile!.path);
      final textRec = TextRecognizer();
      final RecognizedText recognizedText =
          await textRec.processImage(inputImage);
      String extractText = recognizedText.text;
      print(extractText);
      return extractText;
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  void onTapSpecificWord(String word) {
    var index = words.indexWhere((element) =>
        element.word.toLowerCase().trim() == word.toLowerCase().trim());
    print(index);
  }

  void onTapShowBottomSheetTranslate() async {
    ShowLoadingDialog.showLoadingDialog(
        context: context!, loadingText: "Loading...");

    var a = await _processImage();

    ShowLoadingDialog.hideLoadingDialog(context: context!);

    a = a.replaceAll("\n", " ");

    List<String> listText = a.split(" ");

    if (a != "") {
      await showModalBottomSheet(
        context: context!,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Extracted Text",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        wordSpacing: 6,
                      ),
                      children: [
                        ...listText
                            .map(
                              (e) => TextSpan(
                                text: "$e ",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print(e);
                                    onTapSpecificWord(e);
                                  },
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  void onTapShowBottomSheetMedia() async {
    var res = await showModalBottomSheet(
      context: context!,
      builder: (context) {
        return SafeArea(
          top: false,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    var res = index == 0 ? MediaType.camera : MediaType.gallery;
                    Get.back(result: res);
                  },
                  child: ListTile(
                    leading: Icon(
                      icons[index],
                      color: ThemePrimary.grey.withAlpha(150),
                    ),
                    title: Text(
                      bottomOptions[index],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                color: ThemePrimary.grey.withAlpha(150),
              ),
              itemCount: icons.length,
            ),
          ),
        );
      },
    );
    // print(res);
    switch (res) {
      case MediaType.camera:
        _captureImage();
        break;
      case MediaType.gallery:
        pickImageFromGallery();
        break;
    }
  }
}
