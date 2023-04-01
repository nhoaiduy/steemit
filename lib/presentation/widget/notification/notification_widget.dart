import 'package:flutter/material.dart';
import 'package:steemit/presentation/widget/avatar/avatar_widget.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class NotificationWidget {
  static base() {
    return Container(
      width: double.infinity,
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: BaseColor.grey40))),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: AvatarWidget.base(name: "Steemit", size: largeAvatarSize),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: RichText(
                      text: TextSpan(
                          text: "steemit",
                          style: BaseTextStyle.label(),
                          children: [
                            TextSpan(
                                text: " do something",
                                style: BaseTextStyle.body1())
                          ]),
                    )),
                Text("dd/MM/yyyy", style: BaseTextStyle.caption()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
