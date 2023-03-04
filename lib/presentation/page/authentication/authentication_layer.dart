import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steemit/presentation/bloc/authentication_layer/authentication_cubit.dart';
import 'package:steemit/presentation/bloc/authentication_layer/authentication_state.dart';
import 'package:steemit/presentation/page/authentication/login_page.dart';
import 'package:steemit/presentation/page/common/app_loading_page.dart';
import 'package:steemit/presentation/page/user/navigation_page.dart';

class AuthenticationLayerPage extends StatefulWidget {
  const AuthenticationLayerPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationLayerPage> createState() =>
      _AuthenticationLayerPageState();
}

class _AuthenticationLayerPageState extends State<AuthenticationLayerPage> {
  late AuthenticationCubit authenticationCubit;
  late Stream authenticationStream;

  @override
  void initState() {
    authenticationCubit = BlocProvider.of<AuthenticationCubit>(context)
      ..authenticate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        if (state is UnauthenticatedState) {
          return const LoginPage();
        }
        if (state is AuthenticatedState) {
          return const NavigationPage();
        }
        return const AppLoadingPage();
      },
    );
  }
}
