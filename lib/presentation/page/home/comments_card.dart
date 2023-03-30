import 'package:flutter/material.dart';
import 'package:steemit/presentation/widget/avatar/avatar_widget.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class CommentsCard extends StatefulWidget {
  const CommentsCard({Key? key}) : super(key: key);

  @override
  State<CommentsCard> createState() => _CommentsCardState();
}

class _CommentsCardState extends State<CommentsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        children: [
          AvatarWidget.base(name: "steemit_user"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: BaseColor.grey900),
                      children: [
                        TextSpan(
                            text: 'username',
                            style: BaseTextStyle.body2(color: Colors.black)
                                .copyWith(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: ' Original comments for the post',
                            style:
                                BaseTextStyle.body2(color: BaseColor.grey600)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text('23/3/2023',
                        style: BaseTextStyle.body2(color: BaseColor.grey600)),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}