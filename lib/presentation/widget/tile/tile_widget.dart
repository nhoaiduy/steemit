import 'package:flutter/material.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class TileWidget {
  static cellSmall(
      {double? height,
      required String content,
      TextStyle? contentStyle,
      Color? contentColor,
      Color? backgroundColor,
      IconData? prefix,
      Color? prefixColor,
      Widget? suffix,
      VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 48.0,
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.circular(12.0)),
        child: Row(
          children: [
            const SizedBox(
              width: 16.0,
            ),
            if (prefix != null)
              Container(
                  padding: const EdgeInsets.all(4.0),
                  margin: const EdgeInsets.only(right: 8.0),
                  decoration: BoxDecoration(
                      color: prefixColor ?? BaseColor.yellow500,
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Icon(
                    prefix,
                    color: Colors.white,
                  )),
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                    right: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(content,
                          overflow: TextOverflow.ellipsis,
                          style: contentStyle ??
                              BaseTextStyle.label(color: contentColor)),
                      if (suffix != null) suffix
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
