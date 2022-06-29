import 'package:flutter/material.dart';

import '../shared/style/styles.dart';

class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);
  final ThemeService _themeService = ThemeService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: IconButton(
          onPressed: () {_themeService.changeTheme(); },
          icon: const Icon(Icons.account_circle_outlined),
        ),
      ),
    );
  }
}
