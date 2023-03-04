part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitState extends LoginState {}

class WrongLoginInfoState extends LoginState {}

class InvalidUsernameState extends LoginState {
  InvalidUsernameState(this.content);

  final String content;

  List<Object> get props => [content];
}

class InvalidPasswordState extends LoginState {
  InvalidPasswordState(this.content);

  final String content;

  List<Object> get props => [content];
}

class DisconnectState extends LoginState {}

class ErrorState extends LoginState {}
