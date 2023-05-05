import 'package:flutter/material.dart';
import 'package:steemit/data/model/post_model.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/post/controller/post_controller_cubit.dart';
import 'package:steemit/presentation/bloc/user/data/me/me_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/page/post/comments_page.dart';
import 'package:steemit/presentation/page/user/user_profile_page.dart';
import 'package:steemit/presentation/widget/avatar/avatar_widget.dart';
import 'package:steemit/util/helper/string_helper.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class PostCard extends StatefulWidget {
  final PostModel postModel;

  const PostCard({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isShow = true;
  bool isSaved = false;
  bool isMe = false;
  PostModel postModel = PostModel();

  @override
  void initState() {
    postModel = widget.postModel;
    getIt.get<MeCubit>().getData();
    final state = getIt.get<MeCubit>().state;
    if (state is MeSuccess) {
      final user = state.user;
      if (user.id == postModel.userId) {
        setState(() {
          isMe = true;
        });
      }
      if (user.savedPosts!.contains(postModel.id)) {
        setState(() {
          isSaved = true;
        });
      }
    }
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
                      GestureDetector(
                        onTap: () => isMe
                            ? null
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UserProfilePage(postModel.userId!))),
                        child: Text(
                            "${postModel.user!.firstName} ${postModel.user!.lastName}",
                            style: BaseTextStyle.label()),
                      ),
                      Text(
                        StringHelper.formatDate(
                            postModel.updatedAt!.toDate().toString()),
                        style: BaseTextStyle.caption(),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  onSelected: (value) {},
                  itemBuilder: (BuildContext context) {
                    return [
                      if (!isMe)
                        PopupMenuItem<String>(
                          value: S.current.btn_save_post,
                          child: Text(isSaved
                              ? S.current.btn_saved_post
                              : S.current.btn_save_post),
                          onTap: () async {
                            if (isSaved) {
                              await getIt
                                  .get<PostControllerCubit>()
                                  .unSave(postId: postModel.id!);
                            } else {
                              await getIt
                                  .get<PostControllerCubit>()
                                  .save(postId: postModel.id!);
                            }
                            setState(() {
                              isSaved = !isSaved;
                            });
                          },
                        ),
                      if (isMe)
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
                  onTap: () {},
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
