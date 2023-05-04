import 'package:flutter/material.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class SnackBarWidget {
  static show({required BuildContext context, required SnackBar snackBar}) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static _base({required String content, Color? backgroundColor}) {
    return SnackBar(
        backgroundColor: backgroundColor ?? BaseColor.blue500,
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        content: Text(
          content,
          style: BaseTextStyle.body1(color: Colors.white),
        ));
  }

  static success({required String content}) {
    return _base(content: content, backgroundColor: BaseColor.green500);
  }

  static danger({required String content}) {
    return _base(content: content, backgroundColor: BaseColor.red500);
  }

  static info({required String content}) {
    return _base(content: content);
  }

  static warning({required String content}) {
    return _base(content: content, backgroundColor: BaseColor.yellow500);
  }
}
