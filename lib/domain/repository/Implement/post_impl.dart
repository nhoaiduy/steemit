import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/src/either.dart';
import 'package:steemit/data/model/post_model.dart';
import 'package:steemit/data/service/authentication_service.dart';
import 'package:steemit/data/service/database_service.dart';
import 'package:steemit/domain/repository/Interface/i_post.dart';

class PostRepository extends PostRepositoryInterface {
  @override
  Future<Either<String, void>> createPost(
      {String? content, List<String>? images}) async {
    try {
      final PostModel post = PostModel(
          content: content,
          images: images,
          comments: List.empty(),
          likes: List.empty(),
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
