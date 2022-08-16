import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:social/models/chat_model/chat_model.dart';

import 'package:social/models/user_model/user_model.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/components/constants.dart';

import 'package:social/shared/cubit/app_cubit/app_cubit.dart';
import 'package:video_player/video_player.dart';

import '../../shared/cubit/app_cubit/app_states.dart';
import '../../shared/style/colors.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key, required this.userModel}) : super(key: key);
  final UserModel userModel;
  final messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getMessages(receiverId: userModel.uId!),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          DateTime now = DateTime.now();
          String formattedDate = DateFormat('yyyy-MM-dd – hh:mm a').format(now);
          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage('${userModel.image}'),
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    '${userModel.name} ${userModel.lastName}'.capitalizeFirst!,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  cubit.messages.isNotEmpty
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                var message = cubit.messages[index];
                                if (uId == message.senderId) {
                                  return sendMessages(message, index, context);
                                }
                                return receiverMessages(message, context);
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 10.0),
                              itemCount: cubit.messages.length,
                              reverse: true,
                            ),
                          ),
                        )
                      : loadingAnimation(context),
                  if (state is UploadChatImageLoading)
                    loadingAnimation(context, text: 'Uploading ...'),
                  if (state is ChatImagePickedSuccess)
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
                                    image: FileImage(cubit.chatImage!),
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) => Column(
                                      children: [
                                        const Icon(Icons.photo_camera,
                                            size: 50.0),
                                        const SizedBox(height: 10.0),
                                        Text(
                                          'Click Send ...',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        )
                                      ],
                                    ),
                                    loadingBuilder:
                                        (context, child, loadingProgress) =>
                                            loadingAnimation(context),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit.removeChatPhoto();
                                },
                                icon: const Icon(Icons.close),
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  if (state is UploadChatVideoLoading)
                    loadingAnimation(context, text: 'Uploading ...'),
                  if (state is ChatVideoPickedSuccess)
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
                                    image: FileImage(cubit.chatVideo!),
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) => Column(
                                      children: [
                                        const Icon(Icons.videocam, size: 50.0),
                                        const SizedBox(height: 10.0),
                                        Text(
                                          'Click Send ...',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        )
                                      ],
                                    ),
                                    loadingBuilder:
                                        (context, child, loadingProgress) =>
                                            loadingAnimation(context),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit.removeChatVideo();
                                },
                                icon: const Icon(Icons.close),
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: iconColor.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 50.0,
                          child: MaterialButton(
                            minWidth: 1.0,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: const [
                                        Expanded(
                                          child: Text('Choose your picker'),
                                        ),
                                        CloseButton(),
                                      ],
                                    ),
                                    shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    actions: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Row(
                                                            children: const [
                                                              Expanded(
                                                                  child: Text(
                                                                      'Choose your picker')),
                                                              CloseButton(),
                                                            ],
                                                          ),
                                                          shape:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                          ),
                                                          actions: [
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      cubit.chatImageCamera(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        const Icon(
                                                                          Icons
                                                                              .camera_alt_outlined,
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                5.0),
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
                                                                const SizedBox(
                                                                    width:
                                                                        10.0),
                                                                Expanded(
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      cubit.chatImageGallery(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        const Icon(
                                                                          Icons
                                                                              .image,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              5.0,
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
                                                  icon: const Icon(Icons
                                                      .photo_library_outlined),
                                                ),
                                                const Text('Image'),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10.0),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Row(
                                                            children: const [
                                                              Expanded(
                                                                child: Text(
                                                                    'Choose your picker'),
                                                              ),
                                                              CloseButton(),
                                                            ],
                                                          ),
                                                          shape:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                          ),
                                                          actions: [
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      cubit.chatCameraVideo(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        const Icon(
                                                                          Icons
                                                                              .camera_alt_outlined,
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                5.0),
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
                                                                const SizedBox(
                                                                    width:
                                                                        10.0),
                                                                Expanded(
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      cubit.chatGalleryVideo(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        const Icon(
                                                                          Icons
                                                                              .image,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              5.0,
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
                                                  icon: const Icon(Icons
                                                      .ondemand_video_outlined),
                                                ),
                                                const Text('Vedio'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: Icon(
                              FontAwesomeIcons.paperclip,
                              color: iconColor,
                              size: 20.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        Expanded(
                          child: TextFormField(
                            key: formKey,
                            maxLines: 1,
                            autofocus: false,
                            controller: messageController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type Your Message ...',
                              hintStyle: Theme.of(context).textTheme.bodyText2,
                            ),
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        SizedBox(
                          height: 50.0,
                          child: MaterialButton(
                            minWidth: 1.0,
                            onPressed: () {
                              if (cubit.chatImage == null &&
                                  cubit.chatVideo == null) {
                                AppCubit.get(context).sendMessages(
                                  messageText: messageController.text,
                                  receiverId: userModel.uId!,
                                  messageTime: DateTime.now().toString(),
                                  date: formattedDate.toString(),
                                );
                              } else if (cubit.chatImage != null) {
                                AppCubit.get(context).uploadChatImage(
                                  messageText: messageController.text,
                                  receiverId: userModel.uId!,
                                  messageTime: DateTime.now().toString(),
                                  date: formattedDate.toString(),
                                  context,
                                );
                              } else if (cubit.chatVideo != null) {
                                AppCubit.get(context).uploadChatVideo(
                                  messageText: messageController.text,
                                  receiverId: userModel.uId!,
                                  messageTime: DateTime.now().toString(),
                                  date: formattedDate.toString(),
                                  context,
                                );
                              }
                              messageController.clear();
                              cubit.chatImage = '' as File?;
                              cubit.chatVideo = '' as File?;
                            },
                            color: iconColor,
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget sendMessages(MessageModel model, index, context) {
    VideoPlayerController? controller;
    controller = VideoPlayerController.network('${model.video}')..initialize();
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              color: HexColor('004C99'),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
              ),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: Column(
              children: [
                Text(
                  model.messageText,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                if (model.image != '')
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Image(
                            image: NetworkImage('${model.image}'),
                            fit: BoxFit.fill,
                          );
                        },
                      );
                    },
                    child: Image(
                      image: NetworkImage('${model.image}'),
                      fit: BoxFit.cover,
                      width: 200,
                      height: 300,
                      errorBuilder: (context, error, stackTrace) => Column(
                        children: [
                          const Icon(Icons.no_photography, size: 50.0),
                          const SizedBox(height: 10.0),
                          Text(
                            'Photo did\'t load ...',
                            style: Theme.of(context).textTheme.headline5,
                          )
                        ],
                      ),
                    ),
                  ),
                if (model.video != '')
                  AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  ),
                if (model.video != '')
                  Row(
                    children: [
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            controller?.play();
                          },
                          icon:
                              const Icon(Icons.play_arrow, color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            controller?.pause();
                          },
                          icon: const Icon(Icons.pause, color: Colors.white),
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ),
          const SizedBox(height: 3.0),
          Text(
            model.date,
            style: const TextStyle(fontSize: 9.0),
          )
        ],
      ),
    );
  }

  Widget receiverMessages(MessageModel model, context) {
    VideoPlayerController? controller;
    controller = VideoPlayerController.network('${model.video}')..initialize();
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: HexColor('66B2FF'),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
              ),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: Column(
              children: [
                Text(
                  model.messageText,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                if (model.image != '')
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Image(
                            image: NetworkImage('${model.image}'),
                            fit: BoxFit.fill,
                          );
                        },
                      );
                    },
                    child: Image(
                      image: NetworkImage('${model.image}'),
                      fit: BoxFit.cover,
                      width: 200,
                      height: 300,
                      errorBuilder: (context, error, stackTrace) => Column(
                        children: [
                          const Icon(Icons.no_photography, size: 50.0),
                          const SizedBox(height: 10.0),
                          Text(
                            'Photo did\'t load ...',
                            style: Theme.of(context).textTheme.headline5,
                          )
                        ],
                      ),
                    ),
                  ),
                if (model.video != '')
                  AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  ),
                if (model.video != '')
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
                  )
              ],
            ),
          ),
          const SizedBox(height: 3.0),
          Text(
            model.date,
            style: const TextStyle(fontSize: 9.0),
          )
        ],
      ),
    );
  }
}
