import 'package:either_dart/either.dart';

abstract class UserRepositoryInterface {
  Future<Either<String, void>> updateBio({required String bio});
}
