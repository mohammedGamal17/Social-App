import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:social/modules/home/home_screen.dart';
import 'package:social/shared/cubit/app_cubit/app_cubit.dart';
import 'package:social/shared/cubit/app_cubit/app_states.dart';

import '../../layout/Layout_screen.dart';
import '../../models/user_model/user_model.dart';
import '../../shared/components/components.dart';
import '../profile/profile_screen.dart';

class PostScreen extends StatelessWidget {
  PostScreen({super.key, required this.model});

  final UserModel model;
  final post = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  shadowColor: const Color(0xFF0066CC),
                  elevation: 3.0,
                  color: const Color(0xFF66B2FF),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            InkWell(
                              child: CircleAvatar(
                                radius: 25.0,
                                backgroundImage: NetworkImage('${model.image}'),
                              ),
                              onTap: () {
                                navigateTo(
                                  context,
                                  ProfileScreen(
                                    model: model,
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
                                      '${model.name} ${model.lastName}'
                                          .capitalize!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                ],
                              ),
                              onTap: () {
                                navigateTo(
                                    context, ProfileScreen(model: model));
                              },
                            ),
                          ],
                        ),
                      ),
                      separatorHorizontal(height: 0.5, opacity: 0.6),
                      Card(
                        shadowColor: const Color(0xFF0066CC),
                        elevation: 3.0,
                        color: const Color(0xFFCCE5FF),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Expanded(
                            child: SizedBox(
                              height: 350.0,
                              child: TextField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'What\'s on your mind?'),
                                controller: post,
                                keyboardType: TextInputType.text,
                                maxLines: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: decorationButton(
                          context,
                          text: 'Post',
                          borderRadius: 5.0,
                          onTap: (){navigateTo(context, const LayOutScreen());}
                        ),
                      )
                    ],
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
