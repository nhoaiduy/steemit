import 'package:either_dart/src/either.dart';
import 'package:steemit/core/exception/common_exception.dart';
import 'package:steemit/core/failures/common_failures.dart' as common;
import 'package:steemit/core/failures/failures.dart';
import 'package:steemit/core/failures/login_failures.dart' as login_failures;
import 'package:steemit/core/failures/login_failures.dart';
import 'package:steemit/data/service/authentication_service.dart';
import 'package:steemit/domain/repository/Interface/i_authentication.dart';
import 'package:steemit/util/helper/login_helper.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepositoryInterface {
  @override
  Either<Failures, bool> authenticate() {
    final result = authService.authenticate();
    if (result.isLeft) {
      if (result.left is ServerException) {
        return Left(common.ServerFailures());
      }
      if (result.left is AuthorizationException) {
        return Left(common.AuthorizationFailures());
      }
      if (result.left is ResponseException) {
        return Left(common.ResponseDataParsingFailures());
      }
      return Left(common.DataParsingFailures());
    }

    return Right(result.right);
  }

  @override
  Future<Either<login_failures.AuthenticationFailures, String>> login(
      {required String email, required String password}) async {
    try {
      Either<AuthenticationFailures, void> validUsername =
          LoginHelper.validUsername(email);
      if (validUsername.isLeft) return Left(validUsername.left);

      Either<AuthenticationFailures, void> validPassword =
          LoginHelper.validPassword(password);
      if (validPassword.isLeft) return Left(validPassword.left);

      final result = await authService.login(email: email, password: password);
      return Right(result.right);
    } catch (e) {
      if (e is ServerException) {
        return Left(login_failures.ServerFailures());
      }
      if (e is AuthorizationException) {
        return Left(login_failures.WrongLoginInfoFailures());
      }
      return Left(login_failures.DataParsingFailures());
    }
  }
}
