import 'package:get_it/get_it.dart';
import 'package:steemit/presentation/bloc/authentication_layer/authentication_cubit.dart';
import 'package:steemit/presentation/bloc/login/login_cubit.dart';
import 'package:steemit/presentation/bloc/register/register_cubit.dart';

GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AuthenticationCubit>(AuthenticationCubit());
  getIt.registerSingleton<LoginCubit>(LoginCubit());
  getIt.registerSingleton<RegisterCubit>(RegisterCubit());
}
