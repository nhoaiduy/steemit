import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:steemit/domain/repository/Implement/notification_repository_impl.dart';
import 'package:steemit/util/enum/activity_enum.dart';

part 'notification_controller_state.dart';

class NotificationControllerCubit extends Cubit<NotificationControllerState> {
  NotificationControllerCubit() : super(NotificationControllerInitial());

  Future<void> addNotification(String postId, ActivityEnum type) async {
    final response =
        await NotificationRepository().addNotification(postId, type);

    if (response.isLeft) {
      emit(NotificationControllerFailure());
      return;
    }

    emit(NotificationControllerSuccess());
  }

  void clean() => emit(NotificationControllerInitial());
}
