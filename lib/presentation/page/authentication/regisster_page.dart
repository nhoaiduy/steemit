import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steemit/presentation/bloc/register/register_cubit.dart';
import 'package:steemit/presentation/bloc/register/register_state.dart';
import 'package:steemit/presentation/widget/button/button_widget.dart';
import 'package:steemit/presentation/widget/textfield/textfield_widget.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

const double commonPadding = 16.0;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final RegisterCubit registerCubit;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String _registerErrorText = "";

  bool _isHidePassword = true;
  bool _isHideConfirmPassword = true;

  @override
  void initState() {
    registerCubit = BlocProvider.of<RegisterCubit>(context);
    registerCubit.stream.listen((event) {
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
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(commonPadding),
        child: Column(
          children: [
            TextFieldWidget.common(
                onChanged: (text) {},
                textEditingController: firstNameController,
                textInputAction: TextInputAction.next,
                prefixIconPath: Icons.text_fields_outlined,
                hintText: "First name"),
            const SizedBox(
              height: commonPadding,
            ),
            TextFieldWidget.common(
                onChanged: (text) {},
                prefixIconPath: Icons.text_fields_outlined,
                textEditingController: lastNameController,
                textInputAction: TextInputAction.next,
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
                hintText: "Email"),
            const SizedBox(
              height: commonPadding,
            ),
            TextFieldWidget.common(
                onChanged: (text) {},
                textEditingController: passwordController,
                prefixIconPath: Icons.lock_outlined,
                textInputAction: TextInputAction.next,
                isObscured: _isHidePassword,
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
              Text(
                _registerErrorText,
                style: BaseTextStyle.body1(color: BaseColor.red500),
              ),
            const SizedBox(
              height: commonPadding,
            ),
            ButtonWidget.primary(onTap: () => register(), content: "Sign up")
          ],
        ),
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
    registerCubit.register(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailNameController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text);
  }
}
