import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steemit/presentation/bloc/authentication_layer/authentication_cubit.dart';
import 'package:steemit/presentation/bloc/login/login_cubit.dart';
import 'package:steemit/presentation/widget/button/button_widget.dart';
import 'package:steemit/presentation/widget/textfield/textfield_widget.dart';
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
  late AuthenticationCubit authenticationLayerCubit;
  late LoginCubit loginCubit;
  late Stream loginCubitStream;

  bool _isHidePassword = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _usernameErrorText;
  String? _passwordErrorText;
  String? _loginErrorText;

  @override
  void initState() {
    authenticationLayerCubit = BlocProvider.of<AuthenticationCubit>(context);
    loginCubit = BlocProvider.of<LoginCubit>(context);
    loginCubitStream = loginCubit.stream;
    loginCubitStream.listen((event) {
      setState(() {
        _usernameErrorText = null;
        _passwordErrorText = null;
      });
      if (!mounted) return;
      if (event is DisconnectState) {
        setState(() => _loginErrorText =
            "S.current.txt_can_not_connect_server}! {S.current.txt_please_try_again}.");
        return;
      }
      if (event is ErrorState) {
        setState(() => _loginErrorText =
            "{S.current.txt_data_parsing_failed}! {S.current.txt_please_try_again}.");
        return;
      }
      if (event is WrongLoginInfoState) {
        setState(() => _loginErrorText =
            "{S.current.txt_unregistered_username}! or  {S.current.txt_wrong_password}");
        return;
      }
      if (event is InvalidUsernameState) {
        setState(() {
          _usernameErrorText = "${event.content}!";
        });
        return;
      }
      if (event is InvalidPasswordState) {
        setState(() {
          _passwordErrorText = "${event.content}!";
        });
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
            if (_loginErrorText != null)
              Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(_loginErrorText!,
                      style: BaseTextStyle.body2(color: BaseColor.red500))),
            const SizedBox(height: 32),
            ButtonWidget.primary(
              onTap: () => login(),
              content: "Login",
            ),
          ],
        ));
  }

  Future<void> login() async {
    unFocus();
    resetHidePasswordState();
    bool loginResult = await loginCubit.login(
        context: context,
        email: _usernameController.text,
        password: _passwordController.text);
    if (loginResult) {
      authenticationLayerCubit.authenticate();
    }
  }

  void clearPassword() {
    setState(() {
      _passwordController.clear();
    });
  }

  void clearError() {
    setState(() {
      _usernameErrorText = null;
      _passwordErrorText = null;
      _loginErrorText = null;
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
