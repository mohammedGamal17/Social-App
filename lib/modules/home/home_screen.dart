import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/user_model/user_model.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/cubit/app_cubit/app_cubit.dart';

import '../../shared/cubit/app_cubit/app_states.dart';
import '../../shared/style/theme_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      AppCubit()
        ..getUserData(context),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Home page'),
              actions: [
                IconButton(
                  onPressed: () {
                    ThemeService().changeTheme();
                    cubit.changeThemeMode();
                  },
                  icon: const Icon(Icons.dark_mode_outlined),
                )
              ],
            ),
            body: cubit.userModel != null
                ? pageBuilder(context, cubit.userModel!)
                : circularProgressIndicator(),

          );
        },
      ),
    );
  }

  Widget pageBuilder(context, UserModel model) {
   bool? isVerified =  FirebaseAuth.instance.currentUser?.emailVerified;
    return Column(
      children: [
        if (isVerified == false)
          alertMessage(
            context,
            data: 'You Need To Verification Your Account',
            buttonText: 'Send ',
            onPressed: () {
              FirebaseAuth.instance.currentUser?.sendEmailVerification().then((
                  value) {
                snack(context, content: 'Code Send Successfully Check Your Mail');
              }).catchError((onError) {
                snack(context, content: 'Code Did Not Send !! ${onError.toString()}', bgColor: Colors.red);
              });
            },
          ),
      ],
    );
  }
}