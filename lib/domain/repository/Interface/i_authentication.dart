import 'package:either_dart/either.dart';
import 'package:steemit/data/model/user_model.dart';

abstract class AuthenticationRepositoryInterface {
  bool authenticate();

  Future<Either<String, void>> login(
      {required String email, required String password});

  Future<Either<String, UserModel>> getCurrentUser();

  void logout();

  Future<Either<String, void>> register(
      {required String firstName,
      required String lastName,
      required String email,
      required String password,
      required String confirmPassword});
}
