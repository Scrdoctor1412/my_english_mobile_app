import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/theme/theme_primary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

enum MediaType { camera, gallery }

class ScanToTranslateScreenViewmodel extends GetViewModelBase {
  final ImagePicker _picker = ImagePicker();

  List<IconData> icons = [
    Icons.camera_alt,
    Icons.image,
  ];
  List<String> bottomOptions = [
    'Camera',
    'Gallery',
  ];

  List<XFile>? _mediaFileList;

  void _setImageFileListFromFile(XFile? value) {
    _mediaFileList = value == null ? null : <XFile>[value];
  }

  void onTapShowBottomSheetMedia() async {
    var res = await showModalBottomSheet(
      context: context!,
      builder: (context) {
        return SafeArea(
          top: false,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 120,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    var res = index == 0 ? MediaType.camera : MediaType.gallery;
                    Get.back(result: res);
                  },
                  child: ListTile(
                    leading: Icon(
                      icons[index],
                      color: ThemePrimary.grey,
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
              itemCount: icons.length,
            ),
          ),
        );
      },
    );
  }
}
