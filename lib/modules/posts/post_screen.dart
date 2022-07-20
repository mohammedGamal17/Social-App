import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:social/shared/cubit/app_cubit/app_cubit.dart';
import 'package:social/shared/cubit/app_cubit/app_states.dart';

import '../../layout/Layout_screen.dart';
import '../../models/user_model/user_model.dart';
import '../../shared/components/components.dart';
import '../profile/profile_screen.dart';

class PostScreen extends StatelessWidget {
  PostScreen({super.key, required this.userModel});

  final UserModel userModel;
  final post = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                shadowColor: const Color(0xFF0066CC),
                elevation: 20.0,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          InkWell(
                            child: CircleAvatar(
                              radius: 25.0,
                              backgroundImage:
                                  NetworkImage('${userModel.image}'),
                            ),
                            onTap: () {
                              navigateTo(
                                context,
                                ProfileScreen(
                                  userModel: userModel,
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 10.0),
                          InkWell(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${userModel.name} ${userModel.lastName}'
                                      .capitalize!,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                            onTap: () {
                              navigateTo(
                                  context, ProfileScreen(userModel: userModel));
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'What\'s on your mind ?',
                            hintStyle: Theme.of(context).textTheme.bodyText2,
                          ),
                          style: Theme.of(context).textTheme.bodyText2,
                          controller: post,
                          keyboardType: TextInputType.text,
                          maxLines: 1000,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: decorationButton(context,
                          text: 'Post', borderRadius: 5.0, onTap: () {
                        navigateTo(context, const LayOutScreen());
                      }),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
