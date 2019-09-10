import 'package:flutter/material.dart';

class Modal {
  static void showInSnackBar(
      GlobalKey<ScaffoldState> scaffoldKey, String text) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(text)));
  }

  static void showAlert(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
        );
      },
    );
  }
}
