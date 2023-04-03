import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/page/post/post_page.dart';
import 'package:steemit/presentation/widget/shimmer/shimmer_widget.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class SavedPostPage extends StatefulWidget {
  const SavedPostPage({Key? key}) : super(key: key);

  @override
  State<SavedPostPage> createState() => _SavedPostPageState();
}

class _SavedPostPageState extends State<SavedPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _buildPostListArea(),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: BaseColor.background,
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left,
            color: BaseColor.grey900,
            size: 36,
          )),
      title: Text(
        S.current.lbl_saved_posts,
        style: BaseTextStyle.subtitle1(),
      ),
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 1.0),
        child: Container(
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: BaseColor.grey60))),
        ),
      ),
    );
  }

  _buildPostListArea() {
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
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
    );
  }
}
