import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:social/models/user_model/user_model.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/cubit/app_cubit/app_cubit.dart';
import 'package:social/shared/cubit/app_cubit/app_states.dart';

import '../../shared/style/colors.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getUserData(context),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: cubit.userModel != null
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          if (state is GetHomeDataLoading)
                            loadingAnimation(context),
                          photoBuilder(context),
                          if (cubit.profileImage != null ||
                              cubit.coverImage != null)
                            Row(
                              children: [
                                if (cubit.profileImage != null)
                                  Expanded(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 40.0,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              cubit.uploadProfileImage(context);
                                            },
                                            child: const Text('Update Profile'),
                                          ),
                                        ),
                                        const SizedBox(height: 5.0),
                                        if (state is UploadProfileImageLoading)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 1.8),
                                            child: LinearProgressIndicator(
                                              color: lightBackground,
                                              backgroundColor: darkBackground,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                const SizedBox(width: 5.0),
                                if (cubit.coverImage != null)
                                  Expanded(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 40.0,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              cubit.uploadCoverImage(context);
                                            },
                                            child: const Text('Update Cover'),
                                          ),
                                        ),
                                        const SizedBox(height: 5.0),
                                        if (state is UploadCoverImageLoading)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: LinearProgressIndicator(
                                              color: lightBackground,
                                              backgroundColor: darkBackground,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          const SizedBox(height: 10.0),
                          nameBuilder(context),
                          const SizedBox(height: 10.0),
                          bioBuilder(context),
                          const SizedBox(height: 15.0),
                          statusBarBuilder(context),
                          const SizedBox(height: 15.0),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Add Photo',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              OutlinedButton(
                                onPressed: () {
                                  navigateTo(
                                    context,
                                    EditProfileScreen(
                                      userModel: userModel,
                                    ),
                                  );
                                },
                                child: const Icon(Icons.edit),
                              )
                            ],
                          )
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
                            '${userModel.coverImage}',
                          ),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Choose your picker'),
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        actions: [
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    cubit.getCoverImageCamera(
                                      context,
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.camera_alt_outlined,
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        'Camera',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    cubit.getCoverImageGallery(context);
                                  },
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.image,
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        'Gallery',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.camera_alt_outlined),
                color: Colors.grey,
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
                  backgroundImage: cubit.profileImage != null
                      ? FileImage(cubit.profileImage!) as ImageProvider
                      : NetworkImage(
                          '${userModel.image}',
                        ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Choose your picker'),
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        actions: [
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    cubit.getProfileImageCamera(
                                      context,
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.camera_alt_outlined,
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        'Camera',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    cubit.getProfileImageGallery(
                                      context,
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.image,
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        'Gallery',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.camera_alt_outlined),
                color: Colors.grey,
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
      child: Text('${userModel.name} ${userModel.lastName}'.capitalize!,
          style: Theme.of(context).textTheme.headline5),
    );
  }

  Widget bioBuilder(context) {
    return Container(
      width: double.infinity,
      alignment: AlignmentDirectional.center,
      child: Text('${userModel.bio}'.capitalize!,
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
