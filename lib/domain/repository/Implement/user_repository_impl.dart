import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:steemit/data/model/user_model.dart';
import 'package:steemit/data/service/authentication_service.dart';
import 'package:steemit/data/service/database_service.dart';
import 'package:steemit/domain/repository/Interface/i_user.dart';
import 'package:steemit/generated/l10n.dart';

class UserRepositoryImplement extends UserRepositoryInterface {
  @override
  Future<Either<String, void>> updateBio({required String bio}) async {
    if (bio.isEmpty) {
      return Left(S.current.txt_empty_bio);
    }
    try {
      await databaseService.updateBio(bio: bio, uid: authService.getUserId());
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(e.message!);
    }
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

  @override
  Future<Either<String, UserModel>> getUserById(
      {required String userId}) async {
    try {
      final response = await databaseService.getUser(uid: userId);
      return Right(response);
    } on FirebaseException catch (e) {
      return Left(e.message!);
    }
  }
}
