import 'package:flutter/material.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/register/register_cubit.dart';
import 'package:steemit/presentation/bloc/register/register_state.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/page/setting/select_gender_page.dart';
import 'package:steemit/presentation/widget/bottom_sheet/bottom_sheet_widget.dart';
import 'package:steemit/presentation/widget/button/button_widget.dart';
import 'package:steemit/presentation/widget/header/header_widget.dart';
import 'package:steemit/presentation/widget/textfield/textfield_widget.dart';
import 'package:steemit/util/controller/loading_cover_controller.dart';
import 'package:steemit/util/enum/gender_enum.dart';
import 'package:steemit/util/helper/gender_helper.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

const double commonPadding = 16.0;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController genderController = TextEditingController();

  String? _registerErrorText;

  bool _isHidePassword = true;
  bool _isHideConfirmPassword = true;

  Gender? gender;

  @override
  void initState() {
    getIt.get<RegisterCubit>().stream.listen((event) {
      if (!mounted) return;
      if (event is RegisterErrorState) {
        setState(() {
          _registerErrorText = event.message;
        });
        return;
      }
      if (event is RegisterSuccessState) {
        Navigator.pop(context);
        return;
      }

      LoadingCoverController.instance.close(context);
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
          content: S.current.lbl_register,
          prefixIconPath: Icons.chevron_left,
        ),
        _body()
      ],
    ));
  }

  _body() {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(commonPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWidget.common(
                onChanged: (text) {},
                textEditingController: firstNameController,
                textInputAction: TextInputAction.next,
                prefixIconPath: Icons.text_fields_outlined,
                labelText: S.current.lbl_first_name,
                required: true,
                hintText: S.current.txt_first_name_hint),
            const SizedBox(
              height: commonPadding,
            ),
            TextFieldWidget.common(
                onChanged: (text) {},
                prefixIconPath: Icons.text_fields_outlined,
                textEditingController: lastNameController,
                textInputAction: TextInputAction.next,
                labelText: S.current.lbl_last_name,
                required: true,
                hintText: S.current.txt_last_name_hint),
            const SizedBox(
              height: commonPadding,
            ),
            TextFieldWidget.common(
                onChanged: (text) {},
                prefixIconPath: Icons.email_outlined,
                textInputType: TextInputType.emailAddress,
                textEditingController: emailNameController,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                labelText: "Email",
                required: true,
                hintText: S.current.txt_email_hint),
            const SizedBox(
              height: commonPadding,
            ),
            GestureDetector(
              onTap: () async {
                final result = await BottomSheetWidget.show(
                    context: context,
                    body: SelectGenderPage(
                      preGender: gender,
                    ));
                if (result != null) {
                  setState(() {
                    gender = result;
                    genderController.text =
                        GenderHelper.mapEnumToString(result);
                  });
                }
              },
              child: Stack(
                children: [
                  TextFieldWidget.common(
                      onChanged: (text) {},
                      labelText: S.current.lbl_gender,
                      textEditingController: genderController,
                      prefixIconPath: Icons.people_outline,
                      readOnly: true,
                      hintText: S.current.txt_gender_hint),
                  Container(
                    width: MediaQuery.of(context).size.width - 32,
                    height: 80.0,
                    color: Colors.transparent,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: commonPadding,
            ),
            TextFieldWidget.common(
                onChanged: (text) {},
                textEditingController: passwordController,
                prefixIconPath: Icons.lock_outlined,
                textInputAction: TextInputAction.next,
                isObscured: _isHidePassword,
                labelText: S.current.lbl_password,
                required: true,
                maxLines: 1,
                suffixIconPath: _isHidePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                onSuffixIconTap: () {
                  setState(() {
                    _isHidePassword = !_isHidePassword;
                  });
                },
                hintText: S.current.txt_password_hint),
            const SizedBox(
              height: commonPadding,
            ),
            TextFieldWidget.common(
                onChanged: (text) {},
                isObscured: _isHideConfirmPassword,
                textEditingController: confirmPasswordController,
                prefixIconPath: Icons.lock_outlined,
                textInputAction: TextInputAction.done,
                labelText: S.current.lbl_confirm_password,
                required: true,
                maxLines: 1,
                suffixIconPath: _isHideConfirmPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                onSuffixIconTap: () {
                  setState(() {
                    _isHideConfirmPassword = !_isHideConfirmPassword;
                  });
                },
                hintText: S.current.txt_password_hint),
            if (_registerErrorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _registerErrorText!,
                  style: BaseTextStyle.body1(color: BaseColor.red500),
                ),
              ),
            const SizedBox(
              height: commonPadding,
            ),
            ButtonWidget.primary(
                onTap: () => register(), content: S.current.btn_register)
          ],
        ),
      ),
    );
  }

  void clearError() {
    setState(() {
      _registerErrorText = null;
    });
  }

  void resetHidePasswordState() {
    setState(() {
      _isHidePassword = true;
      _isHideConfirmPassword = true;
    });
  }

  void unFocus() {
    FocusScope.of(context).unfocus();
  }

  void register() {
    clearError();
    unFocus();
    resetHidePasswordState();
    getIt.get<RegisterCubit>().register(
        context: context,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailNameController.text,
        gender: gender,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text);
  }
}
