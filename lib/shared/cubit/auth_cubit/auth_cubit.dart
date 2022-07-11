import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:social/models/user_model/user_model.dart';
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

        userCreate(
          context,
          name: name,
          email: email,
          password: password,
          phone: phone,
          uId: value.user!.uid,
        );
        snack(context, content: 'register success'.capitalize!);
      },
    ).catchError(
      (onError) {
        if (kDebugMode) {
          print(onError.toString());
        }
        emit(RegisterFailState(onError.toString()));
        snack(context, content: onError.toString(), bgColor: Colors.red);
      },
    );
  }

  void userCreate(
    context, {
    required String name,
    required String email,
    required String password,
    required String phone,
    required String uId,
  }) async {
    emit(CreateUserLoadingState());
    UserModel model = UserModel(
      name: name,
      phone: phone,
      email: email,
      password: password,
      uId: uId,
      isEmailVerified: false,
    );
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .doc(uId)
        .set(
          model.toMap(),
        )
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(CreateUserFailState(onError.toString()));
      snack(context, content: onError.toString(), bgColor: Colors.red);
    });
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
      UserModel model = UserModel(
        name: value.user?.displayName,
        phone: value.user?.phoneNumber,
        email: email,
        password: password,
        uId: value.user?.uid,
      );
      snack(context, content: 'Welcome ${model.email}'.capitalize!);
      emit(LoginSuccessState(model));
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
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
