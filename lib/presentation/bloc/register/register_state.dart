abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String message;

  RegisterErrorState({required this.message});
}
