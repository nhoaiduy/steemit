import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steemit/data/service/authentication_service.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/base_layer/base_layer_cubit.dart';
import 'package:steemit/presentation/bloc/post/data/posts/posts_cubit.dart';
import 'package:steemit/presentation/bloc/user/data/me/me_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/page/post/create_post_page.dart';
import 'package:steemit/presentation/page/setting/setting_page.dart';
import 'package:steemit/presentation/page/setting/update_bio_page.dart';
import 'package:steemit/presentation/page/setting/update_profile_page.dart';
import 'package:steemit/presentation/widget/avatar/avatar_widget.dart';
import 'package:steemit/presentation/widget/bottom_sheet/bottom_sheet_widget.dart';
import 'package:steemit/presentation/widget/button/button_widget.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
import 'package:steemit/presentation/widget/post/post_grid_tile.dart';
import 'package:steemit/presentation/widget/post/post_list_tile.dart';
import 'package:steemit/presentation/widget/post/post_shimmer.dart';
import 'package:steemit/presentation/widget/shimmer/shimmer_widget.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String myId = "";
  int index = 0;

  @override
  void initState() {
    getIt.get<MeCubit>().getData();
    getIt.get<BaseLayerCubit>().stream.listen((event) {
      if (!mounted) return;
      if (event is LanguageState) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Header.background(
              topPadding: MediaQuery.of(context).padding.top,
              content: S.current.lbl_account,
              suffixIconPath: Icons.settings,
              onSuffix: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingPage()));
              },
              secondSuffixIconPath: Icons.edit,
              onSecondSuffix: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreatePostPage()));
                getIt.get<PostsCubit>().getPosts();
              },
            ),
            _buildBody()
          ],
        ),
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
    return BlocBuilder<MeCubit, MeState>(builder: (context, state) {
      if (state is MeSuccess) {
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
              GestureDetector(
                onTap: () {
                  _showBottomSheet(
                      body: UpdateBioPage(
                    bio: user.bio,
                  ));
                },
                child: Container(
                  padding:
                      const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 16.0),
                  color: Colors.transparent,
                  child: Text(
                    user.bio ?? S.current.btn_add_bio,
                    style: BaseTextStyle.body1(color: BaseColor.grey300),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ButtonWidget.tertiary(
                  onTap: () => _showBottomSheet(
                          body: UpdateProfilePage(
                        userModel: user,
                      )),
                  content: S.current.btn_update_profile),
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
    const double horizontalMargin = 16;
    const double minCardSize = 140;
    double contentWidth = min(MediaQuery.of(context).size.width, 700);
    int count = contentWidth ~/ minCardSize;
    double cardSize = (contentWidth - horizontalMargin) / count;
    return BlocBuilder<PostsCubit, PostsState>(
        bloc: getIt.get<PostsCubit>()..getPosts(),
        builder: (context, state) {
          if (state is PostsSuccess) {
            final myPosts = state.posts
                .where((post) => post.userId == authService.getUserId())
                .toList();
            if (myPosts.isNotEmpty) {
              return Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: TabBar(
                        labelStyle: BaseTextStyle.body1(),
                        unselectedLabelStyle: BaseTextStyle.body2(),
                        labelColor: BaseColor.green500,
                        unselectedLabelColor: BaseColor.grey300,
                        indicatorColor: BaseColor.green500,
                        onTap: (value) => setState(() {
                              index = value;
                            }),
                        tabs: [
                          Tab(
                            height: 48,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.list),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  S.current.lbl_listview,
                                )
                              ],
                            ),
                          ),
                          Tab(
                            height: 48,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.grid_view,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  S.current.lbl_gridview,
                                )
                              ],
                            ),
                          ),
                        ]),
                  ),
                  [
                    Column(
                      children: List.generate(myPosts.length, (index) {
                        final post = myPosts[index];
                        return PostListTile(postModel: post);
                      }),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(horizontalMargin),
                      child: Wrap(
                        runSpacing: horizontalMargin,
                        spacing: horizontalMargin,
                        children: List.generate(myPosts.length, (index) {
                          final post = myPosts[index];
                          return PostGridTile(
                            postModel: post,
                            cardSize: cardSize - horizontalMargin,
                            horizontalMargin: horizontalMargin,
                          );
                        }),
                      ),
                    )
                  ].elementAt(index)
                ],
              );
            }

            return Container(
              height: 200,
              alignment: Alignment.center,
              child: Text(
                S.current.txt_no_post,
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
