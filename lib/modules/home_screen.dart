import 'package:flutter/material.dart';
import 'package:social/shared/components/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text(uId!),
      ),
    );
  }
}
