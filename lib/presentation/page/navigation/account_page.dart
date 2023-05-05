import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steemit/data/model/user_model.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/authentication_layer/authentication_cubit.dart';
import 'package:steemit/presentation/bloc/authentication_layer/authentication_state.dart';
import 'package:steemit/presentation/bloc/base_layer/base_layer_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/page/post/create_post_page.dart';
import 'package:steemit/presentation/page/post/post_page.dart';
import 'package:steemit/presentation/page/setting/setting_page.dart';
import 'package:steemit/presentation/page/setting/update_bio_page.dart';
import 'package:steemit/presentation/page/setting/update_profile_page.dart';
import 'package:steemit/presentation/widget/avatar/avatar_widget.dart';
import 'package:steemit/presentation/widget/bottom_sheet/bottom_sheet_widget.dart';
import 'package:steemit/presentation/widget/button/button_widget.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
import 'package:steemit/presentation/widget/shimmer/shimmer_widget.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
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
    return Scaffold(
      body: Column(
        children: [
          Header.background(
            topPadding: MediaQuery.of(context).padding.top,
            content: S.current.lbl_account,
            suffixIconPath: Icons.settings,
            onSuffix: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SettingPage()));
            },
            secondSuffixIconPath: Icons.edit,
            onSecondSuffix: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreatePostPage()));
            },
          ),
          _buildBody()
        ],
      ),
    );
  }

  _buildBody() {
    return Expanded(
      child: SingleChildScrollView(
        child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
            bloc: getIt.get<AuthenticationCubit>(),
            builder: (context, state) {
              if (state is AuthenticatedState) {
                final user = state.userModel;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopArea(user: user),
                    _buildPostListArea(user: user)
                  ],
                );
              }
              return _shimmer();
            }),
      ),
    );
  }

  _buildTopArea({required UserModel user}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.7, color: BaseColor.grey40))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: AvatarWidget.base(
                    isBorder: true,
                    imagePath: user.avatar,
                    name: "${user.firstName} ${user.lastName}",
                    size: extraLargeAvatarSize),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            S.current.lbl_post,
                            style: BaseTextStyle.label(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          "100",
                          style: BaseTextStyle.body1(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            S.current.lbl_following,
                            style: BaseTextStyle.label(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          "${user.followings.length}",
                          style: BaseTextStyle.body1(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            S.current.lbl_follower,
                            style: BaseTextStyle.label(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          "${user.followers.length}",
                          style: BaseTextStyle.body1(),
                        ),
                      ],
                    ),
                  )
                ],
              ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              "${user.firstName} ${user.lastName}",
              style: BaseTextStyle.subtitle2(),
            ),
          ),
          GestureDetector(
            onTap: () {
              _showBottomSheet(
                  userModel: user,
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
                  userModel: user,
                  body: UpdateProfilePage(
                    userModel: user,
                  )),
              content: S.current.btn_update_profile),
        ],
      ),
    );
  }

  _buildPostListArea({required UserModel user}) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Wrap(
      children: List.generate(100, (index) {
        return GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PostPage())),
          child: Container(
            width: screenWidth / 3,
            height: screenWidth / 3,
            decoration: BoxDecoration(
                border: Border.all(color: BaseColor.grey40),
                color: Colors.transparent),
            child: CachedNetworkImage(
              imageUrl:
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/330px-Image_created_with_a_mobile_phone.png",
              fit: BoxFit.cover,
              placeholder: (context, image) {
                return ShimmerWidget.base(
                    width: screenWidth / 3, height: screenWidth / 3);
              },
            ),
          ),
        );
      }),
    );
  }

  _shimmer() {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.7, color: BaseColor.grey40))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: ShimmerWidget.base(
                          width: 80.0, height: 80.0, shape: BoxShape.circle)),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ShimmerWidget.base(
                                  width: 70,
                                  height: 20,
                                  borderRadius: BorderRadius.circular(12.0))),
                          ShimmerWidget.base(
                              width: 50,
                              height: 18,
                              borderRadius: BorderRadius.circular(12.0))
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ShimmerWidget.base(
                                  width: 70,
                                  height: 20,
                                  borderRadius: BorderRadius.circular(12.0))),
                          ShimmerWidget.base(
                              width: 50,
                              height: 18,
                              borderRadius: BorderRadius.circular(12.0))
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ShimmerWidget.base(
                                  width: 70,
                                  height: 20,
                                  borderRadius: BorderRadius.circular(12.0))),
                          ShimmerWidget.base(
                              width: 50,
                              height: 18,
                              borderRadius: BorderRadius.circular(12.0))
                        ],
                      )
                    ],
                  ))
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: ShimmerWidget.base(
                      width: 120,
                      height: 24,
                      borderRadius: BorderRadius.circular(12.0))),
              GestureDetector(
                child: Container(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, right: 16.0),
                    color: Colors.transparent,
                    child: ShimmerWidget.base(
                        width: 50,
                        height: 20,
                        borderRadius: BorderRadius.circular(8.0))),
              ),
              ShimmerWidget.base(
                  width: screenWidth - 32,
                  height: 48,
                  borderRadius: BorderRadius.circular(12.0))
            ],
          ),
        ),
        Wrap(
          children: List.generate(50, (index) {
            return ShimmerWidget.base(
              width: screenWidth / 3,
              height: screenWidth / 3,
            );
          }),
        )
      ],
    );
  }

  _showBottomSheet({required UserModel userModel, required Widget body}) {
    BottomSheetWidget.show(context: context, body: body);
  }
}
