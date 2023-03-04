import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:steemit/presentation/page/common/app_loading_page.dart';
import 'package:steemit/util/style/base_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Steemit',
      theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: BaseColor.grey20),
      home: const AppLoadingPage(),
    );
  }
}
