import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:steemit/data/model/post_model.dart';

abstract class PostRepositoryInterface {
  Future<Either<String, void>> createPost(
      {String? content, List<File>? images, String? location});

  Future<Either<String, List<PostModel>>> getPosts({bool isMyPosts = true});

  Future<Either<String, void>> savePost({required String postId});

  Future<Either<String, void>> unSavePost({required String postId});

  Future<Either<String, PostModel>> getPostById({required String postId});

  Future<Either<String, List<PostModel>>> getSavedPosts(
      {required List<String> postIdList});

  Future<Either<String, void>> deletePost({required String postId});
}
