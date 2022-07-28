import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:social/shared/components/components.dart';
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
FirebaseMessaging messaging = FirebaseMessaging.instance;

Future notificationAuth()async{

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (kDebugMode) {
    print('User granted permission: ${settings.authorizationStatus}');
  }

}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> saveTokenToDatabase(String token) async {
  // Assume user is logged in for this example
  String? userId = FirebaseAuth.instance.currentUser?.uid;

  await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .update({
    'tokens': FieldValue.arrayUnion([token]),
  });
}

Future<void> setupToken() async {
  // Get the token each time the application loads
  String? token = await FirebaseMessaging.instance.getToken();

  // Save the initial token to the database
  await saveTokenToDatabase(token!);

  // Any time the token refreshes, store this in the database too.
  FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
}

void main(context) async {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      setupToken();
      notificationAuth();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (kDebugMode) {
          print('Message data: ${message.data.toString()}');
        }
        if (message.notification != null) {
          if (kDebugMode) {
            print(
                'Message also contained a notification: ${message.notification}');
          }
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
