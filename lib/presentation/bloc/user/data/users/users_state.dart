part of 'users_cubit.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}

class UsersFailure extends UsersState {
  final String message;

  UsersFailure(this.message);
}

class UsersSuccess extends UsersState {
  final List<UserModel> users;

  UsersSuccess(this.users);
}
