import 'package:flutter/material.dart';
import 'package:steemit/util/path/image_path.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_image.dart';

class AppLoadingPage extends StatelessWidget {
  const AppLoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.green500,
      body: Center(
        child: BaseImage.base(ImagePath.appIcon, color: Colors.white),
      ),
    );
  }
}
