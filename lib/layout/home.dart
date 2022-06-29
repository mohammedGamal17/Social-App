import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Center(
        child: IconButton(onPressed: (){}, icon: const Icon(Icons.account_circle_outlined)),
      ),
    );
  }
}
