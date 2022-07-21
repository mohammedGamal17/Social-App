import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:social/models/post_model/post_model.dart';
import 'package:social/modules/profile/profile_screen.dart';
import 'package:social/modules/profile/user_screen.dart';
import 'package:social/shared/cubit/app_cubit/app_cubit.dart';
import 'package:social/shared/cubit/app_cubit/app_states.dart';

import '../../models/user_model/user_model.dart';
import '../../shared/components/components.dart';
import '../posts/post_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getUserData(context)
        ..getPosts(context),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            body: cubit.userModel != null
                ? pageBuilder(context, cubit.userModel!)
                : loadingAnimation(context),
          );
        },
      ),
    );
  }

  Widget pageBuilder(context, UserModel model) {
    bool? isVerified = FirebaseAuth.instance.currentUser?.emailVerified;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          if (isVerified == false)
            alertMessage(
              context,
              data: 'You Need To Verification Your Account',
              buttonText: 'Send ',
              onPressed: () {
                firebaseSendNotification(context);
              },
            ),
          const SizedBox(height: 10.0),
          Card(
            shadowColor: const Color(0xFF0066CC),
            elevation: 3.0,
            color: const Color(0xFF66B2FF),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
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
                              userModel: model,
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            navigateTo(
                              context,
                              PostScreen(
                                userModel: model,
                              ),
                            );
                          },
                          radius: 30.0,
                          child: Container(
                            width: double.infinity,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: const Color(0xFFCCE5FF),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text('What\'s on your mind ?'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => postBuilderItem(
                context,
                AppCubit.get(context).posts[index],
                AppCubit.get(context).userModel!),
            separatorBuilder: (context, index) =>
                separatorHorizontal(height: 0.1, opacity: 0.5),
            itemCount: AppCubit.get(context).posts.length,
          )
        ],
      ),
    );
  }

  Widget postBuilderItem(context, PostModel model, UserModel userModel) {
    AppCubit cubit = AppCubit.get(context);
    return Card(
      shadowColor: const Color(0xFF0066CC),
      elevation: 3.0,
      color: const Color(0xFF66B2FF),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage('${model.image}'),
                      ),
                      const SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('${model.name} ${model.lastName}'.capitalize!,
                              style: Theme.of(context).textTheme.subtitle2),
                          Text('${model.dateTime}',
                              style: Theme.of(context).textTheme.headline1),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    navigateTo(context, UserScreen(postModel: model));
                  },
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz_outlined),
                ),
              ],
            ),
          ),
          separatorHorizontal(height: 0.5, opacity: 0.4),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              width: double.infinity,
              child: Expanded(
                child: Text(
                  '${model.text}',
                  style: Theme.of(context).textTheme.subtitle2,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 5.0, left: 10.0, right: 10.0, bottom: 0.0),
            child: SizedBox(
              width: double.infinity,
              child: Wrap(
                children: [
                  SizedBox(
                    height: 20.0,
                    child: MaterialButton(
                      onPressed: () {},
                      padding: const EdgeInsets.only(right: 10.0),
                      minWidth: 1.0,
                      height: 10.0,
                      child: Text('#PiGram',
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                    child: MaterialButton(
                      onPressed: () {},
                      padding: const EdgeInsets.only(right: 10.0),
                      minWidth: 1.0,
                      height: 10.0,
                      child: Text('#PiGram',
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                    child: MaterialButton(
                      onPressed: () {},
                      padding: const EdgeInsets.only(right: 10.0),
                      minWidth: 1.0,
                      height: 10.0,
                      child: Text('#PiGram',
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                    child: MaterialButton(
                      onPressed: () {},
                      padding: const EdgeInsets.only(right: 10.0),
                      minWidth: 1.0,
                      height: 10.0,
                      child: Text('#PiGram',
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                    child: MaterialButton(
                      onPressed: () {},
                      padding: const EdgeInsets.only(right: 10.0),
                      minWidth: 1.0,
                      height: 10.0,
                      child: Text('#PiGram',
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                    child: MaterialButton(
                      onPressed: () {},
                      padding: const EdgeInsets.only(right: 10.0),
                      minWidth: 1.0,
                      height: 10.0,
                      child: Text('#PiGram',
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                    child: MaterialButton(
                      onPressed: () {},
                      padding: const EdgeInsets.only(right: 10.0),
                      minWidth: 1.0,
                      height: 10.0,
                      child: Text('#PiGram',
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (model.postImage != '')
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 10.0),
              child: Image(
                image: NetworkImage('${model.postImage}'),
                fit: BoxFit.cover,
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Row(
                  children: [
                    const Icon(Icons.favorite, size: 14.0),
                    const SizedBox(width: 5.0),
                    Text(
                      '${AppCubit.get(context).likeNum}',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.copyWith(fontSize: 14.0),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(FontAwesomeIcons.comment, size: 14.0),
                    const SizedBox(width: 5.0),
                    Text(
                      '1',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.copyWith(fontSize: 14.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
          separatorHorizontal(height: 0.2, opacity: 0.3),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage('${userModel.image}'),
                  ),
                  onTap: () {
                    navigateTo(context, ProfileScreen(userModel: userModel));
                  },
                ),
                const SizedBox(width: 5.0),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: const Color(0xFFCCE5FF),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Write a Comment ..'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: InkWell(
                    onTap: () {
                      AppCubit.get(context).changeLikeIcon();
                      AppCubit.get(context).likeCount();
                    },
                    child: Column(
                      children: [
                        AppCubit.get(context).isLike == true
                            ? Icon(cubit.likedIcon, size: 24.0)
                            : Icon(cubit.disLikeIcon, size: 24.0),
                        Text(
                          'Like',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(fontSize: 14.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5.0),
        ],
      ),
    );
  }

  Future<void>? firebaseSendNotification(context) {
    return FirebaseAuth.instance.currentUser
        ?.sendEmailVerification()
        .then((value) {
      snack(context, content: 'Code Send Successfully Check Your Mail');
    }).catchError((onError) {
      snack(context,
          content: 'Code Did Not Send !! ${onError.toString()}',
          bgColor: Colors.red);
    });
  }
}
