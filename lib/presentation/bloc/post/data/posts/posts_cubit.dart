import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:steemit/data/model/post_model.dart';
import 'package:steemit/domain/repository/Implement/post_impl.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitial());

  final PostRepository _postRepository = PostRepository();

  Future<void> getPosts() async {
    final response = await _postRepository.getPosts(isMyPosts: false);
    if (response.isLeft) {
      emit(PostsFailure(response.left));
      return;
    }

    emit(PostsSuccess(response.right));
  }

  void clean() => emit(PostsInitial());
}
