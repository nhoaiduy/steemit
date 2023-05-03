part of 'post_controller_cubit.dart';

@immutable
abstract class PostControllerState {}

class PostControllerInitial extends PostControllerState {}

class PostControllerSuccess extends PostControllerState {}

class PostControllerFailure extends PostControllerState {
  final String message;

  PostControllerFailure(this.message);
}
