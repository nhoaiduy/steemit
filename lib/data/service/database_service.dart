import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:steemit/data/model/post_model.dart';
import 'package:steemit/data/model/user_model.dart';
import 'package:steemit/data/service/authentication_service.dart';
import 'package:steemit/util/path/services_path.dart';

final DatabaseService databaseService = DatabaseService();

class DatabaseService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<UserModel> getUser({required String uid}) async {
    try {
      final response =
          await _fireStore.collection(ServicePath.user).doc(uid).get();
      final userModel = UserModel.fromJson(response.data()!);
      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setUser({required UserModel userModel}) async {
    try {
      await _fireStore
          .collection(ServicePath.user)
          .doc(userModel.id)
          .set(userModel.toJson());
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> createPost({required PostModel postModel}) async {
    try {
      await _fireStore
          .collection(ServicePath.post)
          .doc(postModel.id)
          .set(postModel.toJson());
    } on FirebaseException {
      rethrow;
    }
  }

  Future<List<PostModel>> getPosts({bool isMyPosts = true}) async {
    try {
      final List<PostModel> posts = List.empty(growable: true);
      if (isMyPosts) {
        final response = await _fireStore
            .collection(ServicePath.post)
            .where("userId", isEqualTo: authService.getUserId())
            .orderBy("updatedAt", descending: true)
            .get();
        posts.addAll(
            response.docs.map((e) => PostModel.fromJson(e.data())).toList());
      } else {
        final response = await _fireStore
            .collection(ServicePath.post)
            .orderBy("updatedAt", descending: true)
            .get();
        posts.addAll(
            response.docs.map((e) => PostModel.fromJson(e.data())).toList());
      }
      for (var post in posts) {
        post.user = await getUser(uid: post.userId!);
      }
      return posts;
    } on FirebaseException {
      rethrow;
    }
  }
}
