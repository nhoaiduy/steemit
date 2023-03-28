import 'package:flutter/material.dart';
import 'package:steemit/presentation/page/home/post_card.dart';
import 'package:steemit/util/style/base_color.dart';

import '../../../../util/path/image_path.dart';
import '../../../../util/style/base_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BaseColor.green500,
        elevation: 0.0,
        title: BaseImage.base(
          ImagePath.appIcon,
          color: Colors.white,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.messenger_outline)
          )],
      ),
      body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            const PostCard(),
            const PostCard()
          ]
      ),
    );
  }
}
