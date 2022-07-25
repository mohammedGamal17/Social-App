import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:social/models/user_model/user_model.dart';
import 'package:social/modules/messages/chat_screen.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/cubit/app_cubit/app_cubit.dart';
import 'package:social/shared/cubit/app_cubit/app_states.dart';

class MessagesScreen extends StatelessWidget {
  MessagesScreen({super.key});

  final GlobalKey<RefreshIndicatorState> refIndKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getAllUsers(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            body: cubit.users.isNotEmpty
                ? RefreshIndicator(
                    key: refIndKey,
                    strokeWidth: 4.0,
                    onRefresh: () async {
                      return Future<void>.delayed(
                        const Duration(seconds: 1),
                        () {},
                      );
                    },
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => userItemBuilder(
                        context,
                        cubit.users[index],
                      ),
                      separatorBuilder: (context, index) =>
                          separatorHorizontal(opacity: 0.3, height: 0.5),
                      itemCount: cubit.users.length,
                    ),
                  )
                : loadingAnimation(context),
          );
        },
      ),
    );
  }

  Widget userItemBuilder(context, UserModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: InkWell(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage('${model.image}'),
            ),
            const SizedBox(width: 10.0),
            Text(
              '${model.name} ${model.lastName}'.capitalizeFirst!,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
        onTap: () {
          navigateTo(context, ChatScreen(userModel: model));
        },
      ),
    );
  }
}
