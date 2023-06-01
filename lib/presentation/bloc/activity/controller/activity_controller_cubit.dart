import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:steemit/domain/repository/Implement/user_repository_impl.dart';
import 'package:steemit/util/enum/activity_enum.dart';

part 'activity_controller_state.dart';

class ActivityControllerCubit extends Cubit<ActivityControllerState> {
  ActivityControllerCubit() : super(ActivityControllerInitial());

  Future<void> addComment(
      {required String postId, required ActivityEnum type}) async {
    final response =
        await UserRepository().addActivity(postId: postId, type: type);
    if (response.isLeft) {
      emit(ActivityControllerFailure());
      return;
    }
    emit(ActivityControllerSuccess());
  }

  void clean() => emit(ActivityControllerInitial());
}
