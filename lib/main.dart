import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:social/shared/cubit/bloc_observer.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social/shared/style/theme_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'modules/page_view.dart';
import 'modules/auth_screens/login_screen.dart';
import 'layout/Layout_screen.dart';

late SharedPreferences sharedPreferences;

void main() async {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      final fcmToken = await FirebaseMessaging.instance.getToken();
      FirebaseMessaging.onMessage
          .listen((event) {
        if (kDebugMode) {
          print(event.data.toString());
        }
      })
          .onError((onError) {
        if (kDebugMode) {
          print('Error getting token ** ${onError.toString()}');
        }
      });
      await GetStorage.init();
      sharedPreferences = await SharedPreferences.getInstance();

      WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
      FlutterNativeSplash.remove();
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

Widget? widget() {
  if (sharedPreferences.getBool('skip') != null) {
    if (sharedPreferences.get('isLogin') != null) {
      return const LayOutScreen();
    } else {
      return LoginScreen();
    }
  } else {
    return const PageViewScreen();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PiGram',
      theme: ThemeService().light,
      darkTheme: ThemeService().dark,
      themeMode: ThemeService().getThemeMode(),
      home: widget(),
    );
  }
}
