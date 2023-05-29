part of 'comment_controller_cubit.dart';

@immutable
abstract class CommentControllerState {}

class CommentControllerInitial extends CommentControllerState {}

class CommentControllerFailure extends CommentControllerState {}

class CommentControllerSuccess extends CommentControllerState {}
