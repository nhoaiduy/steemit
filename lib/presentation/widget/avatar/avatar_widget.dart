import 'package:flutter/material.dart';
import 'package:steemit/util/helper/string_helper.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

const double extraSmallAvatarSize = 20;
const double smallAvatarSize = 24;
const double mediumAvatarSize = 32;
const double largeAvatarSize = 44;
const double extraLargeAvatarSize = 80;

class AvatarWidget {
  static Widget base({
    String? imagePath,
    double? size,
    String name = "",
    bool isBorder = false,
  }) {
    final finalSize = size ?? largeAvatarSize;
    return Container(
        height: finalSize,
        width: finalSize,
        padding: EdgeInsets.all(isBorder ? (finalSize ~/ 30).toDouble() : 0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: isBorder ? Border.all(color: BaseColor.green500) : null),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
                height: finalSize,
                width: finalSize,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: BaseColor.grey40),
                child: Text(StringHelper.createNameKey(name),
                    style: BaseTextStyle.label()
                        .copyWith(fontSize: finalSize / 3))),
            if (imagePath != null)
              Container(
                height: finalSize,
                width: finalSize,
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: BaseColor.grey40)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(finalSize),
                    child: Image.network(imagePath, fit: BoxFit.cover)),
              ),
          ],
        ));
  }
}
