import 'package:flutter/material.dart';
import 'package:steemit/util/style/base_color.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key}) : super(key: key);

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
                    'https://scontent.fsgn5-6.fna.fbcdn.net/v/t39.30808-1/320607492_1476810126175236_2608549826068351142_n.jpg?stp=dst-jpg_p200x200&_nc_cat=108&ccb=1-7&_nc_sid=7206a8&_nc_ohc=IypSIoiCtt8AX8VXtoG&_nc_ht=scontent.fsgn5-6.fna&oh=00_AfCxkCh7GcXY_KLAVLlL1j3eZKH7q0QRInj8wWjjChQUDA&oe=640EEAB7'
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
              'https://instagram.fsgn5-15.fna.fbcdn.net/v/t51.2885-15/334736292_168461862654791_4445004261921005487_n.jpg?stp=dst-jpg_e35&_nc_ht=instagram.fsgn5-15.fna.fbcdn.net&_nc_cat=111&_nc_ohc=OW8rlAZzfD8AX_4Z_NR&edm=AJ9x6zYBAAAA&ccb=7-5&ig_cache_key=MzA1NDkxOTY1NDUxNDE3ODM0Nw%3D%3D.2-ccb7-5&oh=00_AfBYi09vtwwTY_4cBFZTYX2u1wyghYvjfuCq353PbL9B3A&oe=640FD148&_nc_sid=cff2a4',
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
                  onPressed: () {},
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
                  child: Row(
                      children: [
                        Text(
                          'username',
                          style: TextStyle(color: BaseColor.elements, fontWeight: FontWeight.bold)
                        ),
                        const SizedBox(width: 5,),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Description of post can be replaced. I am making sure this string is long enough to test the overflowed length',
                              style: TextStyle(color: BaseColor.purpleAccent),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                  ),
                ),
                InkWell(
                  onTap: () {},
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

