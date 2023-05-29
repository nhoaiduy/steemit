import 'package:either_dart/either.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:steemit/data/model/post_model.dart';
import 'package:steemit/data/service/database_service.dart';
import 'package:steemit/domain/repository/Interface/i_comment.dart';

class CommentRepository extends CommentRepositoryInterface {
  @override
  Future<Either<String, List<CommentModel>>> getComments(String postId) async {
    try {
      final response = await databaseService.getComments(postId: postId);
      for (var comment in response) {
        comment.user = await databaseService.getUser(uid: comment.userId!);
      }
      return Right(response);
    } on FirebaseException catch (e) {
      return Left(e.message!);
    }
  }

  @override
  Future<Either<String, void>> addComment(
      {required String postId,
      required String userId,
      required String content}) async {
    try {
      await databaseService.addComment(postId, userId, content);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(e.message!);
    }
  }
}
