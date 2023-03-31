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
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: BaseImage.base(
          ImagePath.appIcon,
        ),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 1.0),
          child: Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: BaseColor.grey60))),
          ),
        ),
      ),
      body: ListView(children: List.generate(10, (index) => const PostCard())),
    );
  }
}
