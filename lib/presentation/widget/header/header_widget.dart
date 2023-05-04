import 'package:flutter/material.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

const double headerHeight = 56.0;

class Header {
  static background(
      {required String content,
      VoidCallback? onPrefix,
      VoidCallback? onSuffix,
      VoidCallback? onSecondSuffix,
      String? prefixContent,
      String? suffixContent,
      IconData? prefixIconPath,
      IconData? suffixIconPath,
      IconData? secondSuffixIconPath,
      double? horizontalPadding,
      double? topPadding}) {
    return BaseHeader(
        content: content,
        onPrefix: onPrefix,
        onSuffix: onSuffix,
        onSecondSuffix: onSecondSuffix,
        prefixContent: prefixContent,
        suffixContent: suffixContent,
        prefixIconPath: prefixIconPath,
        suffixIconPath: suffixIconPath,
        secondSuffixIconPath: secondSuffixIconPath,
        horizontalPadding: horizontalPadding,
        topPadding: topPadding,
        backgroundColor: BaseColor.background);
  }
}

class BaseHeader extends StatelessWidget {
  const BaseHeader(
      {Key? key,
      required this.content,
      this.onPrefix,
      this.onSuffix,
      this.onSecondSuffix,
      this.prefixContent,
      this.suffixContent,
      this.prefixIconPath,
      this.suffixIconPath,
      this.secondSuffixIconPath,
      this.horizontalPadding,
      this.topPadding,
      this.backgroundColor = Colors.white})
      : assert(prefixContent == null || prefixIconPath == null),
        assert(suffixContent == null ||
            (suffixIconPath == null && secondSuffixIconPath == null)),
        super(key: key);

  final String content;
  final VoidCallback? onPrefix;
  final VoidCallback? onSuffix;
  final VoidCallback? onSecondSuffix;
  final String? prefixContent;
  final String? suffixContent;
  final IconData? prefixIconPath;
  final IconData? suffixIconPath;
  final IconData? secondSuffixIconPath;
  final double? horizontalPadding;
  final double? topPadding;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    double? finalHorizontalPadding = horizontalPadding ?? 16.0;
    return Container(
      height: headerHeight + (topPadding ?? 0),
      padding: EdgeInsets.only(
        top: topPadding ?? 0,
      ),
      decoration: BoxDecoration(
          color: backgroundColor,
          border: const Border(
              bottom: BorderSide(color: BaseColor.grey100, width: 0.5))),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildPreFixActions(context, finalHorizontalPadding),
              buildSufFixActions(context, finalHorizontalPadding),
            ],
          ),
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: finalHorizontalPadding + 56),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                content,
                style: BaseTextStyle.subtitle2(),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPreFixActions(
      BuildContext context, double finalHorizontalPadding) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (prefixContent != null)
          _button(
              onPrefix,
              context,
              Text(prefixContent!,
                  overflow: TextOverflow.ellipsis,
                  style: BaseTextStyle.body1()),
              finalHorizontalPadding),
        if (prefixIconPath != null)
          _button(
              onPrefix,
              context,
              Icon(
                prefixIconPath!,
                size: 32,
              ),
              finalHorizontalPadding),
      ],
    );
  }

  Widget buildSufFixActions(
      BuildContext context, double finalHorizontalPadding) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (onSecondSuffix != null && secondSuffixIconPath != null)
          _button(onSecondSuffix, context, Icon(secondSuffixIconPath!), 8),
        if (onSuffix != null && suffixContent != null)
          _button(
              onSuffix,
              context,
              Text(suffixContent!,
                  overflow: TextOverflow.ellipsis,
                  style: BaseTextStyle.body1()),
              finalHorizontalPadding),
        if (onSuffix != null && suffixIconPath != null)
          _button(
              onSuffix, context, Icon(suffixIconPath!), finalHorizontalPadding),
      ],
    );
  }

  Widget _button(VoidCallback? onTap, BuildContext context, Widget content,
      double horizontalPadding) {
    return GestureDetector(
        onTap: onTap ?? () => Navigator.pop(context),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            height: headerHeight,
            alignment: Alignment.center,
            child: content));
  }
}
