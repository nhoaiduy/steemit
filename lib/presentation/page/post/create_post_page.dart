import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/post/controller/post_controller_cubit.dart';
import 'package:steemit/presentation/bloc/post/data/posts/posts_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/widget/textfield/textfield_widget.dart';
import 'package:steemit/util/helper/Image_helper.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController contentController = TextEditingController();
  final List<File> images = List.empty(growable: true);

  @override
  void initState() {
    getIt.get<PostControllerCubit>().stream.listen((event) {
      if (!mounted) return;
      if (event is PostControllerFailure) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: BaseColor.red500,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            content: Text(
              event.message,
              style: BaseTextStyle.body1(color: Colors.white),
            )));
      }
      if (event is PostControllerSuccess) {
        getIt.get<PostsCubit>().getPosts();
        Navigator.pop(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(), body: _buildBody());
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
        S.current.lbl_new_post,
        style: BaseTextStyle.subtitle1(),
      ),
      elevation: 0,
      actions: [
        GestureDetector(
          onTap: () => post(),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            color: Colors.transparent,
            child: Text(
              S.current.btn_post,
              style: BaseTextStyle.subtitle2(color: BaseColor.blue300),
            ),
          ),
        )
      ],
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 1.0),
        child: Container(
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: BaseColor.grey60))),
        ),
      ),
    );
  }

  Widget _buildBody() {
    const double horizontalMargin = 16;
    const double minCardSize = 80;
    double contentWidth = min(MediaQuery.of(context).size.width, 700);
    int count = contentWidth ~/ minCardSize;
    double cardSize = (contentWidth - horizontalMargin) / count;
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldWidget.common(
                  onChanged: (text) {},
                  hintText: S.current.txt_post_hint,
                  textEditingController: contentController,
                  labelText: S.current.lbl_content),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 20.0),
                  child:
                      Text(S.current.lbl_photo, style: BaseTextStyle.label())),
              images.isNotEmpty
                  ? Wrap(
                      runSpacing: 16.0,
                      spacing: 16.0,
                      children: images
                          .map((e) => ImageHelper.imageCard(
                              context: context,
                              file: e,
                              cardSize: cardSize,
                              horizontalMargin: horizontalMargin,
                              remove: () {
                                setState(() {
                                  images.remove(e);
                                });
                              }))
                          .toList(),
                    )
                  : Container(
                      width: double.infinity,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        "There is no image",
                        style: BaseTextStyle.body1(),
                      ),
                    )
            ],
          ),
        ),
        Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => takePhoto(),
                  child: Container(
                    width: 48,
                    height: 48,
                    margin: const EdgeInsets.only(left: 16.0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: BaseColor.green500),
                    child: const Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => pickPhoto(),
                  child: Container(
                    width: 48,
                    height: 48,
                    margin: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: BaseColor.green500),
                    child: const Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }

  void takePhoto() async {
    final response = await ImageHelper.takePhoto();
    setState(() {
      images.add(response);
    });
  }

  void pickPhoto() async {
    final response = await ImageHelper.pickImage();
    for (var i in response) {
      if (!images.contains(i)) {
        setState(() {
          images.add(i);
        });
      }
    }
  }

  void unFocus() => FocusScope.of(context).unfocus();

  void post() => getIt
      .get<PostControllerCubit>()
      .create(content: contentController.text, images: images);
}
