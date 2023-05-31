import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steemit/presentation/bloc/post/data/posts/posts_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/page/common/search_page.dart';
import 'package:steemit/presentation/page/post/create_post_page.dart';
import 'package:steemit/presentation/widget/post/post_list_tile.dart';
import 'package:steemit/presentation/widget/post/post_shimmer.dart';
import 'package:steemit/util/path/image_path.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getIt.get<PostsCubit>().clean();
    getIt.get<PostsCubit>().getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _buildBody(),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: BaseImage.base(
        ImagePath.appIcon,
      ),
      actions: [
        IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreatePostPage())),
            icon: const Icon(
              Icons.edit_outlined,
              color: BaseColor.grey900,
            )),
        IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SearchPage())),
            icon: const Icon(
              Icons.search_outlined,
              color: BaseColor.grey900,
            ))
      ],
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 1.0),
        child: Container(
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: BaseColor.grey60))),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<PostsCubit, PostsState>(builder: (context, state) {
      if (state is PostsSuccess) {
        return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              final post = state.posts[index];
              return PostListTile(
                postModel: post,
              );
            });
      }
      if (state is PostsFailure) {
        return const SizedBox.shrink();
      }

      return ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return const PostShimmer();
          });
    });
  }
}
