import 'package:either_dart/either.dart';

abstract class AuthenticationRepositoryInterface {
  bool authenticate();

  Future<Either<String, void>> login(
      {required String email, required String password});

  void logout();

  Future<Either<String, void>> register(
      {required String firstName, required String lastName, required String email, required String password, required String confirmPassword});
}
