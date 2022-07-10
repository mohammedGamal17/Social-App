import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/user_model/user_model.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/cubit/app_cubit/app_cubit.dart';

import '../shared/cubit/app_cubit/app_states.dart';
import '../shared/style/theme_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getUserData(context),
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
    return Column(
      children: [
        if (model.isEmailVerified == false)
          alertMessage(
            context,
            data: 'You Need To Verification Your Account',
            buttonText: 'Send ',
            onPressed: () {},
          ),
        Text(model.uId!),
      ],
    );
  }
}
