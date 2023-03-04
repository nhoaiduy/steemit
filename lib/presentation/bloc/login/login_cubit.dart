import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:steemit/core/failures/login_failures.dart';
import 'package:steemit/domain/repository/Implement/authetication_impl.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());

  Future<bool> login(
      {required BuildContext context,
      required String email,
      required String password}) async {
    Either<AuthenticationFailures, String> loginRepository =
        await AuthenticationRepositoryImpl()
            .login(email: email, password: password);

    if (loginRepository.isLeft) {
      if (loginRepository.left is ServerFailures) {
        emit(DisconnectState());
        return false;
      }
      if (loginRepository.left is WrongLoginInfoFailures) {
        emit(WrongLoginInfoState());
        return false;
      }
      if (loginRepository.left is EmptyUsernameFailures) {
        emit(InvalidUsernameState("Please enter your email"));
        return false;
      }
      if (loginRepository.left is InvalidEmailFailures) {
        emit(InvalidUsernameState("Invalid email"));
        return false;
      }
      if (loginRepository.left is EmptyPasswordFailures) {
        emit(InvalidPasswordState("Please enter your password"));
        return false;
      }
      if (loginRepository.left is SpacingPasswordFailures) {
        emit(InvalidPasswordState("S.current.txt_err_no_space_password"));
        return false;
      }
      if (loginRepository.left is LessThan8CharsPasswordFailures) {
        emit(InvalidPasswordState("S.current.txt_err_less_8_chars_password"));
        return false;
      }
      emit(ErrorState());
      return false;
    }
    return true;
  }
}
