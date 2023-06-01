import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:steemit/domain/repository/Implement/authetication_impl.dart';
import 'package:steemit/presentation/bloc/register/register_state.dart';
import 'package:steemit/util/controller/loading_cover_controller.dart';
import 'package:steemit/util/enum/gender_enum.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  Future<bool> register(
      {required String firstName,
      required String lastName,
      required String email,
      required String password,
      required String confirmPassword,
      required BuildContext context,
      Gender? gender}) async {
    LoadingCoverController.instance.common(context);
    final register = await AuthenticationRepositoryImpl().register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        gender: gender,
        confirmPassword: confirmPassword);
    if (register.isLeft) {
      emit(RegisterErrorState(message: register.left));
      return false;
    }
    emit(RegisterSuccessState());
    return true;
  }
}
