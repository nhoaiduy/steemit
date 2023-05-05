import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/post/data/posts/posts_cubit.dart';
import 'package:steemit/presentation/bloc/user/data/user/user_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/page/user/user_info_page.dart';
import 'package:steemit/presentation/widget/avatar/avatar_widget.dart';
import 'package:steemit/presentation/widget/bottom_sheet/bottom_sheet_widget.dart';
import 'package:steemit/presentation/widget/button/button_widget.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
import 'package:steemit/presentation/widget/post/post_card.dart';
import 'package:steemit/presentation/widget/post/post_shimmer.dart';
import 'package:steemit/presentation/widget/shimmer/shimmer_widget.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class UserProfilePage extends StatefulWidget {
  final String userId;

  const UserProfilePage(this.userId, {Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  void initState() {
    getIt.get<UserCubit>().clean();
    getIt.get<UserCubit>().getData(userId: widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header.background(
              topPadding: MediaQuery.of(context).padding.top,
              content: S.current.lbl_account,
              prefixIconPath: Icons.chevron_left),
          _buildBody()
        ],
      ),
    );
  }

  _buildBody() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [_buildTopArea(), _buildPostListArea()],
        ),
      ),
    );
  }

  _buildTopArea() {
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      if (state is UserSuccess) {
        final user = state.user;
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.7, color: BaseColor.grey40))),
          child: Column(
            children: [
              AvatarWidget.base(
                  isBorder: true,
                  imagePath: user.avatar,
                  name: "${user.firstName} ${user.lastName}",
                  size: extraLargeAvatarSize),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "${user.firstName} ${user.lastName}",
                  style: BaseTextStyle.subtitle2(),
                ),
              ),
              if (user.bio != null)
                Container(
                  padding:
                      const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 16.0),
                  color: Colors.transparent,
                  child: Text(
                    user.bio!,
                    style: BaseTextStyle.body1(color: BaseColor.grey300),
                  ),
                ),
              const SizedBox(height: 16.0),
              ButtonWidget.tertiary(
                  onTap: () => _showBottomSheet(body: UserInfoPage(user)),
                  content: S.current.btn_user_info),
            ],
          ),
        );
      }
      return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 0.7, color: BaseColor.grey40))),
        child: Column(
          children: [
            ShimmerWidget.base(
                width: 80.0, height: 80.0, shape: BoxShape.circle),
            Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: ShimmerWidget.base(
                    width: 120,
                    height: 24,
                    borderRadius: BorderRadius.circular(12.0))),
            Container(
                padding:
                    const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 16.0),
                color: Colors.transparent,
                child: ShimmerWidget.base(
                    width: double.infinity,
                    height: 20,
                    borderRadius: BorderRadius.circular(8.0))),
            const SizedBox(height: 16.0),
            ShimmerWidget.base(
                width: screenWidth - 32,
                height: 48,
                borderRadius: BorderRadius.circular(12.0))
          ],
        ),
      );
    });
  }

  _buildPostListArea() {
    return BlocBuilder<PostsCubit, PostsState>(
        bloc: getIt.get<PostsCubit>()..getPosts(),
        builder: (context, state) {
          if (state is PostsSuccess) {
            final posts = state.posts
                .where((post) => post.userId == widget.userId)
                .toList();
            if (posts.isNotEmpty) {
              return Column(
                children: List.generate(posts.length, (index) {
                  final post = posts[index];
                  return PostCard(postModel: post);
                }),
              );
            }

            return Container(
              height: 200,
              alignment: Alignment.center,
              child: Text(
                S.current.btn_saved_post,
                style: BaseTextStyle.body1(),
              ),
            );
          }
          return ListView.builder(
              itemCount: 10,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return const PostShimmer();
              });
        });
  }

  _showBottomSheet({required Widget body}) {
    BottomSheetWidget.show(context: context, body: body);
  }
}
