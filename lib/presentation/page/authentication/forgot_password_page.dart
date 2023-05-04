import 'package:flutter/material.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/widget/button/button_widget.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
import 'package:steemit/presentation/widget/textfield/textfield_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header.background(
            topPadding: MediaQuery.of(context).padding.top,
            content: S.current.lbl_forgot_password,
            prefixIconPath: Icons.chevron_left,
          ),
          _body()
        ],
      ),
    );
  }

  _body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: Column(
        children: [
          TextFieldWidget.common(
              onChanged: (text) {},
              labelText: S.current.lbl_email,
              required: true,
              hintText: S.current.txt_email_hint),
          const SizedBox(height: 24.0),
          ButtonWidget.primary(onTap: () {}, content: S.current.btn_send)
        ],
      ),
    );
  }
}
