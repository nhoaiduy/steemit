import 'package:flutter/material.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/widget/bottom_sheet/bottom_sheet_widget.dart';
import 'package:steemit/presentation/widget/textfield/textfield_widget.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
            padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 80.0,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16.0),
            child: Column(
              children: [
                TextFieldWidget.common(
                    onChanged: (text) {},
                    labelText: S.current.lbl_old_password,
                    hintText: S.current.txt_old_password_hint,
                    required: true),
                const SizedBox(height: 20.0),
                TextFieldWidget.common(
                    onChanged: (text) {},
                    labelText: S.current.lbl_new_password,
                    hintText: S.current.txt_new_password_hint,
                    required: true),
                const SizedBox(height: 20.0),
                TextFieldWidget.common(
                    onChanged: (text) {},
                    labelText: S.current.lbl_confirm_new_password,
                    hintText: S.current.txt_confirm_new_password_hint,
                    required: true),
              ],
            )),
        BottomSheetWidget.title(
            context: context,
            title: S.current.lbl_change_password,
            rollbackContent: S.current.btn_cancel,
            submitContent: S.current.btn_update),

      ],
    );
  }
}
