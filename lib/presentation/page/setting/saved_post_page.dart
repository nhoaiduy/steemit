import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/post/controller/post_controller_cubit.dart';
import 'package:steemit/presentation/bloc/post/data/saved_posts/saved_posts_cubit.dart';
import 'package:steemit/presentation/bloc/user/data/me/me_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
import 'package:steemit/presentation/widget/post/post_card.dart';
import 'package:steemit/presentation/widget/post/post_shimmer.dart';

class SavedPostPage extends StatefulWidget {
  const SavedPostPage({Key? key}) : super(key: key);

  @override
  State<SavedPostPage> createState() => _SavedPostPageState();
}

class _SavedPostPageState extends State<SavedPostPage> {
  @override
  void initState() {
    getIt.get<SavedPostsCubit>().clean();
    getIt
        .get<PostControllerCubit>()
        .stream
        .listen((event) {
      if (!mounted) return;
      if (event is PostControllerSuccess) {
        getIt.get<MeCubit>().getData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header.background(
            topPadding: MediaQuery
                .of(context)
                .padding
                .top,
            content: S.current.lbl_saved_posts,
            prefixIconPath: Icons.chevron_left,
          ),
          _buildPostListArea()
        ],
      ),
    );
  }

  _buildPostListArea() {
    return Expanded(
      child: BlocBuilder<MeCubit, MeState>(builder: (context, state) {
        if (state is MeSuccess) {
          return BlocBuilder<SavedPostsCubit, SavedPostsState>(
              bloc: getIt.get<SavedPostsCubit>()
                ..getData(postIdList: state.user.savedPosts!),
              builder: (context, state) {
                if (state is SavedPostsSuccess) {
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        final post = state.posts[index];
                        return PostCard(postModel: post);
                      });
                }
                return ListView.builder(
                    itemCount: 10,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return const PostShimmer();
                    });
              });
        }
        if (state is MeFailure) {
          return const SizedBox.shrink();
        }

        return ListView.builder(
            itemCount: 10,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return const PostShimmer();
            });
      }),
    );
  }
}
