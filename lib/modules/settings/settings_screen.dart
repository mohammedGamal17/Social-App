import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:social/shared/cubit/app_cubit/app_cubit.dart';
import 'package:social/shared/cubit/app_cubit/app_states.dart';

import '../../shared/components/components.dart';
import '../../shared/style/theme_service.dart';
import '../profile/profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getUserData(context),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          var model = cubit.userModel;
          return Scaffold(
              body: SingleChildScrollView(
            child: cubit.userModel != null
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        InkWell(
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25.0,
                                backgroundImage:
                                    NetworkImage('${model?.image}'),
                              ),
                              const SizedBox(width: 10.0),
                              Column(
                                children: [
                                  Text(
                                    '${model?.name} ${model?.lastName}'
                                        .capitalize!,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  const SizedBox(width: 10.0),
                                  Text(
                                    'See your profile'.capitalize!,
                                    style: Theme.of(context).textTheme.overline,
                                  )
                                ],
                              ),
                            ],
                          ),
                          onTap: () {
                            navigateTo(
                              context,
                              ProfileScreen(
                                userModel: model!,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10.0),
                        separatorHorizontal(
                            height: 0.6, opacity: 0.6, padding: 0.0),
                        const SizedBox(height: 10.0),
                        Container(
                          height: 40.0,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                child: cubit.isDark == true
                                    ? Text(cubit.darkMode)
                                    : Text(cubit.lightMode),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  ThemeService().changeTheme();
                                  cubit.changeThemeMode();
                                },
                                child: cubit.isDark == true
                                    ? Icon(cubit.darkIcon, size: 24.0)
                                    : Icon(cubit.lightIcon, size: 24.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : loadingAnimation(context),
          ));
        },
      ),
    );
  }
}
