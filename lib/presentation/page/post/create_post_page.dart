import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/post/controller/post_controller_cubit.dart';
import 'package:steemit/presentation/bloc/post/data/posts/posts_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
import 'package:steemit/presentation/widget/snackbar/snackbar_widget.dart';
import 'package:steemit/presentation/widget/textfield/textfield_widget.dart';
import 'package:steemit/util/controller/loading_cover_controller.dart';
import 'package:steemit/util/helper/image_helper.dart';
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
  String? location;

  @override
  void initState() {
    getIt.get<PostControllerCubit>().stream.listen((event) {
      if (!mounted) return;
      if (event is PostControllerFailure) {
        SnackBarWidget.show(
            context: context,
            snackBar: SnackBarWidget.danger(content: event.message));
      }
      if (event is PostControllerSuccess) {
        getIt.get<PostsCubit>().clean();
        getIt.get<PostsCubit>().getPosts();
        Navigator.pop(context);
      }
      LoadingCoverController.instance.close(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            Header.background(
                topPadding: MediaQuery.of(context).padding.top,
                content: S.current.lbl_new_post,
                prefixIconPath: Icons.chevron_left,
                suffixContent: S.current.btn_post,
                onSuffix: () => post()),
            _buildBody(),
          ],
        ),
        _buttonArea()
      ],
    ));
  }

  Widget _buildBody() {
    const double horizontalMargin = 16;
    const double minCardSize = 80;
    double contentWidth = min(MediaQuery.of(context).size.width, 700);
    int count = contentWidth ~/ minCardSize;
    double cardSize = (contentWidth - horizontalMargin) / count;
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (location != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() {
                        location = null;
                      }),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: BaseColor.green500)),
                        child: Row(
                          children: [
                            Text(
                              location!,
                              style: BaseTextStyle.body2(
                                  color: BaseColor.green500),
                            ),
                            const Icon(
                              Icons.close,
                              size: 18,
                              color: BaseColor.green500,
                            )
                          ],
                        ),
                      ),
                    ),
                    const Spacer()
                  ],
                ),
              ),
            TextFieldWidget.common(
                onChanged: (text) {},
                hintText: S.current.txt_post_hint,
                textEditingController: contentController,
                labelText: S.current.lbl_content),
            Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 20.0),
                child: Text(S.current.lbl_photo, style: BaseTextStyle.label())),
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
                      S.current.txt_no_image,
                      style: BaseTextStyle.body1(),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget _buttonArea() {
    return Align(
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
            GestureDetector(
              onTap: () => getLocation(),
              child: Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: BaseColor.green500),
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ));
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

  void getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever ||
        permission == LocationPermission.unableToDetermine) {
      permission = await Geolocator.requestPermission();
    }

    if (permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever &&
        permission != LocationPermission.unableToDetermine) {
      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      setState(() {
        location = placeMarks.first.administrativeArea;
      });
    }
  }

  void unFocus() => FocusScope.of(context).unfocus();

  void post() {
    unFocus();
    getIt.get<PostControllerCubit>().create(
        content: contentController.text,
        images: images,
        context: context,
        location: location);
  }
}
