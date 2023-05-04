import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/page/post/post_page.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
import 'package:steemit/presentation/widget/shimmer/shimmer_widget.dart';
import 'package:steemit/util/style/base_color.dart';

class SavedPostPage extends StatefulWidget {
  const SavedPostPage({Key? key}) : super(key: key);

  @override
  State<SavedPostPage> createState() => _SavedPostPageState();
}

class _SavedPostPageState extends State<SavedPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header.background(
            topPadding: MediaQuery.of(context).padding.top,
            content: S.current.lbl_saved_posts,
            prefixIconPath: Icons.chevron_left,
          ),
          _buildPostListArea()
        ],
      ),
    );
  }

  _buildPostListArea() {
    double screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: SingleChildScrollView(
        child: Wrap(
          children: List.generate(100, (index) {
            return GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => PostPage())),
              child: Container(
                width: screenWidth / 3,
                height: screenWidth / 3,
                decoration: BoxDecoration(
                    border: Border.all(color: BaseColor.grey40),
                    color: Colors.transparent),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/330px-Image_created_with_a_mobile_phone.png",
                  fit: BoxFit.cover,
                  placeholder: (context, image) {
                    return ShimmerWidget.base(
                        width: screenWidth / 3, height: screenWidth / 3);
                  },
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
