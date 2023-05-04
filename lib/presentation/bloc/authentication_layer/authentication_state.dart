abstract class AuthenticationState {}

class AuthInitialState extends AuthenticationState {}

class AuthenticatedState extends AuthenticationState {}

class UnauthenticatedState extends AuthenticationState {}

class ErrorState extends AuthenticationState {
  final String message;

  ErrorState({required this.message});
}
