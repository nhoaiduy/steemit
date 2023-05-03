import 'package:either_dart/either.dart';
import 'package:steemit/data/model/post_model.dart';

abstract class PostRepositoryInterface {
  Future<Either<String, void>> createPost(
      {String? content, List<String>? images});

  Future<Either<String, List<PostModel>>> getPosts({bool isMyPosts = true});
}
