import 'package:flutter/material.dart';
import 'package:steemit/presentation/bloc/register/register_cubit.dart';
import 'package:steemit/presentation/bloc/register/register_state.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/page/setting/select_gender_page.dart';
import 'package:steemit/presentation/widget/bottom_sheet/bottom_sheet_widget.dart';
import 'package:steemit/presentation/widget/button/button_widget.dart';
import 'package:steemit/presentation/widget/textfield/textfield_widget.dart';
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

  String _registerErrorText = "";

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
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(), body: _body());
  }

  _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.chevron_left,
          size: 36.0,
          color: BaseColor.green500,
        ),
      ),
      title: const Text(
        "Sign Up",
        style: TextStyle(color: BaseColor.green500),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  _body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(commonPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldWidget.common(
              onChanged: (text) {},
              textEditingController: firstNameController,
              textInputAction: TextInputAction.next,
              prefixIconPath: Icons.text_fields_outlined,
              labelText: "First name",
              required: true,
              hintText: "First name"),
          const SizedBox(
            height: commonPadding,
          ),
          TextFieldWidget.common(
              onChanged: (text) {},
              prefixIconPath: Icons.text_fields_outlined,
              textEditingController: lastNameController,
              textInputAction: TextInputAction.next,
              labelText: "Last name",
              required: true,
              hintText: "Last name"),
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
              hintText: "Email"),
          const SizedBox(
            height: commonPadding,
          ),
          GestureDetector(
            onTap: () async {
              final result = await BottomSheetWidget.base(
                  context: context,
                  body: SelectGenderPage(
                    preGender: gender,
                  ));
              if (result != null) {
                setState(() {
                  gender = result;
                  genderController.text = GenderHelper.mapEnumToString(result);
                });
              }
            },
            child: Stack(
              children: [
                TextFieldWidget.common(
                    onChanged: (text) {},
                    labelText: "Gender",
                    textEditingController: genderController,
                    prefixIconPath: Icons.people_outline,
                    readOnly: true,
                    hintText: "Gender"),
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
              labelText: "Password",
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
              hintText: "Password"),
          const SizedBox(
            height: commonPadding,
          ),
          TextFieldWidget.common(
              onChanged: (text) {},
              isObscured: _isHideConfirmPassword,
              textEditingController: confirmPasswordController,
              prefixIconPath: Icons.lock_outlined,
              textInputAction: TextInputAction.done,
              labelText: "Confirm password",
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
              hintText: "Confirm password"),
          if (_registerErrorText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                _registerErrorText,
                style: BaseTextStyle.body1(color: BaseColor.red500),
              ),
            ),
          const SizedBox(
            height: commonPadding,
          ),
          ButtonWidget.primary(onTap: () => register(), content: "Sign up")
        ],
      ),
    );
  }

  void clearError() {
    setState(() {
      _registerErrorText = "";
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
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailNameController.text,
        gender: gender,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text);
  }
}
