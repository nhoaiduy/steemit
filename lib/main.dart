import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steemit/presentation/bloc/authentication_layer/authentication_cubit.dart';
import 'package:steemit/presentation/bloc/base_layer/base_layer_cubit.dart';
import 'package:steemit/presentation/bloc/login/login_cubit.dart';
import 'package:steemit/presentation/bloc/post/controller/post_controller_cubit.dart';
import 'package:steemit/presentation/bloc/post/data/posts/posts_cubit.dart';
import 'package:steemit/presentation/bloc/register/register_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/page/base_layer/base_layer_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider.value(value: getIt.get<AuthenticationCubit>()),
      BlocProvider.value(value: getIt.get<BaseLayerCubit>()),
      BlocProvider.value(value: getIt.get<LoginCubit>()),
      BlocProvider.value(value: getIt.get<RegisterCubit>()),
      BlocProvider.value(value: getIt.get<PostControllerCubit>()),
      BlocProvider.value(value: getIt.get<PostsCubit>()),
    ], child: const BaseLayer());
  }
}
