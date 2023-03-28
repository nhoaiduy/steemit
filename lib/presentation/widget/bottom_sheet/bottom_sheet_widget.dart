import 'dart:math';

import 'package:flutter/material.dart';
import 'package:steemit/presentation/widget/button/button_widget.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

const double textButtonPadding = 12.0;

class BottomSheetWidget {
  static base({required BuildContext context, required Widget body}) {
    double pageHeight = MediaQuery.of(context).size.height;
    double overlayHeight = MediaQuery.of(context).padding.top;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) {
          return Container(
              height: pageHeight - overlayHeight - 32,
              decoration: const BoxDecoration(
                  color: BaseColor.background,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        16.0,
                      ),
                      topRight: Radius.circular(16.0))),
              child: Stack(
                children: [
                  body,
                ],
              ));
        });
  }

  static title(
      {required BuildContext context,
      required String title,
      VoidCallback? onPrefix,
      String? prefixContent,
      VoidCallback? onSuffix,
      double horizontalPadding = 16.0,
      String? suffixContent}) {
    return Container(
      decoration: const BoxDecoration(
          color: BaseColor.background,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                16.0,
              ),
              topRight: Radius.circular(16.0))),
      height: 56,
      padding: EdgeInsets.symmetric(
          horizontal:
              horizontalPadding - min(horizontalPadding, textButtonPadding)),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              prefixContent != null
                  ? ButtonWidget.text(
                      onTap: onPrefix ?? () => Navigator.pop(context),
                      content: prefixContent,
                      context: context)
                  : const SizedBox.shrink(),
              if (suffixContent != null)
                ButtonWidget.text(
                    onTap: onSuffix ?? () {},
                    content: suffixContent,
                    context: context)
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: textButtonPadding),
              child: Text(
                title,
                style: BaseTextStyle.label(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
