import 'package:flutter/material.dart';

class CommonSnackBar {
  static void show(
    BuildContext context, {
    required String text,
    required Color backGroundColor,
    required int durationSeconds,
  }) {
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: backGroundColor,
      duration: Duration(seconds: durationSeconds),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
