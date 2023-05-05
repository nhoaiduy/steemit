import 'package:flutter/material.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/forgot_passeord/forgot_password_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/widget/button/button_widget.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
import 'package:steemit/presentation/widget/snackbar/snackbar_widget.dart';
import 'package:steemit/presentation/widget/textfield/textfield_widget.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  String? _errorText;

  @override
  void initState() {
    getIt.get<ForgotPasswordCubit>().stream.listen((event) {
      if (!mounted) return;
      if (event is ForgotPasswordFailure) {
        setState(() {
          _errorText = event.message;
        });
        return;
      }
      if (event is ForgotPasswordSuccess) {
        SnackBarWidget.show(
            context: context,
            snackBar:
                SnackBarWidget.success(content: S.current.txt_check_mail));
        Navigator.pop(context);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

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
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWidget.common(
                onChanged: (text) {},
                labelText: S.current.lbl_email,
                required: true,
                textEditingController: _emailController,
                textInputType: TextInputType.emailAddress,
                hintText: S.current.txt_email_hint),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: _errorText != null
                    ? Text(_errorText!,
                        style: BaseTextStyle.body1(color: BaseColor.red500))
                    : null),
            ButtonWidget.primary(
                onTap: () => reset(), content: S.current.btn_send)
          ],
        ),
      ),
    );
  }

  void reset() {
    clearError();
    unFocus();
    getIt
        .get<ForgotPasswordCubit>()
        .resetPassword(email: _emailController.text);
  }

  void clearError() => setState(() {
        _errorText = null;
      });

  void unFocus() => FocusScope.of(context).unfocus();
}
