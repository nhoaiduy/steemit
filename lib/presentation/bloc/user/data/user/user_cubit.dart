import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:steemit/data/model/user_model.dart';
import 'package:steemit/domain/repository/Implement/user_repository_impl.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> getData({required String userId}) async {
    final response = await UserRepository().getUserById(userId: userId);
    if (response.isLeft) {
      emit(UserFailure(response.left));
      return;
    }
    emit(UserSuccess(response.right));
  }

  void clean() => emit(UserInitial());
}
