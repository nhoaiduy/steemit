import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:steemit/data/model/user_model.dart';
import 'package:steemit/data/service/authentication_service.dart';
import 'package:steemit/data/service/database_service.dart';
import 'package:steemit/domain/repository/Interface/i_authentication.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/util/enum/gender_enum.dart';
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
      await authService.login(email: email, password: password);
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
      required String confirmPassword,
      Gender? gender}) async {
    if (firstName.isEmpty) {
      return Left(S.current.txt_err_empty_first_name);
    }

    if (lastName.isEmpty) {
      return Left(S.current.txt_err_empty_last_name);
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
      return Left(S.current.txt_err_mismatch_password);
    }
    String uid = "";
    try {
      uid = await authService.register(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return Left(e.message!);
    }

    UserModel userModel = UserModel(
        id: uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
        gender: gender,
        followers: List.empty(growable: true),
        followings: List.empty(growable: true));

    try {
      await databaseService.setUser(userModel: userModel);
    } on FirebaseException catch (e) {
      return Left(e.message!);
    }
    return const Right(null);
  }

  @override
  Future<Either<String, UserModel>> getCurrentUser() async {
    try {
      final response =
          await databaseService.getUser(uid: authService.getUserId());
      return Right(response);
    } on FirebaseException catch (e) {
      return Left(e.message!);
    }
  }
}
