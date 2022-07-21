import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:social/models/post_model/post_model.dart';
import 'package:social/models/user_model/user_model.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/cubit/app_cubit/app_cubit.dart';
import 'package:social/shared/cubit/app_cubit/app_states.dart';

import '../../shared/style/colors.dart';
import 'edit_profile_screen.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key, required this.postModel});

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getPosts(context),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: cubit.posts != null
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          photoBuilder(context),
                          const SizedBox(height: 10.0),
                          nameBuilder(context),
                          const SizedBox(height: 10.0),
                          bioBuilder(context),
                          const SizedBox(height: 15.0),
                          statusBarBuilder(context),
                          const SizedBox(height: 15.0),
                        ],
                      ),
                    ),
                  )
                : loadingAnimation(context),
          );
        },
      ),
    );
  }

  Widget photoBuilder(context) {
    AppCubit cubit = AppCubit.get(context);
    return SizedBox(
      height: 220.0,
      width: double.infinity,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Align(
                alignment: AlignmentDirectional.topCenter,
                child: SizedBox(
                  height: 160.0,
                  child: Image(
                    image: cubit.coverImage != null
                        ? FileImage(cubit.coverImage!, scale: 1.0)
                    as ImageProvider
                        : NetworkImage(
                      '${postModel.coverImage}',
                    ),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                radius: 60.0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: CircleAvatar(
                  radius: 56.0,
                  backgroundImage:NetworkImage(
                    '${postModel.image}',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget nameBuilder(context) {
    return Container(
      width: double.infinity,
      alignment: AlignmentDirectional.center,
      child: Text('${postModel.name} ${postModel.lastName}'.capitalize!,
          style: Theme.of(context).textTheme.headline5),
    );
  }

  Widget bioBuilder(context) {
    return Container(
      width: double.infinity,
      alignment: AlignmentDirectional.center,
      child: Text('${postModel.bio}'.capitalize!,
          style: Theme.of(context).textTheme.caption),
    );
  }

  Widget statusBarBuilder(context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                'Posts',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                '10',
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'Photos',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                '100',
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'Followers',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                '10K',
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'Following',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                '500',
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
        ),
      ],
    );
  }
}
