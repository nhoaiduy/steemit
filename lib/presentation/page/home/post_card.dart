import 'package:flutter/material.dart';
import 'package:steemit/util/style/base_color.dart';

import 'comments_page.dart';

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
      color: BaseColor.green500,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16).copyWith(right: 0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    'https://nationaltoday.com/wp-content/uploads/2020/08/international-cat-day-640x514.jpg'
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'username',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shrinkWrap: true,
                          children: [
                            'Delete',
                          ].map((e) => InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              child: Text(e),
                            ),
                          )).toList(),
                        ),
                      )
                    );
                  },
                  color: Colors.white,
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
          // Image
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            child: Image.network(
              'https://antimatter.vn/wp-content/uploads/2022/04/buon-anh-meo-khoc-cute.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Actions
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.redAccent,
                )
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CommentsPage()));
                  },
                  icon: const Icon(
                    Icons.comment_outlined,
                    color: Colors.white,
                  )
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  )
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.bookmark_border),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          // Likes and comments
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '243 likes',
                  style: TextStyle(color: BaseColor.elements, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.fade,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 4),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isShow = !isShow;
                      });
                    },
                    child: RichText(
                      softWrap: true,
                      overflow: isShow ? TextOverflow.ellipsis : TextOverflow.visible,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'username',
                            style: TextStyle(color: BaseColor.elements, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ' Description of post can be replaced. post can be replaced. I am making sure this string is long enough to test the overflowed length',
                            style: TextStyle(color: BaseColor.purpleAccent),
                          )
                        ],
                      ),
                    ),
                  )
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CommentsPage()));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: const Text(
                      'View all 200 comments',
                      style: TextStyle(color: BaseColor.purpleAccent),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: const Text(
                    '10/3/2023',
                    style: TextStyle(color: BaseColor.purpleAccent),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

