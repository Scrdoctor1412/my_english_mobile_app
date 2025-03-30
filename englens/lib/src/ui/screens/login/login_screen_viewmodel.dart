import 'package:englens/src/core/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreenViewmodel extends GetViewModelBase {
  final formKey = GlobalKey<FormState>();

  onLogin() {
    if (formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(content: Text('Processing Data')),
      );
    }
  }
}
