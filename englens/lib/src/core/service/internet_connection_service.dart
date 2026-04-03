import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternetConnectionService {
  static InternetConnectionService? _instance;

  Connectivity connectivity = Connectivity();
  StreamSubscription? connectivityStream;

  bool _isDialogShown = false;

  factory InternetConnectionService.instance() {
    _instance ??= InternetConnectionService._();
    if (_instance == null) {
      _instance = InternetConnectionService._();
    }
    return _instance!;
  }

  InternetConnectionService._() {
    // isConnected().then((result) {
    //   print('result: $result');
    //   if (result == false) _showNotConnectedDialog();
    // });
    // connectivityStream = connectivity.onConnectivityChanged.listen((result) {
    //   if (result != ConnectivityResult.mobile &&
    //       result != ConnectivityResult.wifi &&
    //       result != ConnectivityResult.ethernet &&
    //       result != ConnectivityResult.vpn) {
    //     if (!_isDialogShown) {
    //       _showNotConnectedDialog();
    //     }
    //   } else {
    //     if (_isDialogShown) {
    //       __closeDialog();
    //     }
    //   }
    // });
  }

  //methods
  onDispose() {
    connectivityStream?.cancel();
  }

  Future<bool> isConnected() async {
    var connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      // I am connected to a wifi network.
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      // I am connected to a wifi network.
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      // 4G
      return true;
    }
    // _showNotConnectedDialog();
    return false;
  }

  _showNotConnectedDialog() {
    if (!_isDialogShown && Get.context != null) {
      _isDialogShown = true;
      Get.dialog(
        AlertDialog(
          title: Text('INTERNET_CONNECTION_DIALOG.ALERT_DIALOG'.tr),
          content: Text('INTERNET_CONNECTION_DIALOG.NO_INTERNET'.tr),
          actions: [
            TextButton(
              onPressed: () {
                AppSettings.openAppSettingsPanel(AppSettingsPanelType.wifi);
              },
              child: Text('INTERNET_CONNECTION_DIALOG.OPEN_WIFI_SETTING'.tr),
            ),
            TextButton(
              onPressed: () {
                AppSettings.openAppSettings(type: AppSettingsType.dataRoaming);
              },
              child: Text(
                'INTERNET_CONNECTION_DIALOG.OPEN_MOBILE_NETWORK_SETTING'.tr,
              ),
            ),
          ],
        ),
      ).then((value) {
        debugPrint('NO INTERNET DIALOG CLOSED');
        _isDialogShown = false;
      });
    }
  }

  __closeDialog() {
    if (_isDialogShown) {
      _isDialogShown = false;
      Navigator.pop(Get.context!);
    }
  }
}
