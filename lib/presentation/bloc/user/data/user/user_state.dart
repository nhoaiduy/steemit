part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserFailure extends UserState {
  final String message;

  UserFailure(this.message);
}

class UserSuccess extends UserState {
  final UserModel user;

  UserSuccess(this.user);
}
