part of 'saved_posts_cubit.dart';

@immutable
abstract class SavedPostsState {}

class SavedPostsInitial extends SavedPostsState {}

class SavedPostsFailure extends SavedPostsState {
  final String message;

  SavedPostsFailure(this.message);
}

class SavedPostsSuccess extends SavedPostsState {
  final List<PostModel> posts;

  SavedPostsSuccess(this.posts);

}
