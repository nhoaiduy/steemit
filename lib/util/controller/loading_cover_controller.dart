import 'package:flutter/material.dart';
import 'package:steemit/util/style/base_color.dart';

class LoadingCoverController {
  static LoadingCoverController? _instance;

  LoadingCoverController._();

  static LoadingCoverController get instance =>
      _instance ??= LoadingCoverController._();

  bool isActive = false;

  void _activate() {
    isActive = true;
  }

  void _inactivate() {
    isActive = false;
  }

  common(BuildContext context) {
    if (isActive) close(context);
    _activate();
    showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return const Dialog(
            elevation: 0,
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            child: Center(
              child: CircularProgressIndicator(
                color: BaseColor.green500,
                strokeWidth: 5,
              ),
            ));
      },
    );
  }

  close(BuildContext context) {
    if (isActive) {
      _inactivate();
      Navigator.pop(context);
    }
  }
}
