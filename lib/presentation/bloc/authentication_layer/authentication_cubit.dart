import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:steemit/domain/repository/Implement/authetication_impl.dart';
import 'package:steemit/presentation/bloc/authentication_layer/authentication_state.dart';
import 'package:steemit/util/controller/loading_cover_controller.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthInitialState());

  Future<void> authenticate([State? state]) async {
    if (state is AuthInitialState) {
      await Future.delayed(const Duration(seconds: 4));
    }
    final authRepository = AuthenticationRepositoryImpl().authenticate();
    if (authRepository) {
      emit(AuthenticatedState());
    } else {
      emit(UnauthenticatedState());
    }
    if (state != null && state.mounted) {
      LoadingCoverController.instance.close(state.context);
    }
  }

  Future<void> logout() async {
    await AuthenticationRepositoryImpl().logout();
    emit(UnauthenticatedState());
  }
}
