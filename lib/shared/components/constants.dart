// SHA-1 = 1:330037147852:android:54182adb6c761890ab6a69

import '../../main.dart';

const baseUrl = '';
//token is in login.dart
String? uId = sharedPreferences.getString('isLogin');

//onBoarding is in PageViewScreen.dart
bool? onBoarding = sharedPreferences.getBool('skip');
