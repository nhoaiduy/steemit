import 'package:flutter/material.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:video_player/video_player.dart';

class ViewVideoPage extends StatefulWidget {
  final VideoPlayerController controller;
  final VoidCallback? download;

  const ViewVideoPage({Key? key, required this.controller, this.download})
      : super(key: key);

  @override
  State<ViewVideoPage> createState() => _ViewVideoPageState();
}

class _ViewVideoPageState extends State<ViewVideoPage> {
  @override
  void initState() {
    widget.controller.play();
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: widget.controller.value.isInitialized
              ? GestureDetector(
                  onLongPress: widget.download,
                  onTap: () {
                    if (widget.controller.value.isPlaying) {
                      widget.controller.pause();
                    } else {
                      widget.controller.play();
                    }
                    setState(() {});
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        VideoPlayer(widget.controller),
                        if (!widget.controller.value.isPlaying)
                          const Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.play_circle_outline,
                              color: Colors.white,
                              size: 64,
                            ),
                          ),
                      ],
                    ),
                  ),
                )
              : const CircularProgressIndicator(
                  color: BaseColor.green500,
                ),
        ),
      ),
    );
  }
}
