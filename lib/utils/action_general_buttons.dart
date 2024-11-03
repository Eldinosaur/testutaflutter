import 'package:flutter/material.dart';

class ActionButtonGeneral{

    static Widget buttonActionPais(String title, Function function, TextStyle textStyle) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
        textStyle: textStyle
        ),
        onPressed: () {
          function();
        },
        child: Text(title),
      );
    }


     
  static SnackBar showSnackBar(String msg, String action) {
    return SnackBar(
      content: Text(msg),
     );
  }
}