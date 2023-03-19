import 'package:bloc/bloc.dart';
import 'package:steemit/domain/repository/Implement/authetication_impl.dart';
import 'package:steemit/presentation/bloc/register/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  Future<bool> register(
      {required String firstName,
      required String lastName,
      required String email,
      required String password,
      required String confirmPassword}) async {
    final register = await AuthenticationRepositoryImpl().register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        confirmPassword: confirmPassword);
    if (register.isLeft) {
      emit(RegisterErrorState(message: register.left));
      return false;
    }
    emit(RegisterSuccessState());
    return true;
  }
}
