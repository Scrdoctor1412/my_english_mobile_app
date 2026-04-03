import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/core/theme/theme_primary.dart';
import 'package:flutter/material.dart';

class ShowLoadingDialog extends GetViewModelBase {
  static void showLoadingDialog({
    required BuildContext context,
    required String loadingText,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 13, horizontal: 12),
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.circular(12),
                  // boxShadow: [BoxShadow()],
                ),
                child: Column(
                  children: [
                    Center(child: CircularProgressIndicator()),
                    const SizedBox(height: 12),
                    Text(
                      '$loadingText...',
                      style: TextStyle(
                        color: ThemePrimary.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void hideLoadingDialog({required BuildContext context}) {
    Navigator.of(context).pop();
  }
}
