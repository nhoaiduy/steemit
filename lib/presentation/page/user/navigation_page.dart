import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steemit/presentation/bloc/authentication_layer/authentication_cubit.dart';
import 'package:steemit/util/style/base_text_style.dart';

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
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () => logout(),
          child: Text(
            "Logout",
            style: BaseTextStyle.body1(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Future<void> logout() async {
    authenticationCubit.logout();
  }
}
