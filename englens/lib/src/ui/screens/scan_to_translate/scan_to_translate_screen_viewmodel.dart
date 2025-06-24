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
import 'package:hive_flutter/adapters.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator/translator.dart';

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
    initData();
  }

  void initData() async {
    words = await LocalWordService.getAllWordsFromLocal();
  }

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: ThemePrimary.primaryBlue,
              toolbarWidgetColor: Colors.white,
              aspectRatioPresets: [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                // CropAspectRatioPresetCustom(),
              ],
              lockAspectRatio: false,
            ),
            IOSUiSettings(
              title: 'Cropper',
              aspectRatioPresets: [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                // CropAspectRatioPresetCustom(), // IMPORTANT: iOS supports only one custom aspect ratio in preset list
              ],
              // lockAspectRatio: false,
              aspectRatioLockEnabled: false,
            ),
          ],
        );
        if (croppedFile != null) {
          imageFile = File(croppedFile.path);
          imageBytes = await imageFile!.readAsBytes();
          update();
        }

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
        element.word
            .toLowerCase()
            .trim()
            .replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '') ==
        word.toLowerCase().trim().replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), ''));
    // print(word.toLowerCase().trim().replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), ''));
    print(index);
    // print(words.length);
  }

  Future<String> _onTranslateText(String input) async {
    try {
      final translator = GoogleTranslator();
      var res = await translator.translate(input, from: 'en', to: 'vi');
      if (res != null) {
        return res.text;
      }
      return "";
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  void onTapShowBottomSheetTranslate() async {
    ShowLoadingDialog.showLoadingDialog(
        context: context!, loadingText: "Loading...");

    var a = await _processImage();

    ShowLoadingDialog.hideLoadingDialog(context: context!);

    a = a.replaceAll("\n", " ");

    var translatedText = await _onTranslateText(a);
    if (translatedText == "") {
      Get.back();
    }
    // print(translatedText);

    List<String> listText = a.split(" ");
    List<String> listTranslatedText = translatedText.split(" ");

    if (a != "") {
      await showModalBottomSheet(
        context: context!,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      // width: MediaQuery.of(context).size.width,
                      // color: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        "Translate",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade500,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 12, left: 12, right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 22,
                        ),
                        Text(
                          'Translate Text',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          child: Text(
                            translatedText,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              // wordSpacing: 6,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Text(
                          'Original Text',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          child: RichText(
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
                                            // print(e);
                                            onTapSpecificWord(e);
                                          },
                                      ),
                                    )
                                    .toList(),
                              ],
                            ),
                          ),
                        ),
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
