import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:steemit/data/model/post_model.dart';
import 'package:steemit/presentation/page/post/post_page.dart';
import 'package:steemit/presentation/widget/avatar/avatar_widget.dart';
import 'package:steemit/presentation/widget/shimmer/shimmer_widget.dart';
import 'package:steemit/util/enum/media_enum.dart';
import 'package:steemit/util/helper/string_helper.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';
import 'package:video_player/video_player.dart';

class PostGridTile extends StatefulWidget {
  final PostModel postModel;
  final double? cardSize;
  final double? horizontalMargin;

  const PostGridTile(
      {Key? key, required this.postModel, this.cardSize, this.horizontalMargin})
      : super(key: key);

  @override
  State<PostGridTile> createState() => _PostGridTileState();
}

class _PostGridTileState extends State<PostGridTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PostPage(postId: widget.postModel.id!))),
      child: Container(
        width: widget.cardSize,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 0,
                  offset: const Offset(0, 2))
            ]),
        child: Column(
          children: [_buildTopArea(), _buildBottomArea()],
        ),
      ),
    );
  }

  Widget _buildTopArea() {
    final medias = widget.postModel.medias ?? List.empty();
    final Widget child;
    if (medias.isEmpty) {
      child = Center(
          child: Text(
        widget.postModel.content!,
        style: BaseTextStyle.label(color: Colors.white),
        maxLines: 3,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ));
    } else {
      child = ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
        child: medias.first.type == MediaEnum.image
            ? CachedNetworkImage(
                imageUrl: medias.first.url!,
                fit: BoxFit.cover,
                placeholder: (context, url) => ShimmerWidget.base(
                    width: widget.cardSize!, height: widget.cardSize!),
              )
            : Stack(
                children: [
                  VideoPlayer(VideoPlayerController.network(medias.first.url!)
                    ..initialize().then((value) => setState(() {}))),
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
      );
    }
    return Container(
      width: widget.cardSize,
      height: widget.cardSize!,
      decoration: const BoxDecoration(
          color: BaseColor.green500,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0))),
      child: child,
    );
  }

  Widget _buildBottomArea() {
    return Container(
      width: widget.cardSize,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12.0),
              bottomLeft: Radius.circular(12.0))),
      padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalMargin ?? 12.0, vertical: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: AvatarWidget.base(
                size: mediumAvatarSize,
                imagePath: widget.postModel.user?.avatar,
                name:
                    "${widget.postModel.user!.firstName} ${widget.postModel.user!.lastName}"),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.postModel.content != null &&
                  widget.postModel.content!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    widget.postModel.content!,
                    style: BaseTextStyle.body2(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              Text(
                StringHelper.formatDate(
                    widget.postModel.updatedAt!.toDate().toString()),
                style: BaseTextStyle.caption(color: BaseColor.grey300),
              )
            ],
          ))
        ],
      ),
    );
  }
}
