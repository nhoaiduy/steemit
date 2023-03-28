import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:steemit/util/style/base_color.dart';

class ShimmerWidget {
  static base(
      {required double width,
      required double height,
      BoxShape? shape,
      BorderRadius? borderRadius}) {
    return Shimmer.fromColors(
      baseColor: BaseColor.grey40,
      highlightColor: BaseColor.grey20,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: shape ?? BoxShape.rectangle,
            borderRadius: borderRadius),
      ),
    );
  }
}
