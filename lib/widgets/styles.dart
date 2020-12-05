import 'package:flutter/material.dart';

Widget snackSample(var text) {
  return SnackBar(
    content: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textAlign: TextAlign.center,
    ),
    duration: Duration(milliseconds: 300),
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.floating,
    elevation: 10.0,
  );
}
