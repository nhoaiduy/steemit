import 'dart:io';

import 'package:flutter/material.dart';
import 'package:steemit/presentation/page/post/view_video_page.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:video_player/video_player.dart';

class PickVideoWidget extends StatefulWidget {
  final File file;
  final VoidCallback remove;
  final double? cardSize;
  final double? horizontalMargin;

  const PickVideoWidget(
      {Key? key,
      required this.file,
      required this.remove,
      this.cardSize,
      this.horizontalMargin})
      : super(key: key);

  @override
  State<PickVideoWidget> createState() => _PickVideoWidgetState();
}

class _PickVideoWidgetState extends State<PickVideoWidget> {
  VideoPlayerController? controller;

  @override
  void initState() {
    controller = VideoPlayerController.file(widget.file)
      ..initialize().then((value) => setState(() {}));
    controller!.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PickVideoWidget oldWidget) {
    controller = VideoPlayerController.file(widget.file)
      ..initialize().then((value) => setState(() {}));
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ViewVideoPage(
                    controller: controller!,
                  ))),
      child: SizedBox(
          width: widget.cardSize,
          height: widget.cardSize,
          child: Stack(
            children: [
              Container(
                  width: widget.cardSize,
                  height: widget.cardSize,
                  margin: const EdgeInsets.only(right: 8.0, top: 8.0),
                  decoration: BoxDecoration(
                      color: BaseColor.grey40,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: BaseColor.green500)),
                  child: Stack(
                    children: [
                      if (controller!.value.isInitialized)
                        ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: VideoPlayer(controller!)),
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
                  onTap: widget.remove,
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
}
