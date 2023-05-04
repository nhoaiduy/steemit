import 'package:flutter/material.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/authentication_layer/authentication_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/page/setting/change_language_page.dart';
import 'package:steemit/presentation/page/setting/change_password_page.dart';
import 'package:steemit/presentation/page/setting/recent_activities_page.dart';
import 'package:steemit/presentation/page/setting/saved_post_page.dart';
import 'package:steemit/presentation/widget/bottom_sheet/bottom_sheet_widget.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
import 'package:steemit/presentation/widget/tile/tile_widget.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Header.background(
          topPadding: MediaQuery.of(context).padding.top,
          content: S.current.lbl_setting,
          prefixIconPath: Icons.chevron_left,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TileWidget.setting(
                    isFirst: true,
                    content: S.current.lbl_recent_activities,
                    prefixIcon: Icons.local_activity,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const RecentActivitiesPage()))),
                TileWidget.setting(
                    content: S.current.lbl_saved_posts,
                    prefixIcon: Icons.bookmark_outlined,
                    prefixBackgroundColor: BaseColor.yellow500,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SavedPostPage()))),
                TileWidget.setting(
                    content: S.current.lbl_change_password,
                    prefixIcon: Icons.key_outlined,
                    prefixBackgroundColor: BaseColor.red500,
                    onTap: () {
                      BottomSheetWidget.show(
                          context: context, body: const ChangePasswordPage());
                    }),
                TileWidget.setting(
                    content: S.current.lbl_change_language,
                    prefixIcon: Icons.language,
                    prefixBackgroundColor: BaseColor.green500,
                    onTap: () {
                      BottomSheetWidget.show(
                          context: context, body: const ChangeLanguagePage());
                    }),
                TileWidget.setting(
                    isLast: true,
                    content: S.current.btn_log_out,
                    contentColor: BaseColor.red500,
                    isDirect: false,
                    onTap: () {
                      Navigator.pop(context);
                      getIt.get<AuthenticationCubit>().logout();
                    }),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  _appBar() {
    return AppBar(
      backgroundColor: BaseColor.background,
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left,
            color: BaseColor.grey900,
            size: 36,
          )),
      title: Text(
        S.current.lbl_setting,
        style: BaseTextStyle.subtitle1(),
      ),
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 1.0),
        child: Container(
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: BaseColor.grey60))),
        ),
      ),
    );
  }
}
