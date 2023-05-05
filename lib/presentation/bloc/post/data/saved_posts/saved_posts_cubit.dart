import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:steemit/data/model/post_model.dart';
import 'package:steemit/domain/repository/Implement/post_impl.dart';

part 'saved_posts_state.dart';

class SavedPostsCubit extends Cubit<SavedPostsState> {
  SavedPostsCubit() : super(SavedPostsInitial());

  Future<void> getData({required List<String> postIdList}) async {
    final response = await PostRepository().getSavedPosts(
        postIdList: postIdList);
    if (response.isLeft) {
      emit(SavedPostsFailure(response.left));
      return;
    }

    emit(SavedPostsSuccess(response.right));
  }

  void clean() => emit(SavedPostsInitial());
}
