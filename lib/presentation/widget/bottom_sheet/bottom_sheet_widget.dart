import 'dart:math';

import 'package:flutter/material.dart';
import 'package:steemit/presentation/widget/button/button_widget.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

const double textButtonPadding = 12.0;

class BottomSheetWidget {
  static base({required BuildContext context, required Widget body}) {
    final pageHeight = MediaQuery.of(context).size.height;
    final overHeight = MediaQuery.of(context).padding.top;
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return Container(
              width: double.infinity,
              height: pageHeight - overHeight - 32.0,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        16.0,
                      ),
                      topRight: Radius.circular(16.0))),
              child: body);
        });
  }

  static title(
      {required BuildContext context,
      required String title,
      VoidCallback? onRollback,
      String? rollbackContent,
      VoidCallback? onSubmit,
      double horizontalPadding = 16.0,
      String? submitContent}) {
    return Container(
      height: 56,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: BaseColor.grey200)),
      ),
      padding: EdgeInsets.all(
          horizontalPadding - min(horizontalPadding, textButtonPadding)),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              rollbackContent != null
                  ? ButtonWidget.text(
                      onTap: onRollback ?? () => Navigator.pop(context),
                      content: rollbackContent,
                      context: context)
                  : const Center(),
              if (submitContent != null)
                ButtonWidget.text(
                    onTap: onSubmit ?? () {},
                    content: submitContent,
                    context: context)
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: BaseTextStyle.label(),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
