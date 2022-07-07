abstract class AuthStates {}

class AuthInit extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class LoginFailState extends AuthStates {}

class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class RegisterFailState extends AuthStates {}

class PasswordVisibilityState extends AuthStates {}
