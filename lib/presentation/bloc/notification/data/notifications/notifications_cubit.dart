import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:steemit/data/model/notification_model.dart';
import 'package:steemit/domain/repository/Implement/notification_repository_impl.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  Future<void> getData() async {
    final response = await NotificationRepository().getNotifications();

    if (response.isLeft) {
      emit(NotificationsFailure());
      return;
    }

    emit(NotificationsSuccess(response.right));
  }

  void clean() => emit(NotificationsInitial());
}
