import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:focused_menu_custom/focused_menu.dart';
import 'package:focused_menu_custom/modals.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/post/controller/post_controller_cubit.dart';
import 'package:steemit/presentation/bloc/post/data/posts/posts_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
import 'package:steemit/presentation/widget/snackbar/snackbar_widget.dart';
import 'package:steemit/presentation/widget/textfield/textfield_widget.dart';
import 'package:steemit/util/controller/loading_cover_controller.dart';
import 'package:steemit/util/enum/media_enum.dart';
import 'package:steemit/util/helper/image_helper.dart';
import 'package:steemit/util/helper/permission_helper.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController contentController = TextEditingController();
  final List<XFile> medias = List.empty(growable: true);
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
            if (medias.isNotEmpty)
              Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 20.0),
                  child:
                      Text(S.current.lbl_media, style: BaseTextStyle.label())),
            if (medias.isNotEmpty)
              Wrap(
                runSpacing: 12.0,
                spacing: 12.0,
                children: medias.map((e) {
                  if (MediaHelper.checkType(e) == MediaEnum.image) {
                    return MediaHelper.imageCard(
                        context: context,
                        file: File(e.path),
                        cardSize: cardSize,
                        horizontalMargin: horizontalMargin,
                        remove: () {
                          setState(() {
                            medias.remove(e);
                          });
                        });
                  }
                  return MediaHelper.videoCard(
                      context: context,
                      file: File(e.path),
                      cardSize: cardSize,
                      horizontalMargin: horizontalMargin,
                      remove: () {
                        setState(() {
                          medias.remove(e);
                        });
                      });
                }).toList(),
              )
          ],
        ),
      ),
    );
  }

  Widget _buttonArea() {
    return Align(
        alignment: Alignment.bottomRight,
        child: Row(
          children: [
            focusButton(
                Container(
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
                true),
            focusButton(
                Container(
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
                false),
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

  Widget focusButton(Widget child, bool isCamera) {
    final double areaWidth = MediaQuery.of(context).size.width * 0.6;
    return FocusedMenuHolder(
        menuWidth: areaWidth,
        blurSize: 1.0,
        borderColor: Colors.transparent,
        menuItemExtent: 64,
        menuBoxDecoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8.0)),
        duration: const Duration(milliseconds: 100),
        animateMenuItems: false,
        blurBackgroundColor: BaseColor.grey900,
        openWithTap: true,
        menuOffset: 16.0,
        menuItems: <FocusedMenuItem>[
          FocusedMenuItem(
              title: Container(
                width: areaWidth - 32,
                height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Row(
                  children: [
                    const Icon(
                      Icons.image,
                      color: BaseColor.green500,
                    ),
                    const SizedBox(width: 12),
                    Text(S.current.btn_photo,
                        style: BaseTextStyle.label(),
                        overflow: TextOverflow.ellipsis)
                  ],
                ),
              ),
              onPressed: () => isCamera ? takePhoto() : pickPhoto(),
              backgroundColor: Colors.transparent),
          FocusedMenuItem(
              title: Container(
                width: areaWidth - 28,
                height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Row(
                  children: [
                    const Icon(
                      Icons.videocam,
                      color: BaseColor.green500,
                    ),
                    const SizedBox(width: 12),
                    Text(S.current.btn_video,
                        style: BaseTextStyle.label(),
                        overflow: TextOverflow.ellipsis)
                  ],
                ),
              ),
              onPressed: () => isCamera ? takeVideo() : pickVideo(),
              backgroundColor: Colors.transparent),
        ],
        onPressed: () {},
        child: child);
  }

  void takePhoto() async {
    final response = await MediaHelper.takeMedia();
    if (response != null) {
      setState(() {
        medias.add(response);
      });
    }
  }

  void pickPhoto() async {
    final response = await MediaHelper.pickMedia();
    for (var i in response) {
      if (i == null) continue;
      if (!medias.contains(i)) {
        setState(() {
          medias.add(i);
        });
      }
    }
  }

  void takeVideo() async {
    final response = await MediaHelper.takeMedia(MediaEnum.video);
    if (response != null) {
      setState(() {
        medias.add(response);
      });
    }
  }

  void pickVideo() async {
    final response = await MediaHelper.pickMedia(MediaEnum.video);
    for (var i in response) {
      if (i == null) continue;
      if (!medias.contains(i)) {
        setState(() {
          medias.add(i);
        });
      }
    }
  }

  void getLocation() async {
    final hasLocationPermission =
        await PermissionHelper.getLocationPermission();
    if (hasLocationPermission) {
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
        images: medias,
        context: context,
        location: location);
  }
}
