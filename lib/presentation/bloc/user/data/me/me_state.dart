part of 'me_cubit.dart';

@immutable
abstract class MeState {}

class MeInitial extends MeState {}

class MeFailure extends MeState {
  final String message;

  MeFailure(this.message);
}

class MeSuccess extends MeState {
  final UserModel user;

  MeSuccess(this.user);
}
