import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:social/modules/profile/profile_screen.dart';
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
      create: (context) => AppCubit()..getUserData(context),
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
                                model: model,
                              ));
                        },
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            navigateTo(context,  PostScreen(model: model,));
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
            itemBuilder: (context, index) =>
                postBuilderItem(context, AppCubit.get(context).userModel!),
            separatorBuilder: (context, index) =>
                separatorHorizontal(height: 0.1, opacity: 0.5),
            itemCount: 10,
          )
        ],
      ),
    );
  }

  Widget postBuilderItem(context, UserModel model) {
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
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage('${model.image}'),
                  ),
                  onTap: () {
                    navigateTo(context, ProfileScreen(model: model));
                  },
                ),
                const SizedBox(width: 10.0),
                InkWell(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('${model.name} ${model.lastName}'.capitalize!,
                          style: Theme.of(context).textTheme.subtitle2),
                      Text('10:00 pm',
                          style: Theme.of(context).textTheme.headline1),
                    ],
                  ),
                  onTap: () {
                    navigateTo(context, ProfileScreen(model: model));
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              width: double.infinity,
              child: Expanded(
                child: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
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
          const SizedBox(height: 10.0),
          const Image(
            image: NetworkImage(
                'https://img.freepik.com/free-photo/emotional-bearded-male-has-surprised-facial-expression-astonished-look-dressed-white-shirt-with-red-braces-points-with-index-finger-upper-right-corner_273609-16001.jpg?t=st=1657727705~exp=1657728305~hmac=6fc3387378f08f2436466b0cbbe90edffff83bfc2aaa568d1317e12aaf36dc38&w=996'),
            fit: BoxFit.cover,
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
                    backgroundImage: NetworkImage('${model.image}'),
                  ),
                  onTap: () {
                    navigateTo(context, ProfileScreen(model: model));
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
                            ? const Icon(Icons.favorite_outlined, size: 24.0)
                            : const Icon(Icons.favorite_outline, size: 24.0),
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
