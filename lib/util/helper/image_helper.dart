import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
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
                content: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.file(
                    file,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                contentPadding: EdgeInsets.zero,
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
                padding: const EdgeInsets.all(8.0),
                child: Image.file(
                  file,
                  fit: BoxFit.cover,
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

  static Future<List<File>> pickImage() async {
    final image = await ImagePicker().pickMultiImage();
    return image.map((e) => File(e.path)).toList();
  }

  static Future<File> takePhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.camera);
    return File(photo!.path);
  }
}
