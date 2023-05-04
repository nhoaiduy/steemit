import 'package:flutter/material.dart';
import 'package:steemit/data/model/post_model.dart';
import 'package:steemit/data/service/storage_service.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/page/post/comments_page.dart';
import 'package:steemit/presentation/widget/avatar/avatar_widget.dart';
import 'package:steemit/util/helper/string_helper.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class PostCard extends StatefulWidget {
  final PostModel postModel;
  final snap;

  const PostCard({Key? key, required this.postModel, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isShow = true;

  PostModel postModel = PostModel();

  @override
  void initState() {
    postModel = widget.postModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 3, color: BaseColor.grey60))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: AvatarWidget.base(
                          name:
                              "${postModel.user!.firstName} ${postModel.user!.lastName}",
                          size: mediumAvatarSize),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${postModel.user!.firstName} ${postModel.user!.lastName}",
                              style: BaseTextStyle.label()),
                          Text(
                            StringHelper.formatDate(
                                postModel.updatedAt!.toDate().toString()),
                            style: BaseTextStyle.caption(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {},
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        value: S.current.btn_save_post,
                        child: Text(S.current.btn_save_post),
                      ),
                      PopupMenuItem<String>(
                        value: S.current.btn_delete,
                        child: Text(S.current.btn_delete),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          if (postModel.content != null)
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isShow = !isShow;
                    });
                  },
                  child: RichText(
                    softWrap: true,
                    overflow:
                        isShow ? TextOverflow.ellipsis : TextOverflow.visible,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: postModel.content,
                          style: BaseTextStyle.body2(),
                        )
                      ],
                    ),
                  ),
                )),
          // Image
          if (postModel.images!.isNotEmpty)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              child: Image.network(
                postModel.images!.first,
                fit: BoxFit.cover,
              ),
            ),
          //   SizedBox(
          //     height: MediaQuery.of(context).size.height * 0.5,
          //     child: ListView.builder(
          //         shrinkWrap: true,
          //         scrollDirection: Axis.horizontal,
          //         itemCount: postModel.images!.length,
          //         itemBuilder: (context, index) {
          //           return SizedBox(
          //             height: MediaQuery.of(context).size.height * 0.5,
          //             width: double.infinity,
          //             child: Image.network(
          //               postModel.images!.first,
          //               fit: BoxFit.cover,
          //             ),
          //           );
          //         }),
          //   ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (postModel.likes!.isNotEmpty)
                    ? Text(
                        '${postModel.likes!.length} ${postModel.likes!.length > 1 ? S.current.txt_likes : S.current.txt_like}',
                        style: BaseTextStyle.body2(),
                        overflow: TextOverflow.fade,
                      )
                    : const SizedBox.shrink(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CommentsPage()));
                  },
                  child: Text(
                    '${postModel.comments!.length} ${postModel.comments!.length > 1 ? S.current.txt_comments : S.current.txt_comment}',
                    style: BaseTextStyle.body2(),
                  ),
                ),
              ],
            ),
          ),
          // Actions
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(width: 0.8, color: BaseColor.grey60))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () async{
                    await StorageService().likePost(
                        widget.snap['id'],
                        widget.snap['userId'],
                        widget.snap['likes']
                    );
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(width: 5),
                      Text(S.current.btn_like),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CommentsPage()));
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.comment_outlined,
                      ),
                      const SizedBox(width: 5),
                      Text(S.current.btn_comment),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
