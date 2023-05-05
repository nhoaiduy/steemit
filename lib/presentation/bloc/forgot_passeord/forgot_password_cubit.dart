import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:steemit/domain/repository/Implement/authetication_impl.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  Future<void> resetPassword({required String email}) async {
    final response =
    await AuthenticationRepositoryImpl().resetPassword(email: email);
    if (response.isLeft) {
      emit(ForgotPasswordFailure(response.left));
      return;
    }

    emit(ForgotPasswordSuccess());
  }

  void clean() => emit(ForgotPasswordInitial());
}
