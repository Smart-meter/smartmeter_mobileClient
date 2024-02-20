

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarHelper{

  static void showMessage(String message, BuildContext context){
    /// show error
    ScaffoldMessenger.of(context).clearSnackBars();

    /// showing snack bar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 5),
      ),
    );
  }
}