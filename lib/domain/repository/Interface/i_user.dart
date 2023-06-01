import 'package:either_dart/either.dart';
import 'package:steemit/data/model/activity_model.dart';
import 'package:steemit/data/model/user_model.dart';
import 'package:steemit/util/enum/activity_enum.dart';

abstract class UserRepositoryInterface {
  Future<Either<String, List<UserModel>>> getAllUsers();

  Future<Either<String, void>> updateBio({required String bio});

  Future<Either<String, UserModel>> getCurrentUser();

  Future<Either<String, UserModel>> getUserById({required String userId});

  Future<Either<void, List<ActivityModel>>> getActivities();

  Future<Either<void, void>> addActivity(
      {required String postId, required ActivityEnum type});
}
