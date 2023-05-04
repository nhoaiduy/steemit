import 'package:get_it/get_it.dart';
import 'package:steemit/presentation/bloc/authentication_layer/authentication_cubit.dart';
import 'package:steemit/presentation/bloc/base_layer/base_layer_cubit.dart';
import 'package:steemit/presentation/bloc/forgot_passeord/forgot_password_cubit.dart';
import 'package:steemit/presentation/bloc/login/login_cubit.dart';
import 'package:steemit/presentation/bloc/post/controller/post_controller_cubit.dart';
import 'package:steemit/presentation/bloc/post/data/posts/posts_cubit.dart';
import 'package:steemit/presentation/bloc/register/register_cubit.dart';

GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AuthenticationCubit>(AuthenticationCubit());
  getIt.registerSingleton<LoginCubit>(LoginCubit());
  getIt.registerSingleton<RegisterCubit>(RegisterCubit());
  getIt.registerSingleton<PostControllerCubit>(PostControllerCubit());
  getIt.registerSingleton<PostsCubit>(PostsCubit());
  getIt.registerSingleton<BaseLayerCubit>(BaseLayerCubit());
  getIt.registerSingleton<ForgotPasswordCubit>(ForgotPasswordCubit());
}
