import 'package:flutter/material.dart';
import 'package:steemit/data/model/post_model.dart';
import 'package:steemit/presentation/page/post/view_video_page.dart';
import 'package:steemit/presentation/widget/shimmer/shimmer_widget.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  final MediaModel media;
  final VoidCallback? download;

  const VideoCard({Key? key, required this.media, required this.download})
      : super(key: key);

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  VideoPlayerController? controller;

  @override
  void initState() {
    controller = VideoPlayerController.network(widget.media.url!)
      ..initialize().then((value) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewVideoPage(
                      controller: controller!,
                      download: widget.download,
                    )));
      },
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: controller!.value.isInitialized
            ? Stack(
                children: [
                  VideoPlayer(controller!),
                  const Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.play_circle_outline,
                      color: Colors.white,
                      size: 64,
                    ),
                  ),
                ],
              )
            : ShimmerWidget.base(width: double.infinity, height: 250),
      ),
    );
  }
}
