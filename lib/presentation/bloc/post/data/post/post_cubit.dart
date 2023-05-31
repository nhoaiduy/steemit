import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:steemit/data/model/post_model.dart';
import 'package:steemit/domain/repository/Implement/post_impl.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());

  Future<void> getData(String postId) async {
    final response = await PostRepository().getPostById(postId: postId);

    if (response.isLeft) {
      emit(PostFailure());
      return;
    }

    emit(PostISuccess(response.right));
  }

  void clean() => emit(PostInitial());
}
