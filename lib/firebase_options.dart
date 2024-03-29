// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAgBLLmkL0rs2vfeTWPD1rCsBDdXK1MiwM',
    appId: '1:330037147852:web:d5b6287cef82d10eab6a69',
    messagingSenderId: '330037147852',
    projectId: 'pigram-74e3e',
    authDomain: 'pigram-74e3e.firebaseapp.com',
    storageBucket: 'pigram-74e3e.appspot.com',
    measurementId: 'G-TGCCTSD72X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDiHpsQo_a6Mrr2itL52IHW0rE1GAmVrPI',
    appId: '1:330037147852:android:f0a0b5f00082d0e2ab6a69',
    messagingSenderId: '330037147852',
    projectId: 'pigram-74e3e',
    storageBucket: 'pigram-74e3e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCvl_t0XQ5nShGG2lBoSuM0RM6RnqjXNRk',
    appId: '1:330037147852:ios:c542c2a0acbad541ab6a69',
    messagingSenderId: '330037147852',
    projectId: 'pigram-74e3e',
    storageBucket: 'pigram-74e3e.appspot.com',
    androidClientId: '330037147852-5tcqu0n4mqqff4n39h7ik3o49t15rn29.apps.googleusercontent.com',
    iosClientId: '330037147852-nq9u8hi0eg048vli6u8jbgp0e2kh5omg.apps.googleusercontent.com',
    iosBundleId: 'com.impact.social',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCvl_t0XQ5nShGG2lBoSuM0RM6RnqjXNRk',
    appId: '1:330037147852:ios:c542c2a0acbad541ab6a69',
    messagingSenderId: '330037147852',
    projectId: 'pigram-74e3e',
    storageBucket: 'pigram-74e3e.appspot.com',
    androidClientId: '330037147852-5tcqu0n4mqqff4n39h7ik3o49t15rn29.apps.googleusercontent.com',
    iosClientId: '330037147852-nq9u8hi0eg048vli6u8jbgp0e2kh5omg.apps.googleusercontent.com',
    iosBundleId: 'com.impact.social',
  );
}
