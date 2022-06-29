import 'package:flutter/material.dart';

import '../shared/style/theme_service.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              ThemeService().changeTheme();
              print('dark mode');
            },
            icon: const Icon(Icons.dark_mode_outlined),
          ),
        ],
      ),
      body: Center(
        child: IconButton(
          onPressed: () {
          },
          icon: const Icon(Icons.account_circle_outlined),
        ),
      ),
    );
  }
}
