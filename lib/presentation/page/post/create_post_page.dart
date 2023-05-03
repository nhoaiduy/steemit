import 'package:flutter/material.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/post/controller/post_controller_cubit.dart';
import 'package:steemit/presentation/bloc/post/data/posts/posts_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/widget/attach_image/attach_file.dart';
import 'package:steemit/presentation/widget/textfield/textfield_widget.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController contentController = TextEditingController();
  final List<String> images = List.empty(growable: true);

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
        Navigator.pop(context);
        getIt.get<PostsCubit>().getPosts();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
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
                child: Text(S.current.lbl_photo, style: BaseTextStyle.label())),
            AttachFileWidget.base()
          ],
        ),
      ),
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

  void post() => getIt
      .get<PostControllerCubit>()
      .create(content: contentController.text, images: images);
}
