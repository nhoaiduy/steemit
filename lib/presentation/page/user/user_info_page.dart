import 'package:flutter/material.dart';
import 'package:steemit/data/model/user_model.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
import 'package:steemit/util/helper/gender_helper.dart';
import 'package:steemit/util/style/base_text_style.dart';

class UserInfoPage extends StatelessWidget {
  final UserModel userModel;

  const UserInfoPage(this.userModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Header.background(
            content: S.current.btn_user_info,
            suffixContent: S.current.btn_done,
            onSuffix: () => Navigator.pop(context)),
        _body()
      ],
    );
  }

  Widget _body() {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoRow(S.current.lbl_gender,
                GenderHelper.mapEnumToString(userModel.gender!)),
            _infoRow(S.current.lbl_email, userModel.email),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Text(label, style: BaseTextStyle.label()),
          Expanded(
              child: Text(
            content,
            style: BaseTextStyle.body1(),
            textAlign: TextAlign.right,
          ))
        ],
      ),
    );
  }
}
