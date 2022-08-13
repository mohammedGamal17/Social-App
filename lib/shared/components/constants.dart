// SHA-1 = 1:330037147852:android:54182adb6c761890ab6a69

/*
Variant: debugAndroidTest
Config: debug
Store: C:\Users\moham\.android\debug.keystore
Alias: AndroidDebugKey
MD5: 12:C2:A0:A8:F7:EC:E7:3F:AF:F5:1E:E5:00:F0:37:31
SHA1: B9:5F:2B:95:64:BC:A7:B8:BD:FF:78:B3:DD:89:46:B3:63:1E:42:DE
SHA-256: 3F:F4:76:D6:B9:59:52:FB:01:17:9D:C0:B6:26:F9:23:BE:9C:48:88:05:71:B3:49:EA:4A:5B:AE:4F:8E:90:B0
Valid until: Wednesday, May 8, 2052
*/

import '../../main.dart';

const baseUrl = '';
//token is in login.dart
String? uId = sharedPreferences.getString('isLogin');

//onBoarding is in PageViewScreen.dart
bool? onBoarding = sharedPreferences.getBool('skip');
