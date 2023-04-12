import 'package:flutter/material.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/widget/avatar/avatar_widget.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

import '../../page/post/comments_page.dart';

class PostCard extends StatefulWidget {
  const PostCard({Key? key}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 3, color: BaseColor.grey60))),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                AvatarWidget.base(name: "steemit_user", size: mediumAvatarSize),
                Expanded(
                  child: Column(
                    children: [
                      Text('username', style: BaseTextStyle.label()),
                      Text(
                        '10/3/2023',
                        style: BaseTextStyle.caption(),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: ListView(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shrinkWrap: true,
                                children: [
                                  S.current.btn_delete,
                                ]
                                    .map((e) => InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 16),
                                            child: Text(e),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ));
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isShow = !isShow;
                  });
                },
                child: RichText(
                  softWrap: true,
                  overflow: isShow
                      ? TextOverflow.ellipsis
                      : TextOverflow.visible,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                        'Description of post can be replaced. post can be replaced. I am making sure this string is long enough to test the overflowed length',
                        style: BaseTextStyle.body2(),
                      )
                    ],
                  ),
                ),
              )),
          // Image
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            child: Image.network(
              'https://antimatter.vn/wp-content/uploads/2022/04/buon-anh-meo-khoc-cute.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '243 likes',
                  style: BaseTextStyle.body2(),
                  overflow: TextOverflow.fade,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CommentsPage()));
                  },
                  child: Container(
                    child: Text(
                      '${S.current.txt_view_all} 200 ${S.current.txt_comments}',
                      style: BaseTextStyle.body2(),
                    ),
                  ),
                ),

              ],
            ),
          ),
          // Actions
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(width: 0.8, color: BaseColor.grey60))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () { },
                  child: Row(
                    children: const [
                      Icon(Icons.favorite, color: Colors.redAccent,),
                      SizedBox(width: 5),
                      Text('Like'),
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
                    children: const [
                      Icon(Icons.comment_outlined,),
                      SizedBox(width: 5),
                      Text('Comment'),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () { },
                  child: Row(
                    children: const [
                      Icon(Icons.send,),
                      SizedBox(width: 5),
                      Text('Share'),
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
