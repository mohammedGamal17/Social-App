import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:social/shared/cubit/app_cubit/app_cubit.dart';
import 'package:social/shared/style/colors.dart';

import '../main.dart';
import 'auth_screens/login_screen.dart';
import '../shared/components/components.dart';
import '../shared/cubit/app_cubit/app_states.dart';

class PageViewScreen extends StatelessWidget {
  const PageViewScreen({Key? key}) : super(key: key);

  List<PageViewModel> listPagesViewModel() {
    return [
      PageViewModel(
        image: const Image(
          image: AssetImage('assets/Images/w2.png'),
        ),
        body: 'Go social to see what happen '.capitalize!,
        title: 'news feed'.capitalize!,
      ),
      PageViewModel(
        image: const Image(
          image: AssetImage('assets/Images/w.png'),
        ),
        body: 'body 2',
        title: 'title 2',
      ),
      PageViewModel(
        image: const Image(
          image: AssetImage('assets/Images/w3.png'),
        ),
        body: 'body 3',
        title: 'title 3',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: lightBackground,
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: IntroductionScreen(
                pages: listPagesViewModel(),
                globalBackgroundColor: lightBackground,
                onDone: () {
                  sharedPreferences.setBool('skip', true).then((value) {
                    return navigateToAndReplace(context, LoginScreen());
                  }).catchError((onError) {
                    Container(
                      color: Colors.red,
                      child: Text(onError.toString()),
                    );
                  });
                },
                onSkip: () {},
                showBackButton: false,
                showSkipButton: true,
                skip: TextButton(
                  onPressed: () {
                    sharedPreferences.setBool('skip', true).then((value) {
                      return navigateToAndReplace(context, LoginScreen());
                    }).catchError((onError) {
                      Container(
                        color: Colors.red,
                        child: Text(onError.toString()),
                      );
                    });
                  },
                  style:
                      TextButton.styleFrom(backgroundColor: lightBackground),
                  child:
                      Text('Skip', style: Theme.of(context).textTheme.caption),
                ),
                next: const Icon(Icons.navigate_next),
                done: const Text(
                  "Done",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                animationDuration: 500,
                scrollPhysics: const BouncingScrollPhysics(),
                dotsDecorator: DotsDecorator(
                  size: const Size.square(10.0),
                  activeSize: const Size(20.0, 10.0),
                  activeColor: iconColor,
                  color: Colors.black26,
                  spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
