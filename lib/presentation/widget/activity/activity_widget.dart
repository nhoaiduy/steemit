import 'package:flutter/material.dart';
import 'package:steemit/data/model/activity_model.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/util/helper/string_helper.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class ActivityWidget {
  static base({required ActivityModel activityModel, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: BaseColor.grey40))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: RichText(
                  text: TextSpan(
                      text:
                          "${S.current.txt_you} ${S.current.txt_just} ${StringHelper.getActivityString(activityModel.type!)} ${S.current.txt_post_of} ",
                      style: BaseTextStyle.body1(),
                      children: [
                        TextSpan(
                            text:
                                "${activityModel.user!.firstName} ${activityModel.user!.lastName}",
                            style: BaseTextStyle.label()),
                      ]),
                )),
            Text(
                StringHelper.formatDate(
                    activityModel.createdAt!.toDate().toString()),
                style: BaseTextStyle.caption()),
          ],
        ),
      ),
    );
  }
}
