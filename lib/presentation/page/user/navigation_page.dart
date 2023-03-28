import 'package:flutter/material.dart';
import 'package:steemit/presentation/page/user/home/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steemit/presentation/bloc/authentication_layer/authentication_cubit.dart';


class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentIndex = 0;
  late AuthenticationCubit authenticationCubit;

  @override
  void initState() {
    authenticationCubit = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }

  Future<void> logout() async {
    authenticationCubit.logout();
  }
}
