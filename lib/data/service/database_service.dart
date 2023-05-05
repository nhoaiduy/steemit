import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:steemit/data/model/post_model.dart';
import 'package:steemit/data/model/user_model.dart';
import 'package:steemit/data/service/authentication_service.dart';
import 'package:steemit/util/path/services_path.dart';

final DatabaseService databaseService = DatabaseService();

class DatabaseService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<List<UserModel>> getAllUsers() async {
    try {
      final response = await _fireStore
          .collection(ServicePath.user)
          .where("id", isNotEqualTo: authService.getUserId())
          .get();
      final List<UserModel> users = List.empty(growable: true);
      users.addAll(response.docs
          .map((user) => UserModel.fromJson(user.data()))
          .toList());
      return users;
    } catch (e) {
      rethrow;
    }
  }

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

  Future<void> updateBio({required String bio, required String uid}) async {
    try {
      await _fireStore
          .collection(ServicePath.user)
          .doc(uid)
          .update({"bio": bio});
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

  Future<void> savePost({required String postId, required String uid}) async {
    try {
      await _fireStore.collection(ServicePath.user).doc(uid).update({
        "savedPosts": FieldValue.arrayUnion([postId])
      });
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> unSavePost({required String postId, required String uid}) async {
    try {
      await _fireStore.collection(ServicePath.user).doc(uid).update({
        "savedPosts": FieldValue.arrayRemove([postId])
      });
    } on FirebaseException {
      rethrow;
    }
  }

  Future<PostModel> getPostById({required String postId}) async {
    try {
      final response =
          await _fireStore.collection(ServicePath.post).doc(postId).get();
      final PostModel postModel = PostModel.fromJson(response.data()!);
      postModel.user = await getUser(uid: postModel.userId!);
      return postModel;
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> deletePost({required String postId}) async {
    try {
      await _fireStore.collection(ServicePath.post).doc(postId).delete();
    } on FirebaseException {
      rethrow;
    }
  }
}
