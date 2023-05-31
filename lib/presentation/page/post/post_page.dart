import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/comment/controller/comment_controller_cubit.dart';
import 'package:steemit/presentation/bloc/comment/data/comment_cubit.dart';
import 'package:steemit/presentation/bloc/post/data/post/post_cubit.dart';
import 'package:steemit/presentation/bloc/post/data/posts/posts_cubit.dart';
import 'package:steemit/presentation/bloc/user/data/me/me_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/widget/avatar/avatar_widget.dart';
import 'package:steemit/presentation/widget/button/button_widget.dart';
import 'package:steemit/presentation/widget/comment/comments_card.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
import 'package:steemit/presentation/widget/post/post_list_tile.dart';
import 'package:steemit/presentation/widget/post/post_shimmer.dart';
import 'package:steemit/presentation/widget/shimmer/shimmer_widget.dart';
import 'package:steemit/presentation/widget/textfield/textfield_widget.dart';

class PostPage extends StatefulWidget {
  final String postId;

  const PostPage({Key? key, required this.postId}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    getIt.get<PostCubit>().clean();
    getIt.get<PostCubit>().getData(widget.postId);
    getIt.get<CommentCubit>().clean();
    getIt.get<CommentCubit>().getComments(widget.postId);

    getIt.get<CommentControllerCubit>().stream.listen((event) {
      if (!mounted) return;
      if (event is CommentControllerSuccess) {
        getIt.get<PostCubit>().getData(widget.postId);
        getIt.get<PostsCubit>().getPosts();
        getIt.get<CommentCubit>().getComments(widget.postId);
        getIt.get<CommentControllerCubit>().clean();
      }
      if (event is CommentControllerFailure) {
        getIt.get<CommentControllerCubit>().clean();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Header.background(
            topPadding: MediaQuery.of(context).padding.top,
            content: S.current.lbl_post,
            prefixIconPath: Icons.chevron_left,
            onPrefix: () => Navigator.pop(context)),
        _buildBody()
      ]),
      bottomNavigationBar: commentArea(),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: SingleChildScrollView(
        child: BlocBuilder<PostCubit, PostState>(builder: (context, state) {
          if (state is PostISuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostListTile(
                  postModel: state.postModel,
                  onCommentTap: () {},
                  onTap: () {},
                ),
                BlocBuilder<CommentCubit, CommentState>(
                  builder: (context, state) {
                    if (state is CommentSuccess) {
                      final comments = state.comments;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: comments.length,
                        itemBuilder: (context, index) => CommentsCard(
                          commentModel: comments[index],
                        ),
                      );
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 16),
                            child: Row(
                              children: [
                                ShimmerWidget.base(
                                    width: largeAvatarSize,
                                    height: largeAvatarSize,
                                    shape: BoxShape.circle),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            ShimmerWidget.base(
                                                width: largeAvatarSize,
                                                height: 18,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.0)),
                                            ShimmerWidget.base(
                                                width: 100,
                                                height: 18,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.0)),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: ShimmerWidget.base(
                                              width: largeAvatarSize,
                                              height: 18,
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                ),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [PostShimmer()],
          );
        }),
      ),
    );
  }

  Widget commentArea() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        padding:
            const EdgeInsets.only(left: 16, right: 8, top: 8.0, bottom: 8.0),
        child: BlocBuilder<MeCubit, MeState>(
          builder: (context, state) {
            if (state is MeSuccess) {
              return Row(
                children: [
                  AvatarWidget.base(
                      name: "${state.user.firstName} ${state.user.lastName}",
                      imagePath: state.user.avatar),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextFieldWidget.common(
                            onChanged: (text) {},
                            textEditingController: commentController,
                            hintText: S.current.txt_comment_hint)),
                  ),
                  ButtonWidget.text(
                      onTap: () => commentController.text.isNotEmpty
                          ? addComment(state.user.id)
                          : null,
                      content: S.current.btn_post,
                      context: context)
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void addComment(String userId) {
    getIt.get<CommentControllerCubit>().addComment(
        postId: widget.postId, userId: userId, content: commentController.text);
    setState(() {
      commentController.clear();
    });
  }
}
