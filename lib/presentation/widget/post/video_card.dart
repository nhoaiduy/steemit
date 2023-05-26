import 'package:flutter/material.dart';
import 'package:steemit/data/service/storage_service.dart';
import 'package:steemit/presentation/page/post/view_video_page.dart';
import 'package:steemit/presentation/widget/shimmer/shimmer_widget.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  final String url;
  final String name;

  const VideoCard({Key? key, required this.url, required this.name})
      : super(key: key);

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  VideoPlayerController? controller;

  @override
  void initState() {
    controller = VideoPlayerController.network(widget.url)
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
      onLongPress: () async {
        await storageService.downloadFile(widget.url, widget.name);
      },
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewVideoPage(
                      controller: controller!,
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
