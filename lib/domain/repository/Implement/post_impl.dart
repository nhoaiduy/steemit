import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/src/either.dart';
import 'package:steemit/data/model/post_model.dart';
import 'package:steemit/data/service/authentication_service.dart';
import 'package:steemit/data/service/database_service.dart';
import 'package:steemit/data/service/storage_service.dart';
import 'package:steemit/domain/repository/Interface/i_post.dart';
import 'package:uuid/uuid.dart';

class PostRepository extends PostRepositoryInterface {
  final Uuid _uuid = const Uuid();

  @override
  Future<Either<String, void>> createPost(
      {String? content, List<File>? images}) async {
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
          comments: List.empty(),
          likes: List.empty(),
          images: imagePaths,
          delete: false,
          userId: authService.getUserId(),
          createAt: Timestamp.now(),
          updatedAt: Timestamp.now());
      await databaseService.createPost(postModel: post);
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
}
