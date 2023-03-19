import 'package:either_dart/src/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:steemit/data/model/user_model.dart';
import 'package:steemit/data/service/authentication_service.dart';
import 'package:steemit/data/service/database_service.dart';
import 'package:steemit/domain/repository/Interface/i_authentication.dart';
import 'package:steemit/util/helper/login_helper.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepositoryInterface {
  @override
  bool authenticate() {
    final result = authService.authenticate();
    return result;
  }

  @override
  Future<Either<String, void>> login(
      {required String email, required String password}) async {
    try {
      Either<String, void> validUsername =
          ValidationHelper.validUsername(email);
      if (validUsername.isLeft) return Left(validUsername.left);

      Either<String, void> validPassword =
          ValidationHelper.validPassword(password);
      if (validPassword.isLeft) return Left(validPassword.left);
      final result = await authService.login(email: email, password: password);

      ///TODO: get user data
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(e.message!);
    }
  }

  @override
  Future<void> logout() async {
    await authService.logout();
  }

  @override
  Future<Either<String, void>> register(
      {required String firstName,
      required String lastName,
      required String email,
      required String password,
      required String confirmPassword}) async {
    if (firstName.isEmpty) {
      return Left("Please enter your first name");
    }

    if (lastName.isEmpty) {
      return Left("Please enter your last name");
    }

    Either<String, void> validEmail = ValidationHelper.validUsername(email);
    if (validEmail.isLeft) {
      return Left(validEmail.left);
    }

    Either<String, void> validPassword =
        ValidationHelper.validPassword(password);
    if (validPassword.isLeft) {
      return Left(validPassword.left);
    }

    if (password != confirmPassword) {
      return Left("Password is mismatch");
    }
    String uid = "";
    try {
      uid = await authService.register(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return Left(e.message!);
    }

    UserModel userModel = UserModel(
        id: uid, email: email, firstName: firstName, lastName: lastName);

    try {
      await databaseService.setUser(userModel: userModel);
    } on FirebaseException catch (e) {
      return Left(e.message!);
    }
    return const Right(null);
  }
}
