import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/user/data/users/users_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/page/user/user_profile_page.dart';
import 'package:steemit/presentation/widget/avatar/avatar_widget.dart';
import 'package:steemit/presentation/widget/button/button_widget.dart';
import 'package:steemit/presentation/widget/shimmer/shimmer_widget.dart';
import 'package:steemit/presentation/widget/textfield/textfield_widget.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';
import 'package:tiengviet/tiengviet.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  bool onSearch = false;
  String currentString = "";

  @override
  void initState() {
    getIt.get<UsersCubit>().getData();
    searchFocusNode.requestFocus();
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
      backgroundColor: BaseColor.background,
      automaticallyImplyLeading: false,
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left,
            color: BaseColor.grey900,
            size: 32,
          )),
      elevation: 0,
      title: TextFieldWidget.searchGrey(
          textEditingController: searchController,
          textInputAction: TextInputAction.search,
          focusNode: searchFocusNode,
          onChanged: (text) {
            setState(() {
              currentString = text;
              if (text.isNotEmpty) {
                onSearch = true;
              } else {
                onSearch = false;
              }
            });
          },
          maxLines: 1),
      actions: [
        if (onSearch)
          Container(
            alignment: Alignment.center,
            child: ButtonWidget.text(
                onTap: () => cancelSearch(),
                content: S.current.btn_cancel,
                context: context),
          )
        else
          const SizedBox(width: 16.0),
      ],
      titleSpacing: 0,
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 1.0),
        child: Container(
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: BaseColor.grey60))),
        ),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<UsersCubit, UsersState>(
      builder: (context, state) {
        if (state is UsersSuccess) {
          final users = state.users
              .where((element) =>
                  TiengViet.parse(("${element.firstName} ${element.lastName}"))
                      .toLowerCase()
                      .contains(TiengViet.parse(currentString).toLowerCase()) ||
                  element.email.contains(currentString.toLowerCase()))
              .toList();
          if (users.isNotEmpty) {
            return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserProfilePage(user.id))),
                    leading: AvatarWidget.base(
                      imagePath: user.avatar,
                      size: largeAvatarSize,
                      name: "${user.firstName} ${user.lastName}",
                    ),
                    title: Text(
                      "${user.firstName} ${user.lastName}",
                      style: BaseTextStyle.label(),
                    ),
                    subtitle: Text(
                      user.email,
                      style: BaseTextStyle.body2(color: BaseColor.grey300),
                    ),
                  );
                });
          }

          return Center(
            child: Text(
              S.current.txt_no_user,
              style: BaseTextStyle.body1(),
            ),
          );
        }
        return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 100,
            itemBuilder: (context, index) {
              return ListTile(
                leading: ShimmerWidget.base(
                    width: 32, height: 32, shape: BoxShape.circle),
                title: ShimmerWidget.base(
                    width: 100,
                    height: 21,
                    borderRadius: BorderRadius.circular(10.0)),
                subtitle: ShimmerWidget.base(
                    width: 200,
                    height: 16,
                    borderRadius: BorderRadius.circular(10.0)),
              );
            });
      },
    );
  }

  void cancelSearch() {
    searchFocusNode.unfocus();
    setState(() {
      onSearch = false;
      currentString = "";
      searchController.clear();
    });
  }
}
