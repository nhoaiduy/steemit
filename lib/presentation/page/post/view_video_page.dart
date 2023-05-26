import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ViewVideoPage extends StatefulWidget {
  final VideoPlayerController controller;

  const ViewVideoPage({Key? key, required this.controller}) : super(key: key);

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
              ? SizedBox(
                  width: double.infinity,
                  child: VideoPlayer(widget.controller),
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
