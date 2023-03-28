import 'package:either_dart/either.dart';

class ValidationHelper {
  static Either<String, void> validUsername(String username) {
    RegExp validEmail = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (username.isEmpty) return const Left("Please enter your email");
    if (!validEmail.hasMatch(username)) {
      return const Left("Invalid email");
    }
    return const Right(null);
  }

  static Either<String, void> validPassword(String password) {
    RegExp moreThan8Char = RegExp(r"^.{8,}$");
    RegExp noSpace = RegExp(r"^(?!.* )");
    if (password.isEmpty) return const Left("Please enter your password");
    if (!noSpace.hasMatch(password)) {
      return const Left("Password can't contain space");
    }
    if (!moreThan8Char.hasMatch(password)) {
      return const Left("Password must be more than 8 chars length");
    }
    return const Right(null);
  }
}
