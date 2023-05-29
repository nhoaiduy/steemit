import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:steemit/domain/repository/Implement/comment_repository_impl.dart';

part 'comment_controller_state.dart';

class CommentControllerCubit extends Cubit<CommentControllerState> {
  CommentControllerCubit() : super(CommentControllerInitial());

  Future<void> addComment(
      {required String postId,
      required String userId,
      required String content}) async {
    final response = await CommentRepository()
        .addComment(postId: postId, userId: userId, content: content);
    if (response.isLeft) {
      emit(CommentControllerFailure());
      return;
    }

    emit(CommentControllerSuccess());
  }

  void clean() => emit(CommentControllerInitial());
}
