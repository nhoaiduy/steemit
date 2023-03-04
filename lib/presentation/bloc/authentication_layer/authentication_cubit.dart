import 'package:bloc/bloc.dart';
import 'package:steemit/domain/repository/Implement/authetication_impl.dart';
import 'package:steemit/presentation/bloc/authentication_layer/authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthInitialState());

  Future<void> authenticate() async {
    await Future.delayed(const Duration(seconds: 4));
    final authRepository = AuthenticationRepositoryImpl().authenticate();

    if (authRepository.isLeft) {
      emit(ErrorState());
      return;
    }

    if (authRepository.right) {
      emit(AuthenticatedState());
      return;
    }
    emit(UnauthenticatedState());
  }
}
