part of 'posts_cubit.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsFailure extends PostsState {
  final String message;

  PostsFailure(this.message);
}

class PostsSuccess extends PostsState {
  final List<PostModel> posts;

  PostsSuccess(this.posts);
}
