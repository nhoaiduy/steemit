import 'package:flutter/material.dart';
import 'package:steemit/presentation/page/user/home/home_screen.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
