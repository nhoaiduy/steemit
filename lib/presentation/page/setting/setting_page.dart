import 'package:flutter/material.dart';
import 'package:steemit/presentation/bloc/authentication_layer/authentication_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/page/setting/change_password_page.dart';
import 'package:steemit/presentation/widget/bottom_sheet/bottom_sheet_widget.dart';
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
        appBar: _appBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TileWidget.cellSmall(
                  content: "Change password",
                  prefix: Icons.key_outlined,
                  suffix: const Icon(
                    Icons.chevron_right,
                    color: BaseColor.blue300,
                    size: 36,
                  ),
                  onTap: () {
                    BottomSheetWidget.base(
                        context: context, body: const ChangePasswordPage());
                  }),
              TileWidget.cellSmall(
                  content: "Log out",
                  contentColor: BaseColor.red500,
                  onTap: () {
                    Navigator.pop(context);
                    getIt.get<AuthenticationCubit>().logout();
                  }),
            ],
          ),
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
        "Setting",
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
