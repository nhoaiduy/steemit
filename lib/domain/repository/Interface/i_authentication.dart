import 'package:either_dart/either.dart';
import 'package:steemit/core/failures/failures.dart';
import 'package:steemit/core/failures/login_failures.dart';

abstract class AuthenticationRepositoryInterface {
  Either<Failures, bool> authenticate();

  Future<Either<AuthenticationFailures, String>> login(
      {required String email, required String password});
}
