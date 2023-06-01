import 'package:flutter/material.dart';
import 'package:steemit/data/model/notification_model.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/widget/avatar/avatar_widget.dart';
import 'package:steemit/util/enum/activity_enum.dart';
import 'package:steemit/util/helper/string_helper.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class NotificationWidget {
  static base(NotificationModel notificationModel, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: BaseColor.grey40))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: AvatarWidget.base(
                  imagePath: notificationModel.user?.avatar,
                  name:
                      "${notificationModel.user!.firstName} ${notificationModel.user!.lastName}",
                  size: largeAvatarSize),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: RichText(
                        text: TextSpan(
                            text:
                                "${notificationModel.user!.firstName} ${notificationModel.user!.lastName} ",
                            style: BaseTextStyle.label(),
                            children: [
                              TextSpan(
                                  text:
                                      "${notificationModel.type == ActivityEnum.like ? S.current.txt_liked : "${S.current.txt_commented} ${S.current.txt_in}"} ${S.current.txt_your_post}",
                                  style: BaseTextStyle.body1())
                            ]),
                      )),
                  Text(
                      StringHelper.formatDate(
                          notificationModel.createdAt!.toDate().toString()),
                      style: BaseTextStyle.caption()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
