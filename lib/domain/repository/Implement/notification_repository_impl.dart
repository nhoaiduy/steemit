import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:steemit/data/model/notification_model.dart';
import 'package:steemit/data/service/authentication_service.dart';
import 'package:steemit/data/service/database_service.dart';
import 'package:steemit/data/service/notification_service.dart';
import 'package:steemit/domain/repository/Interface/i_notification.dart';
import 'package:steemit/util/enum/activity_enum.dart';
import 'package:uuid/uuid.dart';

class NotificationRepository extends NotificationRepositoryInterface {
  final Uuid _uuid = const Uuid();

  @override
  Future<Either<void, void>> addNotification(
      String postId, ActivityEnum type) async {
    try {
      final NotificationModel notificationModel = NotificationModel(
          id: _uuid.v1(),
          postId: postId,
          userId: authService.getUserId(),
          createdAt: Timestamp.now(),
          type: type);
      final postModel = await databaseService.getPostById(postId: postId);
      final user = postModel.user!;
      final me = await databaseService.getUser(uid: authService.getUserId());
      final message = type == ActivityEnum.comment
          ? "${me.firstName} ${me.lastName} vừa bình luận vào bài viết của bạn"
          : "${me.firstName} ${me.lastName} vừa thích bài viết của bạn";
      await databaseService.addNotification(
          notificationModel, postModel.userId!);
      await notificationService.sendPushMessage(user.token, message, postId);
      return const Right(null);
    } catch (e) {
      return const Left(null);
    }
  }

  @override
  Future<Either<void, List<NotificationModel>>> getNotifications() async {
    try {
      final response = await databaseService.getNotifications(
          userId: authService.getUserId());
      return Right(response);
    } catch (e) {
      return const Left(null);
    }
  }
}
