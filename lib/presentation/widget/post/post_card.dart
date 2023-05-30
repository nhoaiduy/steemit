import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steemit/data/model/post_model.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/download/download_cubit.dart';
import 'package:steemit/presentation/bloc/post/controller/post_controller_cubit.dart';
import 'package:steemit/presentation/bloc/post/data/posts/posts_cubit.dart';
import 'package:steemit/presentation/bloc/user/data/me/me_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/page/post/comments_page.dart';
import 'package:steemit/presentation/page/user/user_profile_page.dart';
import 'package:steemit/presentation/widget/avatar/avatar_widget.dart';
import 'package:steemit/presentation/widget/shimmer/shimmer_widget.dart';
import 'package:steemit/presentation/widget/video/video_card.dart';
import 'package:steemit/util/enum/media_enum.dart';
import 'package:steemit/util/helper/string_helper.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class PostCard extends StatefulWidget {
  final PostModel postModel;

  const PostCard({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isShow = true;
  bool isSaved = false;
  bool isMe = false;
  bool isLike = false;
  PostModel postModel = PostModel();
  final CarouselController imageController = CarouselController();

  @override
  void initState() {
    postModel = widget.postModel;
    getIt.get<MeCubit>().getData();
    final state = getIt.get<MeCubit>().state;
    if (state is MeSuccess) {
      final user = state.user;
      if (user.id == postModel.userId) {
        setState(() {
          isMe = true;
        });
      }
      if (user.savedPosts!.contains(postModel.id)) {
        setState(() {
          isSaved = true;
        });
      }
      if (postModel.likes!.contains(user.id)) {
        setState(() {
          isLike = true;
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 3, color: BaseColor.grey60))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: AvatarWidget.base(
                      name:
                          "${postModel.user!.firstName} ${postModel.user!.lastName}",
                      size: mediumAvatarSize),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => isMe
                              ? null
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UserProfilePage(postModel.userId!))),
                          child: Text(
                              "${postModel.user!.firstName} ${postModel.user!.lastName}",
                              style: BaseTextStyle.label()),
                        ),
                        Row(
                          children: [
                            Text(
                              StringHelper.formatDate(
                                  postModel.updatedAt!.toDate().toString()),
                              style: BaseTextStyle.caption(),
                            ),
                            if (postModel.location != null)
                              Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      postModel.location!,
                                      style: BaseTextStyle.caption(),
                                      overflow: TextOverflow.ellipsis,
                                    )),
                              )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {},
                  itemBuilder: (BuildContext context) {
                    return [
                      if (!isMe)
                        PopupMenuItem<String>(
                          value: S.current.btn_save_post,
                          child: Text(isSaved
                              ? S.current.btn_saved_post
                              : S.current.btn_save_post),
                          onTap: () async {
                            if (isSaved) {
                              await getIt
                                  .get<PostControllerCubit>()
                                  .unSave(postId: postModel.id!);
                            } else {
                              await getIt
                                  .get<PostControllerCubit>()
                                  .save(postId: postModel.id!);
                            }
                            setState(() {
                              isSaved = !isSaved;
                            });
                          },
                        ),
                      if (isMe)
                        PopupMenuItem<String>(
                          onTap: () async {
                            getIt.get<PostsCubit>().clean();
                            await getIt
                                .get<PostControllerCubit>()
                                .delete(postId: postModel.id!);
                            getIt.get<PostsCubit>().getPosts();
                          },
                          value: S.current.btn_delete,
                          child: Text(S.current.btn_delete),
                        ),
                    ];
                  },
                ),
              ],
            ),
          ),
          if (postModel.content != null)
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isShow = !isShow;
                    });
                  },
                  child: RichText(
                    softWrap: true,
                    overflow:
                        isShow ? TextOverflow.ellipsis : TextOverflow.visible,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: postModel.content,
                          style: BaseTextStyle.body2(),
                        )
                      ],
                    ),
                  ),
                )),
          // Image
          if (postModel.medias!.isNotEmpty) imageSlider(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (postModel.likes!.isNotEmpty)
                    ? Text(
                        '${postModel.likes!.length} ${postModel.likes!.length > 1 ? S.current.txt_likes : S.current.txt_like}',
                        style: BaseTextStyle.body2(),
                        overflow: TextOverflow.fade,
                      )
                    : const SizedBox.shrink(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommentsPage(
                                  postId: postModel.id!,
                                )));
                  },
                  child: Text(
                    '${postModel.comments!.length} ${postModel.comments!.length > 1 ? S.current.txt_comments : S.current.txt_comment}',
                    style: BaseTextStyle.body2(),
                  ),
                ),
              ],
            ),
          ),
          // Actions
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(width: 0.8, color: BaseColor.grey60))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      if (isLike) {
                        await getIt
                            .get<PostControllerCubit>()
                            .unLike(postId: postModel.id!);
                        postModel.likes!.removeAt(0);
                      } else {
                        await getIt
                            .get<PostControllerCubit>()
                            .like(postId: postModel.id!);
                        postModel.likes!.add("");
                      }
                      setState(() {
                        isLike = !isLike;
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isLike
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.redAccent,
                                )
                              : const Icon(
                                  Icons.favorite_outline,
                                ),
                          const SizedBox(width: 5),
                          Text(S.current.btn_like),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommentsPage(
                                    postId: postModel.id!,
                                  )));
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.comment_outlined,
                          ),
                          const SizedBox(width: 5),
                          Text(S.current.btn_comment),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget imageSlider() {
    return CarouselSlider.builder(
        carouselController: imageController,
        itemCount: postModel.medias!.length,
        itemBuilder: (context, index, realIndex) {
          final media = postModel.medias![index];
          return GestureDetector(
            onLongPress: () => download(media),
            child: (media.type == MediaEnum.image)
                ? buildImage(media: media)
                : VideoCard(
                    media: media,
                    download: () => download(media),
                  ),
          );
        },
        options: CarouselOptions(
            height: 250, enableInfiniteScroll: false, viewportFraction: 1));
  }

  Widget buildImage({required MediaModel media}) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                insetPadding: EdgeInsets.zero,
                content: GestureDetector(
                  onLongPress: () => download(media),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CachedNetworkImage(
                      imageUrl: media.url!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => ShimmerWidget.base(
                          width: double.infinity, height: 250),
                    ),
                  ),
                ),
                contentPadding: EdgeInsets.zero,
              );
            });
      },
      child: SizedBox(
        width: double.infinity,
        child: CachedNetworkImage(
          imageUrl: media.url!,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              ShimmerWidget.base(width: double.infinity, height: 250),
        ),
      ),
    );
  }

  void download(MediaModel media) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Wrap(children: [
            Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0))),
                child: BlocBuilder<DownloadCubit, DownloadState>(
                  builder: (context, state) {
                    if (state is DownloadSuccess) {
                      return ListTile(
                        leading: const Icon(Icons.check),
                        title: Text(
                          S.current.btn_saved_to_phone,
                          style: BaseTextStyle.body1(),
                        ),
                      );
                    }
                    if (state is DownloadDownloading) {
                      return ListTile(
                        leading: const CircularProgressIndicator(
                          color: BaseColor.green500,
                        ),
                        title: Text(
                          S.current.btn_downloading,
                          style: BaseTextStyle.body1(),
                        ),
                      );
                    }
                    return ListTile(
                      onTap: () => getIt
                          .get<DownloadCubit>()
                          .download(media.url!, media.name!),
                      leading: const Icon(Icons.download),
                      title: Text(
                        S.current.btn_save_to_phone,
                        style: BaseTextStyle.body1(),
                      ),
                    );
                  },
                ))
          ]);
        });
    await Future.delayed(const Duration(milliseconds: 400));
    if (getIt.get<DownloadCubit>().state is DownloadSuccess ||
        getIt.get<DownloadCubit>().state is DownloadSuccess) {
      getIt.get<DownloadCubit>().clean();
    }
  }
}
