import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:steemit/data/model/activity_model.dart';
import 'package:steemit/data/model/post_model.dart';
import 'package:steemit/data/model/user_model.dart';
import 'package:steemit/data/service/authentication_service.dart';
import 'package:steemit/data/service/database_service.dart';
import 'package:steemit/data/service/storage_service.dart';
import 'package:steemit/domain/repository/Interface/i_post.dart';
import 'package:steemit/util/path/services_path.dart';
import 'package:uuid/uuid.dart';

class PostRepository extends PostRepositoryInterface {
  final Uuid _uuid = const Uuid();

  @override
  Future<Either<String, void>> createPost(
      {String? content, List<File>? images, String? location}) async {
    try {
      final String postId = _uuid.v1();
      final List<String> imagePaths = List.empty(growable: true);
      if (images != null) {
        for (var image in images) {
          imagePaths.add(await storageService.savePostImages(image, postId));
        }
      }

      final PostModel post = PostModel(
          content: content,
          id: postId,
          comments: List.empty(),
          likes: List.empty(),
          images: imagePaths,
          delete: false,
          location: location,
          userId: authService.getUserId(),
          createAt: Timestamp.now(),
          updatedAt: Timestamp.now());
      await databaseService.createPost(postModel: post);
      savedRecentAct('create', postId);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(e.message!);
    }
  }

  @override
  Future<Either<String, List<PostModel>>> getPosts(
      {bool isMyPosts = true}) async {
    try {
      final response = await databaseService.getPosts(isMyPosts: isMyPosts);
      return Right(response);
    } on FirebaseException catch (e) {
      return Left(e.message!);
    }
  }

  @override
  Future<Either<String, void>> savePost({required String postId}) async {
    try {
      await databaseService.savePost(
          postId: postId, uid: authService.getUserId());
      savedRecentAct('save', postId);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(e.message!);
    }
  }

  @override
  Future<Either<String, void>> unSavePost({required String postId}) async {
    try {
      await databaseService.unSavePost(
          postId: postId, uid: authService.getUserId());
      savedRecentAct('unsaved', postId);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(e.message!);
    }
  }

  @override
  Future<Either<String, PostModel>> getPostById(
      {required String postId}) async {
    try {
      final response = await databaseService.getPostById(postId: postId);
      return Right(response);
    } on FirebaseException catch (e) {
      return Left(e.message!);
    }
  }

  @override
  Future<Either<String, List<PostModel>>> getSavedPosts(
      {required List<String> postIdList}) async {
    try {
      final List<PostModel> savedPosts = List.empty(growable: true);
      for (var postId in postIdList) {
        final response = await databaseService.getPostById(postId: postId);
        savedPosts.add(response);
      }
      return Right(savedPosts);
    } on FirebaseException catch (e) {
      return Left(e.message!);
    }
  }

  @override
  Future<Either<String, void>> likePost({required String postId}) async {
    try {
      await databaseService.likePost(
          postId: postId, uid: authService.getUserId());
      savedRecentAct('like', postId);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(e.message!);
    }
  }

  @override
  Future<Either<String, void>> unLikePost({required String postId}) async {
    try {
      await databaseService.unLikePost(
          postId: postId, uid: authService.getUserId());
      savedRecentAct('unlike', postId);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(e.message!);
    }
  }
  
  @override
  Future<Either<String, void>> deletePost({required String postId}) async {
    try {
      await databaseService.deletePost(postId: postId);
      savedRecentAct('delete', postId);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(e.message!);
    }
  }

  void savedRecentAct(String type,String postId) async{
    const Uuid uuid = Uuid();
    String actId = uuid.v1();
    String userId = authService.getUserId();

    String? image;
    String? userPostId;
    await FirebaseFirestore.instance
        .collection(ServicePath.post)
        .doc(postId)
        .get().then((DocumentSnapshot ds) {
          userPostId = ds['userId'];
          if(ds['images'][0] != null) {
            image = ds['images'][0];
          }
        });

    final user = await FirebaseFirestore.instance.collection(ServicePath.user).doc(userPostId).get();
    final userModel = UserModel.fromJson(user.data()!);

    ActivityModel activityModel = ActivityModel(
        id: actId,
        type: type,
        time: Timestamp.now(),
        postId: postId,
        nameUserPost: "${userModel.firstName} ${userModel.lastName}",
        images: image);

    await FirebaseFirestore.instance
        .collection(ServicePath.user)
        .doc(userId)
        .collection(ServicePath.activity)
        .doc(actId)
        .set(activityModel.toJson());
  }
}
