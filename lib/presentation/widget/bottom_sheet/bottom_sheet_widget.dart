import 'package:flutter/material.dart';
import 'package:steemit/util/style/base_color.dart';

const double textButtonPadding = 12.0;

class BottomSheetWidget {
  static show(
      {required BuildContext context,
      required Widget body,
      bool pushPage = false}) {
    if (pushPage) {
      return Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Scaffold(backgroundColor: BaseColor.background, body: body)));
    }
    double pageHeight = MediaQuery.of(context).size.height;
    double overlayHeight = MediaQuery.of(context).padding.top;
    return showModalBottomSheet(
        context: context,
        enableDrag: false,
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
              child: Column(
                children: [
                  Container(
                      width: 40.0,
                      height: 4.0,
                      margin: const EdgeInsets.only(top: 6.0),
                      decoration: BoxDecoration(
                          color: BaseColor.grey100,
                          borderRadius: BorderRadius.circular(100))),
                  Expanded(
                    child: body,
                  ),
                ],
              ));
        });
  }
}
