import 'package:get_it/get_it.dart';
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
import 'package:steemit/presentation/bloc/notification/controller/notification_controller_cubit.dart';
import 'package:steemit/presentation/bloc/notification/data/notifications/notifications_cubit.dart';
import 'package:steemit/presentation/bloc/post/controller/post_controller_cubit.dart';
import 'package:steemit/presentation/bloc/post/data/post/post_cubit.dart';
import 'package:steemit/presentation/bloc/post/data/posts/posts_cubit.dart';
import 'package:steemit/presentation/bloc/post/data/saved_posts/saved_posts_cubit.dart';
import 'package:steemit/presentation/bloc/register/register_cubit.dart';
import 'package:steemit/presentation/bloc/user/controller/user_controller_cubit.dart';
import 'package:steemit/presentation/bloc/user/data/me/me_cubit.dart';
import 'package:steemit/presentation/bloc/user/data/user/user_cubit.dart';
import 'package:steemit/presentation/bloc/user/data/users/users_cubit.dart';

GetIt getIt = GetIt.instance;

void setupGetIt() {
  ///Base
  getIt.registerSingleton<BaseLayerCubit>(BaseLayerCubit());

  ///Authentication
  getIt.registerSingleton<AuthenticationCubit>(AuthenticationCubit());
  getIt.registerSingleton<LoginCubit>(LoginCubit());
  getIt.registerSingleton<RegisterCubit>(RegisterCubit());
  getIt.registerSingleton<ForgotPasswordCubit>(ForgotPasswordCubit());

  ///Post
  getIt.registerSingleton<PostControllerCubit>(PostControllerCubit());
  getIt.registerSingleton<PostsCubit>(PostsCubit());
  getIt.registerSingleton<SavedPostsCubit>(SavedPostsCubit());
  getIt.registerSingleton<PostCubit>(PostCubit());

  ///User
  getIt.registerSingleton<UserControllerCubit>(UserControllerCubit());
  getIt.registerSingleton<MeCubit>(MeCubit());
  getIt.registerSingleton<UserCubit>(UserCubit());
  getIt.registerSingleton<UsersCubit>(UsersCubit());

  ///Download
  getIt.registerSingleton<DownloadCubit>(DownloadCubit());

  ///Comment
  getIt.registerSingleton<CommentCubit>(CommentCubit());
  getIt.registerSingleton<CommentControllerCubit>(CommentControllerCubit());

  ///Location
  getIt.registerSingleton<LocationsCubit>(LocationsCubit());

  ///Activity
  getIt.registerSingleton<ActivitiesCubit>(ActivitiesCubit());
  getIt.registerSingleton<ActivityControllerCubit>(ActivityControllerCubit());

  ///Notification
  getIt.registerSingleton<NotificationControllerCubit>(
      NotificationControllerCubit());
  getIt.registerSingleton<NotificationsCubit>(NotificationsCubit());
}
