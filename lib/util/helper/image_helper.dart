import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:steemit/presentation/page/post/view_video_page.dart';
import 'package:steemit/util/constant/media_type_format.dart';
import 'package:steemit/util/enum/media_enum.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:video_player/video_player.dart';

class MediaHelper {
  static Widget imageCard(
      {required File file,
      required BuildContext context,
      required VoidCallback remove,
      double? cardSize,
      double? horizontalMargin}) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                contentPadding: EdgeInsets.zero,
                insetPadding: EdgeInsets.zero,
                shadowColor: Colors.black,
                content: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.file(
                    file,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              );
            });
      },
      child: SizedBox(
          width: cardSize,
          height: cardSize,
          child: Stack(
            children: [
              Container(
                width: cardSize,
                height: cardSize,
                margin: const EdgeInsets.only(right: 8.0, top: 8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: BaseColor.green500)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.file(
                    file,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: remove,
                  child: Container(
                    width: 16.0,
                    height: 16.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey.shade50),
                    child: const Icon(
                      Icons.clear,
                      size: 16.0,
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  static checkType(XFile file) {
    final path = file.path.substring(file.path.lastIndexOf(".") + 1);
    if (MediaTypeFormat.videoFormats.contains(path)) return MediaEnum.video;
    return MediaEnum.image;
  }

  static Widget videoCard(
      {required File file,
      required BuildContext context,
      required VoidCallback remove,
      double? cardSize,
      double? horizontalMargin}) {
    VideoPlayerController controller = VideoPlayerController.file(file)
      ..initialize();
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ViewVideoPage(
                    controller: controller,
                  ))),
      child: SizedBox(
          width: cardSize,
          height: cardSize,
          child: Stack(
            children: [
              Container(
                  width: cardSize,
                  height: cardSize,
                  margin: const EdgeInsets.only(right: 8.0, top: 8.0),
                  decoration: BoxDecoration(
                      color: BaseColor.grey40,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: BaseColor.green500)),
                  child: Stack(
                    children: [
                      if (controller.value.isInitialized)
                        ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: VideoPlayer(controller)),
                      const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.play_circle_outline,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: remove,
                  child: Container(
                    width: 16.0,
                    height: 16.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey.shade50),
                    child: const Icon(
                      Icons.clear,
                      size: 16.0,
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  static Future<List<XFile?>> pickMedia(
      [MediaEnum type = MediaEnum.image]) async {
    if (type == MediaEnum.image) {
      return await ImagePicker().pickMultiImage();
    }
    return [(await ImagePicker().pickVideo(source: ImageSource.gallery))];
  }

  static Future<XFile?> takeMedia([MediaEnum type = MediaEnum.image]) async {
    if (type == MediaEnum.image) {
      return (await ImagePicker().pickImage(source: ImageSource.camera));
    }
    return (await ImagePicker().pickVideo(source: ImageSource.camera));
  }
}
