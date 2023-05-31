part of 'post_cubit.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostFailure extends PostState {}

class PostISuccess extends PostState {
  final PostModel postModel;

  PostISuccess(this.postModel);
}
