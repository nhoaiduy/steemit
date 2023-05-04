import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/src/either.dart';
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
}