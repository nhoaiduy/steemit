import 'package:either_dart/either.dart';
import 'package:steemit/data/model/post_model.dart';

abstract class CommentRepositoryInterface {
  Future<Either<String, List<CommentModel>>> getComments(String postId);

  Future<Either<String, void>> addComment(
      {required String postId,
      required String userId,
      required String content});
}
