import '../../../models/user_model/user_model.dart';

abstract class AuthStates {}

class AuthInit extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {
  final UserModel model;

  LoginSuccessState(this.model);
}

class LoginFailState extends AuthStates {
  final String onError;

  LoginFailState(this.onError);
}

class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class RegisterFailState extends AuthStates {
  final String onError;

  RegisterFailState(this.onError);
}

class CreateUserLoadingState extends AuthStates {}

class CreateUserSuccessState extends AuthStates {}

class CreateUserFailState extends AuthStates {
  final String onError;

  CreateUserFailState(this.onError);
}

class PasswordVisibilityState extends AuthStates {}
