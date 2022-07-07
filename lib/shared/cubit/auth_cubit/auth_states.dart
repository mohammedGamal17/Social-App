abstract class AuthenticationState {}

class AuthInit extends AuthenticationState {}

class LoginLoadingState extends AuthenticationState {}

class LoginSuccessState extends AuthenticationState {}

class LoginFailState extends AuthenticationState {}

class RegisterLoadingState extends AuthenticationState {}

class RegisterSuccessState extends AuthenticationState {}

class RegisterFailState extends AuthenticationState {}

class PasswordVisibilityState extends AuthenticationState {}
