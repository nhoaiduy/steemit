import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:steemit/core/exception/common_exception.dart';
import 'package:steemit/data/model/user_model.dart';

final DatabaseService databaseService = DatabaseService();

class DatabaseService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<Either<Exception, UserModel>> getUser({required String uid}) async {
    try {
      final response = await _fireStore.collection("users").doc(uid).get();
      final userModel = UserModel.fromJson(response.data()!);

      return Right(userModel);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerException());
      }
      if (e is AuthorizationException) {
        return Left(AuthorizationException());
      }
      return Left(DataParsingException());
    }
  }
}
