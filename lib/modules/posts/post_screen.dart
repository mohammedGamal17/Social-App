import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:social/shared/cubit/app_cubit/app_cubit.dart';
import 'package:social/shared/cubit/app_cubit/app_states.dart';

import '../../models/user_model/user_model.dart';
import '../../shared/components/components.dart';
import '../profile/profile_screen.dart';

class PostScreen extends StatelessWidget {
  PostScreen({super.key, required this.userModel});

  final UserModel userModel;
  final post = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Create Post'),
              actions: [
                TextButton(
                  onPressed: () {
                    var now = DateTime.now();
                    String formattedDate =
                        DateFormat('yyyy-MM-dd , kk:mm a').format(now);
                    if (formKey.currentState!.validate()) {
                      if (AppCubit.get(context).postImage == null) {
                        AppCubit.get(context).createPost(
                          context,
                          dateTime: formattedDate.toString(),
                          text: post.text,
                          uId: userModel.uId!,
                          name: userModel.name!,
                          lastName: userModel.lastName!,
                          email: userModel.email!,
                          image: userModel.image!,
                          coverImage: userModel.coverImage!,
                          bio: userModel.bio!,
                        );
                      } else {
                        AppCubit.get(context).uploadPostImage(
                          context,
                          dateTime: formattedDate.toString(),
                          text: post.text,
                          uId: userModel.uId!,
                          name: userModel.name!,
                          lastName: userModel.lastName!,
                          email: userModel.email!,
                          image: userModel.image!,
                          coverImage: userModel.coverImage!,
                          bio: userModel.bio!,
                        );
                      }
                    }
                  },
                  child: const Text('Post'),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  if (state is CreatePostLoadingState)
                    loadingAnimation(context),
                  Row(
                    children: [
                      InkWell(
                        child: CircleAvatar(
                          radius: 25.0,
                          backgroundImage: NetworkImage('${userModel.image}'),
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
                  const SizedBox(height: 10.0),
                  separatorHorizontal(height: 0.6, opacity: 0.6, padding: 5.0),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'What\'s on your mind ?',
                            hintStyle: Theme.of(context).textTheme.bodyText2,
                          ),
                          style: Theme.of(context).textTheme.bodyText2,
                          controller: post,
                          maxLines: 20,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Write Your Post';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  if (cubit.postImage != null)
                    SizedBox(
                      height: 130,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: SizedBox(
                                  child: Image(
                                    image: FileImage(
                                        AppCubit.get(context).postImage!),
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  AppCubit.get(context).removePickedPhoto();
                                },
                                icon: const Icon(Icons.close),
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          height: 40.0,
                          child: OutlinedButton(
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
                                                cubit.postImageCamera(context);
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
                                                cubit.postImageGallery(context);
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
                            child: const Text('Add Photo'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          height: 40.0,
                          child: OutlinedButton(
                            onPressed: () {},
                            child: const Text('# Tags'),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
