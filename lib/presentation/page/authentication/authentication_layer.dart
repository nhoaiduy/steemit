import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steemit/presentation/bloc/authentication_layer/authentication_cubit.dart';
import 'package:steemit/presentation/bloc/authentication_layer/authentication_state.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/page/authentication/login_page.dart';
import 'package:steemit/presentation/page/common/app_loading_page.dart';
import 'package:steemit/presentation/page/navigation/navigation_page.dart';

class AuthenticationLayerPage extends StatefulWidget {
  const AuthenticationLayerPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationLayerPage> createState() =>
      _AuthenticationLayerPageState();
}

class _AuthenticationLayerPageState extends State<AuthenticationLayerPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const NavigationPage();
    //   BlocBuilder<AuthenticationCubit, AuthenticationState>(
    //   bloc: getIt.get<AuthenticationCubit>()..authenticate(),
    //   builder: (context, state) {
    //     if (state is UnauthenticatedState) {
    //       return const LoginPage();
    //     }
    //     if (state is AuthenticatedState) {
    //       return const NavigationPage();
    //     }
    //     return const AppLoadingPage();
    //   },
    // );
  }
}
