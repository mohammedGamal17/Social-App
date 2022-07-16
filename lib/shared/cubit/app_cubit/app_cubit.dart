import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social/modules/messages/messages_screen.dart';
import 'package:social/modules/notifications/notifications_screen.dart';
import 'package:social/modules/settings/settings_screen.dart';
import 'package:social/modules/videos/videos_screen.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/components/constants.dart';
import 'package:social/shared/cubit/app_cubit/app_states.dart';
import 'package:social/shared/style/theme_service.dart';

import '../../../models/user_model/user_model.dart';
import '../../../layout/Layout_screen.dart';
import '../../../modules/home/home_screen.dart';
import '../../networks/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInit());

  static AppCubit get(context) => BlocProvider.of(context);

  DioHelper dio = DioHelper();

  UserModel? userModel;
  int currentIndex = 0;
  bool isLike = false;
  IconData disLikeIcon = Icons.favorite_outline;
  IconData likedIcon = Icons.favorite_outlined;
  IconData darkIcon = Icons.dark_mode;
  IconData lightIcon = Icons.light_mode;
  String darkMode = 'Dark mode';
  String lightMode = 'Light mode';
  int likeNum = 0;
  bool isDark = false;
  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  List<Widget> screen = [
    const HomeScreen(),
    const VideosScreen(),
    const MessagesScreen(),
    const NotificationsScreen(),
    const SettingsScreen(),
  ];
  List<String> title = [
    'News Feed',
    'Videos',
    'Messages',
    'Notifications',
    'Settings',
  ];

  List<BottomNavigationBarItem> navBarItem = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.video),
      label: 'Videos',
    ),
    const BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.message),
      label: 'Messages',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.notifications_outlined),
      label: 'Notifications',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.menu),
      label: 'Settings',
    ),
  ];

  void navBarChange(int index) {
    currentIndex = index;
    if (index == 0) {
      const LayOutScreen();
    }
    if (index == 1) {
      const VideosScreen();
    }
    if (index == 2) {
      const MessagesScreen();
    }
    if (index == 3) {
      const NotificationsScreen();
    }
    if (index == 4) {
      const SettingsScreen();
    }
    emit(BtmNavBarChangeItemState());
  }

  void getUserData(context) {
    emit(GetHomeDataLoading());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(GetHomeDataSuccess());
    }).catchError((onError) {
      snack(context, content: onError.toString(), bgColor: Colors.red);
      emit(GetHomeDataFail(onError.toString()));
    });
  }

  void changeThemeMode() {
    isDark = !isDark;
    emit(ChangeThemeMode());
  }

  void changeLikeIcon() {
    isLike = !isLike;
    emit(ChangeLikeIconState());
  }

  void likeCount() {
    if (isLike == true) {
      likeNum++;
    } else {
      likeNum--;
    }

    emit(LikeCountState());
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(PasswordVisibilityState());
  }
}
