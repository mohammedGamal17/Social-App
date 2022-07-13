import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social/shared/cubit/app_cubit/app_cubit.dart';
import 'package:social/shared/cubit/app_cubit/app_states.dart';

import '../../models/user_model/user_model.dart';
import '../../shared/components/components.dart';
import '../../shared/style/colors.dart';

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
            color: const Color(0xFFB0D5FF),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1657727705~exp=1657728305~hmac=337639fbb551c90723bd4680ffaa477ea015c3c3e9b3360af86d9593052de99e&w=996'),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
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
          Card(
            shadowColor: const Color(0xFF0066CC),
            elevation: 3.0,
            color: const Color(0xFFB0D5FF),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1657727705~exp=1657728305~hmac=337639fbb551c90723bd4680ffaa477ea015c3c3e9b3360af86d9593052de99e&w=996'),
                      ),
                      const SizedBox(width: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Mohammed Gamal'),
                          Text(
                            '10:00 pm',
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: textColor.withOpacity(0.6),
                                    ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_horiz_outlined),
                      ),
                    ],
                  ),
                ),
                separatorHorizontal(height: 0.1, opacity: 0.3),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Expanded(
                      child: Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
                        style: Theme.of(context).textTheme.bodyText2,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
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
                          const Icon(Icons.favorite, size: 10.0),
                          const SizedBox(width: 5.0),
                          Text(
                            '1',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(FontAwesomeIcons.comment, size: 10.0),
                          const SizedBox(width: 5.0),
                          Text(
                            '1',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                separatorHorizontal(height: 0.1, opacity: 0.3),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_outlined, size: 16.0),
                          splashColor: const Color(0xFF66B2FF),
                        ),
                        const Text(
                          'Like',
                          style: TextStyle(
                            height: 0.3,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon:
                              const Icon(FontAwesomeIcons.comment, size: 16.0),
                          splashColor: const Color(0xFF66B2FF),
                        ),
                        const Text(
                          'Comment',
                          style: TextStyle(
                            height: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5.0),
              ],
            ),
          ),
          Card(
            shadowColor: const Color(0xFF0066CC),
            elevation: 3.0,
            color: const Color(0xFFB0D5FF),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1657727705~exp=1657728305~hmac=337639fbb551c90723bd4680ffaa477ea015c3c3e9b3360af86d9593052de99e&w=996'),
                      ),
                      const SizedBox(width: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Mohammed Gamal'),
                          Text(
                            '10:00 pm',
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: textColor.withOpacity(0.6),
                                    ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_horiz_outlined),
                      ),
                    ],
                  ),
                ),
                separatorHorizontal(height: 0.1, opacity: 0.3),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Expanded(
                      child: Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
                        style: Theme.of(context).textTheme.bodyText2,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.favorite, size: 10.0),
                          Text('Like',
                              style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(FontAwesomeIcons.comment, size: 10.0),
                          Text('Comment',
                              style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                    ],
                  ),
                ),
                separatorHorizontal(height: 0.1, opacity: 0.3),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_outlined, size: 14.0),
                          splashColor: const Color(0xFF66B2FF),
                        ),
                        const Text(
                          'Like',
                          style: TextStyle(
                            height: 0.3,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon:
                              const Icon(FontAwesomeIcons.comment, size: 14.0),
                          splashColor: const Color(0xFF66B2FF),
                        ),
                        const Text(
                          'Comment',
                          style: TextStyle(
                            height: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5.0),
              ],
            ),
          ),
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
