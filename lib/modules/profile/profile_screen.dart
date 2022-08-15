import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:social/models/user_model/user_model.dart';
import 'package:social/modules/profile/user_screen.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/cubit/app_cubit/app_cubit.dart';
import 'package:social/shared/cubit/app_cubit/app_states.dart';
import 'package:video_player/video_player.dart';

import '../../models/post_model/post_model.dart';
import '../../shared/style/colors.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key, required this.userModel});

  final UserModel userModel;

  final GlobalKey<RefreshIndicatorState> refIndKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getUserData(context)
        ..getMyPosts(context),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: cubit.userModel != null && cubit.myPosts != null
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
                                              horizontal: 4,
                                            ),
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
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => postBuilderItem(
                              context,
                              AppCubit.get(context).myPosts[index],
                              AppCubit.get(context).userModel!,
                              index,
                            ),
                            separatorBuilder: (context, index) =>
                                separatorHorizontal(height: 0.1, opacity: 0.5),
                            itemCount: AppCubit.get(context).myPosts.length,
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
    AppCubit cubit = AppCubit.get(context);
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
                '${cubit.myPosts.length}',
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget postBuilderItem(context, PostModel model, UserModel userModel, index) {
    AppCubit cubit = AppCubit.get(context);
    VideoPlayerController? controller;
    controller = VideoPlayerController.network('${model.postVideo}')
      ..initialize();
    return Card(
      shadowColor: const Color(0xFF0066CC),
      elevation: 3.0,
      color: Theme.of(context).backgroundColor,
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
          if (model.postImage != '') const SizedBox(height: 5.0),
          if (model.postImage != '')
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 10.0),
              child: Image(
                image: NetworkImage('${model.postImage}'),
                fit: BoxFit.cover,
              ),
            ),
          if (model.postImage != '')
            separatorHorizontal(height: 0.5, opacity: 0.4),
          if (model.postVideo != '') const SizedBox(height: 5.0),
          if (model.postVideo != '')
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 10.0),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            controller?.pause();
                          },
                          icon: const Icon(Icons.pause, color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            controller?.play();
                          },
                          icon:
                              const Icon(Icons.play_arrow, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          if (model.postVideo != '')
            separatorHorizontal(height: 0.5, opacity: 0.4),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                const Icon(Icons.favorite, size: 14.0),
                const SizedBox(width: 5.0),
                Text(
                  '${cubit.likesCount[index]}',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(fontSize: 14.0),
                ),
              ],
            ),
          ),
          separatorHorizontal(height: 0.1, opacity: 0.1),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: InkWell(
                    onTap: () {
                      cubit.likePost(cubit.postsId[index]);
                    },
                    child: Column(
                      children: [
                        Icon(cubit.likedIcon, size: 24.0),
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
}
