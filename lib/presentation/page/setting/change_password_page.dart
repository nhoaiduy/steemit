import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/authentication_layer/authentication_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/page/authentication/login_page.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
import 'package:steemit/presentation/widget/textfield/textfield_widget.dart';
import 'package:steemit/util/helper/login_helper.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

const double commonPadding = 16.0;

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmController = TextEditingController();

  var currentUser = FirebaseAuth.instance.currentUser;
  bool check = false;

  bool _isHideOldPassword = true;
  bool _isHideNewPassword = true;
  bool _isHideConfirmPassword = true;

  String? _changePasswordErrorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header.background(
            content: S.current.lbl_change_password,
            prefixContent: S.current.btn_cancel,
            suffixContent: S.current.btn_update,
            onSuffix: () async {
              clearError();
              resetCheck();
              unFocus();
              resetHidePasswordState();
              await changePassword(
                  email: currentUser!.email.toString(),
                  oldPassword: oldPasswordController.text,
                  newPassword: newPasswordController.text,
                  confirmPassword: confirmController.text,
              );
              if (check){
                if (mounted) {
                  int count = 0;
                  Navigator.of(context).popUntil((route) => count++ >= 2);
                }
                getIt.get<AuthenticationCubit>().logout();
              }
            }),
        _buildBody(),
      ],
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: SingleChildScrollView(
          padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16.0),
          child: Column(
            children: [
              TextFieldWidget.common(
                  onChanged: (text) {},
                  textEditingController: oldPasswordController,
                  textInputAction: TextInputAction.next,
                  isObscured: _isHideOldPassword,
                  maxLines: 1,
                  suffixIconPath: _isHideOldPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  onSuffixIconTap: () {
                    setState(() {
                      _isHideOldPassword = !_isHideOldPassword;
                    });
                  },
                  labelText: S.current.lbl_old_password,
                  hintText: S.current.txt_old_password_hint,
                  required: true),
              const SizedBox(height: 20.0),
              TextFieldWidget.common(
                  onChanged: (text) {},
                  textEditingController: newPasswordController,
                  textInputAction: TextInputAction.next,
                  isObscured: _isHideNewPassword,
                  maxLines: 1,
                  suffixIconPath: _isHideNewPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  onSuffixIconTap: () {
                    setState(() {
                      _isHideNewPassword = !_isHideNewPassword;
                    });
                  },
                  labelText: S.current.lbl_new_password,
                  hintText: S.current.txt_new_password_hint,
                  required: true),
              const SizedBox(height: 20.0),
              TextFieldWidget.common(
                  onChanged: (text) {},
                  textEditingController: confirmController,
                  textInputAction: TextInputAction.done,
                  isObscured: _isHideConfirmPassword,
                  maxLines: 1,
                  suffixIconPath: _isHideConfirmPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  onSuffixIconTap: () {
                    setState(() {
                      _isHideConfirmPassword = !_isHideConfirmPassword;
                    });
                  },
                  labelText: S.current.lbl_confirm_new_password,
                  hintText: S.current.txt_confirm_new_password_hint,
                  required: true),
              if (_changePasswordErrorText != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    _changePasswordErrorText!,
                    style: BaseTextStyle.body1(color: BaseColor.red500),
                  ),
                ),
              const SizedBox(
                height: commonPadding,
              ),
            ],
          )),
    );
  }

  void unFocus() => FocusScope.of(context).unfocus();

  void clearError() {
    setState(() {
      _changePasswordErrorText = "";
    });
  }

  void resetHidePasswordState() {
    setState(() {
      _isHideOldPassword = true;
      _isHideNewPassword = true;
      _isHideConfirmPassword = true;
    });
  }

  void resetCheck() {
    setState(() {
      check = false;
    });
  }

  changePassword(
      {required String email,
        required String oldPassword,
        required String newPassword,
        required String confirmPassword}) async{

    Either<String, void> validOldPassword = ValidationHelper.validPassword(oldPassword);
    if (validOldPassword.isLeft) {
      _changePasswordErrorText = Left(validOldPassword.left).left;
      return;
    }
    Either<String, void> validNewPassword = ValidationHelper.validPassword(newPassword);
    if (validNewPassword.isLeft) {
      _changePasswordErrorText = Left(validNewPassword.left).left;
      return;
    }
    if (newPassword != confirmPassword) {
      _changePasswordErrorText = Left(S.current.txt_err_mismatch_password).left;
      return;
    }

    var cred = EmailAuthProvider.credential(email: email, password: oldPassword);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      check = true;
    }).catchError((e){
      _changePasswordErrorText = Left(S.current.txt_err_wrong_password).left;
      return;
    });

    if(check){
      try{
        await currentUser!.updatePassword(newPassword);
        setState(() {
          oldPasswordController.clear();
          newPasswordController.clear();
          confirmController.clear();
        });
      } on FirebaseAuthException catch (e){
        _changePasswordErrorText = Left(e.message!).left;
        return;
      }
    }
  }
}
