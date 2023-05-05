import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:steemit/data/model/user_model.dart';
import 'package:steemit/domain/repository/Implement/user_repository_impl.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial());

  Future<void> getData() async {
    final response = await UserRepositoryImplement().getAllUsers();
    if (response.isLeft) {
      emit(UsersFailure(response.left));
      return;
    }
    emit(UsersSuccess(response.right));
  }
}
