import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:steemit/domain/repository/Implement/authetication_impl.dart';
import 'package:steemit/util/controller/loading_cover_controller.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  Future<bool> login(
      {required BuildContext context,
      required String email,
      required String password}) async {
    LoadingCoverController.instance.common(context);
    Either<String, void> loginRepository = await AuthenticationRepositoryImpl()
        .login(email: email, password: password);

    if (loginRepository.isLeft) {
      emit(LoginFailureState(message: loginRepository.left));
      return false;
    }

    emit(LoginSuccessState());
    return true;
  }
}
