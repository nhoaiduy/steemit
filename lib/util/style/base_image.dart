import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'base_color.dart';

class BaseImage {
  static base(String iconPath,
      {Color? color, double? height, double? width, BoxFit? boxFit}) {
    return SvgPicture.asset(
      iconPath,
      color: color ?? BaseColor.grey900,
      height: height ?? 24.0,
      width: width ?? 24.0,
      fit: BoxFit.contain,
    );
  }
}
