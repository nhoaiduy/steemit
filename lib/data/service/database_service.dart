import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:steemit/data/model/activity_model.dart';
import 'package:steemit/data/model/post_model.dart';
import 'package:steemit/data/model/user_model.dart';
import 'package:steemit/data/service/authentication_service.dart';
import 'package:steemit/util/enum/activity_enum.dart';
import 'package:steemit/util/path/services_path.dart';
import 'package:uuid/uuid.dart';

final DatabaseService databaseService = DatabaseService();

class DatabaseService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final Uuid _uuid = const Uuid();

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
      if (response.data() == null) throw FirebaseException(plugin: '');
      final PostModel postModel = PostModel.fromJson(response.data()!);
      postModel.user = await getUser(uid: postModel.userId!);
      return postModel;
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> likePost({required String postId, required String uid}) async {
    try {
      await _fireStore.collection(ServicePath.post).doc(postId).update({
        "likes": FieldValue.arrayUnion([uid])
      });
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

  Future<void> unLikePost({required String postId, required String uid}) async {
    try {
      await _fireStore.collection(ServicePath.post).doc(postId).update({
        "likes": FieldValue.arrayRemove([uid])
      });
    } on FirebaseException {
      rethrow;
    }
  }

  Future<List<CommentModel>> getComments({required String postId}) async {
    try {
      final response =
          await _fireStore.collection(ServicePath.post).doc(postId).get();
      final List<CommentModel> comments = List.empty(growable: true);
      final PostModel postModel = PostModel.fromJson(response.data()!);
      comments.addAll(postModel.comments!);
      return comments;
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> addComment(String postId, String userId, String content) async {
    try {
      final CommentModel commentModel = CommentModel(
          _uuid.v1(), content, userId, Timestamp.now(), Timestamp.now());
      await _fireStore.collection(ServicePath.post).doc(postId).update({
        "comments": FieldValue.arrayUnion([commentModel.toJson()])
      });
    } on FirebaseException {
      rethrow;
    }
  }

  Future<List<ActivityModel>> getActivities({required String userId}) async {
    try {
      final response =
          await _fireStore.collection(ServicePath.user).doc(userId).get();
      final List<ActivityModel> activities = List.empty(growable: true);
      final UserModel userModel = UserModel.fromJson(response.data()!);
      activities.addAll(userModel.activities!);
      return activities;
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> addActivity(
      String postId, String userId, ActivityEnum type) async {
    try {
      final ActivityModel activityModel =
          ActivityModel(postId: postId, type: type, createdAt: Timestamp.now());
      await _fireStore.collection(ServicePath.user).doc(userId).update({
        "activities": FieldValue.arrayUnion([activityModel.toJson()])
      });
    } on FirebaseException {
      rethrow;
    }
  }
}
