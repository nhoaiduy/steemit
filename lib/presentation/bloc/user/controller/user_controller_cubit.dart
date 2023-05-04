import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:steemit/domain/repository/Implement/user_repository_impl.dart';

part 'user_controller_state.dart';

class UserControllerCubit extends Cubit<UserControllerState> {
  UserControllerCubit() : super(UserControllerInitial());

  Future<void> updateBio({required String bio}) async {
    final response = await UserRepositoryImplement().updateBio(bio: bio);
    if (response.isLeft) {
      emit(UserControllerFailure(response.left));
      return;
    }
    emit(UserControllerSuccess());
  }

  void clean() => emit(UserControllerInitial());
}
