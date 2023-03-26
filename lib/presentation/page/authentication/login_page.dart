import 'package:flutter/material.dart';
import 'package:steemit/presentation/bloc/authentication_layer/authentication_cubit.dart';
import 'package:steemit/presentation/bloc/login/login_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/page/authentication/regisster_page.dart';
import 'package:steemit/presentation/widget/button/button_widget.dart';
import 'package:steemit/presentation/widget/textfield/textfield_widget.dart';
import 'package:steemit/util/controller/loading_cover_controller.dart';
import 'package:steemit/util/path/image_path.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_image.dart';
import 'package:steemit/util/style/base_text_style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isHidePassword = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _usernameErrorText = "";
  String _passwordErrorText = "";
  String _loginErrorText = "";

  @override
  void initState() {
    getIt.get<LoginCubit>().stream.listen((event) {
      if (!mounted) return;
      if (event is LoginFailureState) {
        setState(() => _loginErrorText = event.message);
        return;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            buildBottomArea(),
            SingleChildScrollView(
              child: Column(
                children: [
                  buildTopArea(),
                  buildBodyArea(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTopArea() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        alignment: Alignment.center,
        child: BaseImage.base(ImagePath.appIcon,
            height: 28, boxFit: BoxFit.fitHeight));
  }

  Widget buildBodyArea() {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFieldWidget.common(
              onChanged: (value) {},
              hintText: "Enter your email",
              textEditingController: _usernameController,
              errorText: _usernameErrorText,
              prefixIconPath: Icons.email_outlined,
            ),
            const SizedBox(height: 24),
            TextFieldWidget.common(
              onChanged: (value) {},
              hintText: "Enter your password",
              isObscured: _isHidePassword,
              textEditingController: _passwordController,
              errorText: _passwordErrorText,
              prefixIconPath: Icons.lock_outlined,
              suffixIconPath: _isHidePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              onSuffixIconTap: () => setState(() {
                _isHidePassword = !_isHidePassword;
              }),
            ),
            if (_loginErrorText.isNotEmpty)
              Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(_loginErrorText,
                      style: BaseTextStyle.body2(color: BaseColor.red500))),
            const SizedBox(height: 32),
            ButtonWidget.primary(
              onTap: () => login(),
              content: "Login",
            ),
          ],
        ));
  }

  Widget buildBottomArea() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.vertical -
                48.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Create new account?",
                style: BaseTextStyle.body1(),
              ),
              const SizedBox(
                width: 4.0,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RegisterPage())),
                child: Text(
                  "Register",
                  style: BaseTextStyle.label(color: BaseColor.green500),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> login() async {
    unFocus();
    resetHidePasswordState();
    clearError();
    bool loginResult = await getIt.get<LoginCubit>().login(
        context: context,
        email: _usernameController.text,
        password: _passwordController.text);
    if (loginResult) {
      getIt.get<AuthenticationCubit>().authenticate(this);
    } else {
      if (mounted) LoadingCoverController.instance.close(context);
    }
  }

  void clearError() {
    setState(() {
      _usernameErrorText = "";
      _passwordErrorText = "";
      _loginErrorText = "";
    });
  }

  void resetHidePasswordState() {
    setState(() {
      _isHidePassword = true;
    });
  }

  void updateHidePasswordState() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  void unFocus() {
    FocusScope.of(context).unfocus();
  }
}
