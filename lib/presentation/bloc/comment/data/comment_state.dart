part of 'comment_cubit.dart';

abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentFailure extends CommentState {}

class CommentSuccess extends CommentState {
  final List<CommentModel> comments;

  CommentSuccess(this.comments);
}
