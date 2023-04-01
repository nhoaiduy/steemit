import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:steemit/util/style/base_color.dart';

class AttachFileWidget {
  static base() {
    return DottedBorder(
        color: BaseColor.grey60,
        radius: const Radius.circular(4.0),
        dashPattern: const [10, 10],
        padding: EdgeInsets.zero,
        child: Container(
            height: 104,
            width: 140,
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Icon(Icons.add)));
  }
}
