import 'package:either_dart/either.dart';
import 'package:steemit/generated/l10n.dart';

class ValidationHelper {
  static Either<String, void> validUsername(String username) {
    RegExp validEmail = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (username.isEmpty) return Left(S.current.txt_err_empty_email);
    if (!validEmail.hasMatch(username)) {
      return Left(S.current.txt_err_invalid_email);
    }
    return const Right(null);
  }

  static Either<String, void> validPassword(String password) {
    RegExp moreThan8Char = RegExp(r"^.{8,}$");
    RegExp noSpace = RegExp(r"^(?!.* )");
    if (password.isEmpty) return Left(S.current.txt_err_empty_password);
    if (!noSpace.hasMatch(password)) {
      return Left(S.current.txt_err_have_spacing);
    }
    if (!moreThan8Char.hasMatch(password)) {
      return Left(S.current.txt_err_less_than_8_length);
    }
    return const Right(null);
  }
}
