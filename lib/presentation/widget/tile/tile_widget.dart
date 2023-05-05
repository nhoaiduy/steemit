import 'package:flutter/material.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class TileWidget {
  static cellSmall(
      {bool isFirst = false,
      bool isLast = false,
      double? height,
      required Widget content,
      Color? contentColor,
      Color? backgroundColor,
      Widget? prefix,
      Widget? suffix,
      VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 48.0,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.only(
            topRight: isFirst ? const Radius.circular(12.0) : Radius.zero,
            topLeft: isFirst ? const Radius.circular(12.0) : Radius.zero,
            bottomLeft: isLast ? const Radius.circular(12.0) : Radius.zero,
            bottomRight: isLast ? const Radius.circular(12.0) : Radius.zero,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 16.0,
            ),
            if (prefix != null) prefix,
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                    right: 16.0,
                  ),
                  decoration: BoxDecoration(
                      border: isFirst
                          ? null
                          : const Border(
                              top: BorderSide(
                                  color: BaseColor.grey60, width: 0.7))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [content, if (suffix != null) suffix],
                  )),
            )
          ],
        ),
      ),
    );
  }

  static setting(
      {bool isFirst = false,
      bool isLast = false,
      bool isChosen = false,
      required String content,
      Color? contentColor,
      IconData? prefixIcon,
      double prefixSize = 28.0,
      Color? prefixColor,
      Color? prefixBackgroundColor,
      Color? backgroundColor,
      String? suffixText = "",
      Color? suffixColor,
      bool? isDirect = true,
      VoidCallback? onTap}) {
    return cellSmall(
        height: 48.0,
        isFirst: isFirst,
        isLast: isLast,
        onTap: onTap,
        backgroundColor: isChosen ? BaseColor.blue300 : null,
        content: Text(content,
            overflow: TextOverflow.ellipsis,
            style: BaseTextStyle.label(color: contentColor)),
        contentColor: isChosen ? Colors.white : contentColor,
        prefix: prefixIcon != null
            ? Container(
                width: prefixSize,
                height: prefixSize,
                margin:
                    const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 12.0),
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: prefixBackgroundColor ?? BaseColor.blue500),
                child: Icon(
                  prefixIcon,
                  color: prefixColor ?? Colors.white,
                  size: 16.0,
                ),
              )
            : null,
        suffix: isDirect ?? true
            ? Icon(Icons.chevron_right,
                color:
                    isChosen ? Colors.white : suffixColor ?? BaseColor.blue300)
            : Text(
                suffixText ?? "",
                style: BaseTextStyle.body1(
                    color: isChosen ? Colors.white : BaseColor.blue300),
                overflow: TextOverflow.ellipsis,
              ));
  }

  static pickItem(
      {bool isFirst = false,
      bool isLast = false,
      required String content,
      String? prefix,
      bool isChosen = false,
      VoidCallback? onTap}) {
    return cellSmall(
        height: 44.0,
        onTap: onTap,
        content: Text(content,
            overflow: TextOverflow.ellipsis, style: BaseTextStyle.body1()),
        prefix: prefix != null
            ? Container(
                width: 24.0,
                height: 24.0,
                margin:
                    const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 12.0),
                child: Image.asset(
                  prefix,
                  fit: BoxFit.contain,
                ))
            : null,
        suffix: isChosen
            ? const Icon(
                Icons.check,
                color: BaseColor.blue500,
              )
            : null,
        isLast: isLast,
        isFirst: isFirst);
  }
}
