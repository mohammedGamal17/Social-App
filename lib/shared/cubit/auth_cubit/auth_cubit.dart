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
    /*try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        snack(context, content: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        snack(context, content: 'The account already exists for that email.');
      }
    } catch (e) {
      emit(RegisterFailState());
      snack(context, content: e.toString());
    }*/
    final credential = await FirebaseAuth.instance
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
        emit(RegisterFailState());
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
    /*try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        snack(context, content: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        snack(context, content: 'Wrong password provided for that user.');
      }
    } catch (e) {
      emit(LoginFailState());
      snack(context, content: e.toString());
    }*/

    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      snack(context, content: '${value.user}');
      emit(LoginSuccessState());
    }).catchError((onError) {
      emit(LoginFailState());
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
