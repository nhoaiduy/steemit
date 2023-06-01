import 'package:either_dart/either.dart';
import 'package:steemit/data/model/notification_model.dart';
import 'package:steemit/util/enum/activity_enum.dart';

abstract class NotificationRepositoryInterface {
  Future<Either<void, void>> addNotification(String postId, ActivityEnum type);

  Future<Either<void, List<NotificationModel>>> getNotifications();
}
