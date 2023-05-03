// import 'package:flutter/material.dart';
// import 'package:steemit/data/model/post_model.dart';
// import 'package:steemit/generated/l10n.dart';
// import 'package:steemit/presentation/widget/avatar/avatar_widget.dart';
// import 'package:steemit/util/style/base_color.dart';
// import 'package:steemit/util/style/base_text_style.dart';
//
// import '../../page/post/comments_page.dart';
//
// class PostCard extends StatefulWidget {
//   final PostModel postModel;
//
//   const PostCard({Key? key, required this.postModel}) : super(key: key);
//
//   @override
//   State<PostCard> createState() => _PostCardState();
// }
//
// class _PostCardState extends State<PostCard> {
//   bool isShow = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: const BoxDecoration(
//           border:
//               Border(bottom: BorderSide(width: 3, color: BaseColor.grey60))),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
//                 .copyWith(right: 0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       margin: EdgeInsets.only(top: 10),
//                       child: AvatarWidget.base(
//                           name:
//                               "${widget.postModel.user!.firstName} ${widget.postModel.user!.lastName}",
//                           size: mediumAvatarSize),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(left: 10, top: 10),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                               "${widget.postModel.user!.firstName} ${widget.postModel.user!.lastName}",
//                               style: BaseTextStyle.label()),
//                           Text(
//                             "${widget.postModel.updatedAt!.toDate()}",
//                             style: BaseTextStyle.caption(),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 PopupMenuButton<String>(
//                   onSelected: (value) {},
//                   itemBuilder: (BuildContext context) {
//                     return const [
//                       PopupMenuItem<String>(
//                         value: "Edit",
//                         child: Text("Edit Post"),
//                       ),
//                       PopupMenuItem<String>(
//                         value: "Save",
//                         child: Text("Save post"),
//                       ),
//                       PopupMenuItem<String>(
//                         value: "Delete",
//                         child: Text("Delete"),
//                       ),
//                     ];
//                   },
//                 ),
//               ],
//             ),
//           ),
//           if (widget.postModel.content != null)
//             Container(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       isShow = !isShow;
//                     });
//                   },
//                   child: RichText(
//                     softWrap: true,
//                     overflow:
//                         isShow ? TextOverflow.ellipsis : TextOverflow.visible,
//                     text: TextSpan(
//                       children: [
//                         TextSpan(
//                           text: widget.postModel.content,
//                           style: BaseTextStyle.body2(),
//                         )
//                       ],
//                     ),
//                   ),
//                 )),
//           // if (widget.postModel.images!.isNotEmpty)
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.5,
//             width: double.infinity,
//             child: Image.network(
//               widget.postModel.images!.first,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 if (widget.postModel.likes!.isNotEmpty)
//                   Text(
//                     '${widget.postModel.likes!.length} likes',
//                     style: BaseTextStyle.body2(),
//                     overflow: TextOverflow.fade,
//                   ),
//                 InkWell(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const CommentsPage()));
//                     },
//                     child: widget.postModel.comments!.isNotEmpty
//                         ? Text(
//                             '${S.current.txt_view_all} ${widget.postModel.comments!.length} ${S.current.txt_comments}',
//                             style: BaseTextStyle.body2(),
//                           )
//                         : null),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
//             decoration: const BoxDecoration(
//                 border: Border(
//                     top: BorderSide(width: 0.8, color: BaseColor.grey60))),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 GestureDetector(
//                   onTap: () {},
//                   child: Row(
//                     children: const [
//                       Icon(
//                         Icons.favorite,
//                         color: Colors.redAccent,
//                       ),
//                       SizedBox(width: 5),
//                       Text('Like'),
//                     ],
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const CommentsPage()));
//                   },
//                   child: Row(
//                     children: const [
//                       Icon(
//                         Icons.comment_outlined,
//                       ),
//                       SizedBox(width: 5),
//                       Text('Comment'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:steemit/data/model/post_model.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/widget/avatar/avatar_widget.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

///import đầy đủ chứ đừng có ... z nha
import '../../page/post/comments_page.dart';

class PostCard extends StatefulWidget {
  final PostModel postModel;

  const PostCard({Key? key, required this.postModel}) : super(key: key);

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: AvatarWidget.base(
                          name: "steemit_user", size: mediumAvatarSize),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('username', style: BaseTextStyle.label()),
                          Text(
                            '10/3/2023',
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
                    return const [
                      PopupMenuItem<String>(
                        value: "Edit",
                        child: Text("Edit Post"),
                      ),
                      PopupMenuItem<String>(
                        value: "Save",
                        child: Text("Save post"),
                      ),
                      PopupMenuItem<String>(
                        value: "Delete",
                        child: Text("Delete"),
                      ),
                    ];
                  },
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
                  overflow:
                      isShow ? TextOverflow.ellipsis : TextOverflow.visible,
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
                border: Border(
                    top: BorderSide(width: 0.8, color: BaseColor.grey60))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: const [
                      Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                      ),
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
                      Icon(
                        Icons.comment_outlined,
                      ),
                      SizedBox(width: 5),
                      Text('Comment'),
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
