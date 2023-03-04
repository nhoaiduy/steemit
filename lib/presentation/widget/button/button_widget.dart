import 'package:flutter/material.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class ButtonWidget {
  static Widget base({
    required VoidCallback onTap,
    required String content,
    IconData? prefixIconPath,
    IconData? suffixIconPath,
    double? buttonHeight,
    BoxBorder? border,
    Color? contentColor,
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius,
    bool isExpand = true,
    TextStyle? contentStyle,
  }) {
    if (!(prefixIconPath == null || suffixIconPath == null)) {
      return Container(
        color: Colors.red,
        padding: const EdgeInsets.all(8),
        child: Text(
          "prefixIconPath == null || suffixIconPath == null",
          style: BaseTextStyle.body2(color: Colors.white),
        ),
      );
    }
    final finalHeight = buttonHeight ?? 48;
    Widget button = Container(
        height: finalHeight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: backgroundColor ?? BaseColor.green500,
          borderRadius: borderRadius ?? BorderRadius.circular(10.0),
          border: border,
        ),
        child: Row(
            mainAxisAlignment: (suffixIconPath != null)
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              if (suffixIconPath != null) const SizedBox(width: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIconPath != null)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4, vertical: (finalHeight - 16) / 2),
                      child: Icon(prefixIconPath,
                          color: contentColor ?? Colors.white),
                    ),
                  Text(
                    content,
                    style: contentStyle ??
                        BaseTextStyle.subtitle2(
                            color: contentColor ?? Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (prefixIconPath != null) const SizedBox(width: 24)
                ],
              ),
              if (suffixIconPath != null)
                Padding(
                    padding: EdgeInsets.only(
                        left: 8,
                        top: (finalHeight - 16) / 2,
                        bottom: (finalHeight - 16) / 2),
                    child: Icon(suffixIconPath,
                        color: contentColor ?? Colors.white)),
            ]));
    return GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [if (isExpand) Expanded(child: button) else button],
        ));
  }

  static Widget primary({
    required VoidCallback onTap,
    required String content,
    IconData? prefixIconPath,
    bool isDirection = false,
    bool isDisable = false,
    bool isExpand = true,
  }) {
    if (!(prefixIconPath == null || isDirection == false)) {
      return Container(
        color: Colors.red,
        padding: const EdgeInsets.all(8),
        child: Text(
          "prefixIconPath == null || isDirection == false",
          style: BaseTextStyle.body2(color: Colors.white),
        ),
      );
    }
    return ButtonWidget.base(
        onTap: onTap,
        content: content,
        prefixIconPath: prefixIconPath,
        suffixIconPath: isDirection ? Icons.chevron_right : null,
        contentColor: isDisable ? BaseColor.grey300 : null,
        backgroundColor: isDisable ? BaseColor.grey40 : null,
        isExpand: isExpand);
  }

  static Widget primaryWhite({
    required VoidCallback onTap,
    required String content,
    IconData? prefixIconPath,
    bool isDirection = false,
    bool isDisable = false,
    bool isExpand = true,
  }) {
    if (!(prefixIconPath == null || isDirection == false)) {
      return Container(
        color: Colors.red,
        padding: const EdgeInsets.all(8),
        child: Text(
          "prefixIconPath == null || isDirection == false",
          style: BaseTextStyle.body2(color: Colors.white),
        ),
      );
    }
    return ButtonWidget.base(
        onTap: onTap,
        content: content,
        prefixIconPath: prefixIconPath,
        suffixIconPath: isDirection ? Icons.chevron_right : null,
        contentColor: isDisable ? BaseColor.grey300 : BaseColor.blue300,
        backgroundColor: isDisable ? BaseColor.grey40 : Colors.white,
        borderRadius: isExpand ? BorderRadius.circular(12.0) : null,
        isExpand: isExpand);
  }

  static Widget secondary({
    required VoidCallback onTap,
    required String content,
    IconData? prefixIconPath,
    bool isDirection = false,
    bool isDisable = false,
    bool isExpand = true,
  }) {
    return ButtonWidget.base(
        onTap: onTap,
        content: content,
        prefixIconPath: prefixIconPath,
        suffixIconPath: isDirection ? Icons.chevron_right : null,
        contentColor: isDisable ? BaseColor.grey300 : BaseColor.grey900,
        backgroundColor: isDisable ? BaseColor.grey40 : BaseColor.green300,
        borderRadius: isExpand ? BorderRadius.circular(12.0) : null,
        isExpand: isExpand);
  }

  static Widget tertiary({
    required VoidCallback onTap,
    required String content,
    IconData? prefixIconPath,
    bool isDirection = false,
    bool isDisable = false,
    bool isExpand = true,
  }) {
    return ButtonWidget.base(
        onTap: onTap,
        content: content,
        prefixIconPath: prefixIconPath,
        suffixIconPath: isDirection ? Icons.chevron_right : null,
        contentColor: isDisable ? BaseColor.grey300 : BaseColor.grey900,
        backgroundColor: isDisable ? BaseColor.grey40 : Colors.white,
        borderRadius: isExpand ? BorderRadius.circular(12.0) : null,
        isExpand: isExpand);
  }
}
