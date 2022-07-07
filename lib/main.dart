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

import 'layout/home.dart';
import 'modules/auth_screens/login_screen.dart';
import 'modules/home_screen.dart';

late SharedPreferences sharedPreferences;

void main() async {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

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
  if (sharedPreferences.getBool('skip') == true) {
    if(sharedPreferences.getBool('isLogin')== true){
      return const HomeScreen();
    }else{
      return const LoginScreen();
    }
  }else{
    return const Home();
  }
  return null;
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
