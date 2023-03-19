import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:steemit/data/model/user_model.dart';

final DatabaseService databaseService = DatabaseService();

class DatabaseService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<UserModel> getUser({required String uid}) async {
    try {
      final response = await _fireStore.collection("users").doc(uid).get();
      final userModel = UserModel.fromJson(response.data()!);

      return userModel;
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  Future<void> setUser({required UserModel userModel}) async {
    try {
      await _fireStore.collection("users").doc(userModel.id).set(
          userModel.toJson());
    } on FirebaseException catch (e) {
      rethrow;
    }
  }
}
