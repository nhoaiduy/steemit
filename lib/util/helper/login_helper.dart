import 'package:either_dart/either.dart';
import 'package:steemit/core/failures/login_failures.dart';

class LoginHelper {
  static Either<AuthenticationFailures, void> validUsername(String username) {
    RegExp validEmail = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (username.isEmpty) return Left(EmptyUsernameFailures());
    if (!validEmail.hasMatch(username)) {
      return Left(InvalidEmailFailures());
    }
    return const Right(null);
  }

  static Either<AuthenticationFailures, void> validPassword(String password) {
    RegExp moreThan8Char = RegExp(r"^.{8,}$");
    RegExp noSpace = RegExp(r"^(?!.* )");
    if (password.isEmpty) return Left(EmptyPasswordFailures());
    if (!noSpace.hasMatch(password)) {
      return Left(SpacingPasswordFailures());
    }
    if (!moreThan8Char.hasMatch(password)) {
      return Left(LessThan8CharsPasswordFailures());
    }
    return const Right(null);
  }
}
