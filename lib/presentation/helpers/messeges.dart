import 'package:flutter/material.dart';

void showMessage(String message, BuildContext context, {bool error = false}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: !error ? Colors.green[200] : Colors.red,
  ));
}
