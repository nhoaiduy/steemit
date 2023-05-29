import 'package:bloc/bloc.dart';
import 'package:steemit/data/model/post_model.dart';
import 'package:steemit/domain/repository/Implement/comment_repository_impl.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentInitial());

  Future<void> getComments(String postId) async {
    final response = await CommentRepository().getComments(postId);
    if (response.isLeft) {
      emit(CommentFailure());
      return;
    }

    emit(CommentSuccess(response.right));
  }

  void clean() => emit(CommentInitial());
}
