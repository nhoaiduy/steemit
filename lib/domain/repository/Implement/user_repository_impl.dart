import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:steemit/data/model/activity_model.dart';
import 'package:steemit/data/model/user_model.dart';
import 'package:steemit/data/service/authentication_service.dart';
import 'package:steemit/data/service/database_service.dart';
import 'package:steemit/domain/repository/Implement/post_impl.dart';
import 'package:steemit/domain/repository/Interface/i_user.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/util/enum/activity_enum.dart';

class UserRepository extends UserRepositoryInterface {
  @override
  Future<Either<String, void>> updateBio({required String bio}) async {
    if (bio.isEmpty) {
      return Left(S.current.txt_empty_bio);
    }
    try {
      await databaseService.updateBio(bio: bio, uid: authService.getUserId());
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(e.message!);
    }
  }

  @override
  Future<Either<String, UserModel>> getCurrentUser() async {
    try {
      final response =
          await databaseService.getUser(uid: authService.getUserId());
      return Right(response);
    } on FirebaseException catch (e) {
      return Left(e.message!);
    }
  }

  @override
  Future<Either<String, UserModel>> getUserById(
      {required String userId}) async {
    try {
      final response = await databaseService.getUser(uid: userId);
      return Right(response);
    } on FirebaseException catch (e) {
      return Left(e.message!);
    }
  }

  @override
  Future<Either<String, List<UserModel>>> getAllUsers() async {
    try {
      final response = await databaseService.getAllUsers();
      return Right(response);
    } on FirebaseException catch (e) {
      return Left(e.message!);
    }
  }

  @override
  Future<Either<void, List<ActivityModel>>> getActivities() async {
    final List<ActivityModel> activities = List.empty(growable: true);
    final List<ActivityModel> error = List.empty(growable: true);
    try {
      final response =
          await databaseService.getActivities(userId: authService.getUserId());
      activities.addAll(response);
    } on FirebaseException {
      return const Left(null);
    }
    for (var activity in activities) {
      final post = await PostRepository().getPostById(postId: activity.postId!);
      if (post.isLeft) {
        error.add(activity);
        continue;
      }
      activity.post = post.right;
      activity.user = activity.post?.user;
    }
    activities.removeWhere((e) => error.contains(e));
    return Right(activities);
  }

  @override
  Future<Either<void, void>> addActivity(
      {required String postId, required ActivityEnum type}) async {
    try {
      await databaseService.addActivity(postId, authService.getUserId(), type);
      return const Right(null);
    } on FirebaseException {
      return const Left(null);
    }
  }
}
