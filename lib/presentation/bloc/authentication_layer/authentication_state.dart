import 'package:steemit/data/model/user_model.dart';

abstract class AuthenticationState {}

class AuthInitialState extends AuthenticationState {}

class AuthenticatedState extends AuthenticationState {
  final UserModel userModel;

  AuthenticatedState({required this.userModel});

}

class UnauthenticatedState extends AuthenticationState {}

class ErrorState extends AuthenticationState {
  final String message;

  ErrorState({required this.message});

}
