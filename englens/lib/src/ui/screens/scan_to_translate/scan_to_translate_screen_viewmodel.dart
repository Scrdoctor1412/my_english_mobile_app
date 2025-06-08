import 'dart:io';
import 'dart:typed_data';

import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/theme/theme_primary.dart';
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

  List<IconData> icons = [
    Icons.camera_alt,
    Icons.image,
  ];
  List<String> bottomOptions = [
    'Take pictures with Camera',
    'Choose image from Gallery',
  ];

  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile = File(image.path);
      _processImage();
    }
  }

  void _captureImage() async {
    var images = await CunningDocumentScanner.getPictures(
      isGalleryImportAllowed: true,
      noOfPages: 1,
    );
    if (images != null && images.length > 0) {
      imageFile = File(images.first);
      _processImage();
    }
  }

  Future<void> _processImage() async {
    final inputImage = InputImage.fromFilePath(imageFile!.path);
    final textRec = TextRecognizer();
    final RecognizedText recognizedText =
        await textRec.processImage(inputImage);
    String extractText = recognizedText.text;
    print(extractText);
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
