import 'package:either_dart/either.dart';
import 'package:steemit/data/model/user_model.dart';

abstract class UserRepositoryInterface {
  Future<Either<String, void>> updateBio({required String bio});

  Future<Either<String, UserModel>> getCurrentUser();
}
