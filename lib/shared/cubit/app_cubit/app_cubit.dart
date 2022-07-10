import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/components/constants.dart';
import 'package:social/shared/cubit/app_cubit/app_states.dart';

import '../../../models/user_model/user_model.dart';
import '../../networks/remote/dio_helper.dart';
import '../../style/theme_service.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInit());

  static AppCubit get(context) => BlocProvider.of(context);

  DioHelper dio = DioHelper();

  UserModel? userModel;

  void getUserData(context) {
    emit(GetHomeDataLoading());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      snack(context, content: 'Welcome ${userModel?.name}'.capitalize!);
      emit(GetHomeDataSuccess());
    }).catchError((onError) {
      snack(context, content: onError.toString(), bgColor: Colors.red);
      emit(GetHomeDataFail(onError.toString()));
    });
  }

  void changeThemeMode(){
    emit(ChangeThemeMode());
  }
}
