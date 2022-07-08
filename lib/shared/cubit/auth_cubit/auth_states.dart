abstract class AuthStates {}

class AuthInit extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class LoginFailState extends AuthStates {
  final String error;

  LoginFailState(this.error);
}

class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class RegisterFailState extends AuthStates {
  final String error;

  RegisterFailState(this.error);
}

class CreateUserLoadingState extends AuthStates {}

class CreateUserSuccessState extends AuthStates {}

class CreateUserFailState extends AuthStates {
  final String error;

  CreateUserFailState(this.error);
}

class PasswordVisibilityState extends AuthStates {}
