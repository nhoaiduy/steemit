import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:steemit/presentation/widget/shimmer/shimmer_widget.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class ActivityWidget {
  static base(
      {required String content,
      required String userName,
      required String imagePath}) {
    return Container(
      width: double.infinity,
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: BaseColor.grey40))),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: RichText(
                      text: TextSpan(
                          text: "You ",
                          style: BaseTextStyle.body1(),
                          children: [
                            TextSpan(
                                text: content, style: BaseTextStyle.body1()),
                            TextSpan(
                                text: "$userName",
                                style: BaseTextStyle.label()),
                            TextSpan(
                                text: "'s posst", style: BaseTextStyle.body1()),
                          ]),
                    )),
                Text("dd/MM/yyyy", style: BaseTextStyle.caption()),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: CachedNetworkImage(
              imageUrl: imagePath,
              height: 48.0,
              width: 48.0,
              placeholder: (context, imageUrl) => ShimmerWidget.base(
                  width: 48.0,
                  height: 48.0,
                  borderRadius: BorderRadius.circular(8.0)),
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
