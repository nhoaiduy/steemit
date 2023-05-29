import 'package:flutter/material.dart';
import 'package:steemit/data/model/post_model.dart';
import 'package:steemit/presentation/page/user/user_profile_page.dart';
import 'package:steemit/presentation/widget/avatar/avatar_widget.dart';
import 'package:steemit/util/helper/string_helper.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class CommentsCard extends StatefulWidget {
  final CommentModel commentModel;

  const CommentsCard({Key? key, required this.commentModel}) : super(key: key);

  @override
  State<CommentsCard> createState() => _CommentsCardState();
}

class _CommentsCardState extends State<CommentsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        UserProfilePage(widget.commentModel.userId!))),
            child: AvatarWidget.base(
                name:
                    "${widget.commentModel.user!.firstName} ${widget.commentModel.user!.lastName}",
                imagePath: widget.commentModel.user!.avatar),
          ),
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
                            text:
                                "${widget.commentModel.user!.firstName} ${widget.commentModel.user!.lastName} ",
                            style: BaseTextStyle.label(color: Colors.black)
                                .copyWith(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: widget.commentModel.content,
                            style:
                                BaseTextStyle.body1(color: BaseColor.grey600)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                        StringHelper.getDifference(DateTime.now().difference(
                            widget.commentModel.createdAt!.toDate())),
                        style: BaseTextStyle.caption(color: BaseColor.grey600)),
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
