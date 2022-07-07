import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:social/shared/cubit/app_cubit/app_cubit.dart';
import 'package:social/shared/style/colors.dart';
import 'package:social/shared/style/theme_service.dart';

import '../main.dart';
import '../modules/auth_screens/login_screen.dart';
import '../shared/components/components.dart';
import '../shared/cubit/app_cubit/app_states.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  List<PageViewModel> listPagesViewModel() {
    return [
      PageViewModel(
        image: const Image(
          image: AssetImage('assets/Images/onboarding1.gif'),
        ),
        body: 'Go social to see what happen '.capitalize!,
        title: 'news feed'.capitalize!,
      ),
      PageViewModel(
        image: const Image(
          image: AssetImage('assets/Images/onboarding2.gif'),
        ),
        body: 'body 2',
        title: 'title 2',
      ),
      PageViewModel(
        image: const Image(
          image: AssetImage('assets/Images/onboarding3.gif'),
        ),
        body: 'body 3',
        title: 'title 3',
      ),
      PageViewModel(
        image: const Image(
          image: AssetImage('assets/Images/onboarding4.gif'),
        ),
        body: 'body 4',
        title: 'title 4',
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
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    ThemeService().changeTheme();
                  },
                  icon: const Icon(Icons.dark_mode_outlined),
                ),
              ],
            ),
            body: Center(
              child: IntroductionScreen(
                pages: listPagesViewModel(),
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
                      TextButton.styleFrom(foregroundColor: HexColor('66B2FF')),
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
