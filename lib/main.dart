import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steemit/presentation/bloc/activity/controller/activity_controller_cubit.dart';
import 'package:steemit/presentation/bloc/activity/data/activities/activities_cubit.dart';
import 'package:steemit/presentation/bloc/authentication_layer/authentication_cubit.dart';
import 'package:steemit/presentation/bloc/base_layer/base_layer_cubit.dart';
import 'package:steemit/presentation/bloc/comment/controller/comment_controller_cubit.dart';
import 'package:steemit/presentation/bloc/comment/data/comment_cubit.dart';
import 'package:steemit/presentation/bloc/download/download_cubit.dart';
import 'package:steemit/presentation/bloc/forgot_passeord/forgot_password_cubit.dart';
import 'package:steemit/presentation/bloc/location/data/locations/locations_cubit.dart';
import 'package:steemit/presentation/bloc/login/login_cubit.dart';
import 'package:steemit/presentation/bloc/post/controller/post_controller_cubit.dart';
import 'package:steemit/presentation/bloc/post/data/post/post_cubit.dart';
import 'package:steemit/presentation/bloc/post/data/posts/posts_cubit.dart';
import 'package:steemit/presentation/bloc/post/data/saved_posts/saved_posts_cubit.dart';
import 'package:steemit/presentation/bloc/register/register_cubit.dart';
import 'package:steemit/presentation/bloc/user/controller/user_controller_cubit.dart';
import 'package:steemit/presentation/bloc/user/data/me/me_cubit.dart';
import 'package:steemit/presentation/bloc/user/data/user/user_cubit.dart';
import 'package:steemit/presentation/bloc/user/data/users/users_cubit.dart';
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
      ///Base
      BlocProvider.value(value: getIt.get<BaseLayerCubit>()),

      ///Authentication
      BlocProvider.value(value: getIt.get<AuthenticationCubit>()),
      BlocProvider.value(value: getIt.get<LoginCubit>()),
      BlocProvider.value(value: getIt.get<RegisterCubit>()),
      BlocProvider.value(value: getIt.get<ForgotPasswordCubit>()),

      ///Post
      BlocProvider.value(value: getIt.get<PostControllerCubit>()),
      BlocProvider.value(value: getIt.get<PostsCubit>()),
      BlocProvider.value(value: getIt.get<SavedPostsCubit>()),
      BlocProvider.value(value: getIt.get<PostCubit>()),

      ///User
      BlocProvider.value(value: getIt.get<UserControllerCubit>()),
      BlocProvider.value(value: getIt.get<MeCubit>()),
      BlocProvider.value(value: getIt.get<UserCubit>()),
      BlocProvider.value(value: getIt.get<UsersCubit>()),

      ///Download
      BlocProvider.value(value: getIt.get<DownloadCubit>()),

      ///Comment
      BlocProvider.value(value: getIt.get<CommentCubit>()),
      BlocProvider.value(value: getIt.get<CommentControllerCubit>()),

      ///Location
      BlocProvider.value(value: getIt.get<LocationsCubit>()),

      ///Activity
      BlocProvider.value(value: getIt.get<ActivitiesCubit>()),
      BlocProvider.value(value: getIt.get<ActivityControllerCubit>()),
    ], child: const BaseLayer());
  }
}
