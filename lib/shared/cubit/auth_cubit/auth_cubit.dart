import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social/shared/components/components.dart';

import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInit());

  static AuthCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void userRegister(
    context, {
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(RegisterLoadingState());
     await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) {
        snack(context, content: '${value.credential}');
        emit(RegisterSuccessState());
      },
    ).catchError(
      (onError) {
        emit(RegisterFailState(onError.toString()));
        snack(context, content: onError.toString(), bgColor: Colors.red);
      },
    );
  }

  void userLogin(
    context, {
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
     await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      snack(context, content: '${value.user}');
      emit(LoginSuccessState());
    }).catchError((onError) {
      emit(LoginFailState(onError.toString()));
      snack(context, content: onError.toString(), bgColor: Colors.red);
    });
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(PasswordVisibilityState());
  }
}
