import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'base_color.dart';

class BaseImage {
  static base(String iconPath, {Color? color, Size? size, BoxFit? boxFit}) {
    Size finalSize = size ?? const Size(24, 24);
    return SvgPicture.asset(
      iconPath,
      color: color ?? BaseColor.grey900,
      height: finalSize.height,
      width: finalSize.width,
      fit: BoxFit.contain,
    );
  }
}
