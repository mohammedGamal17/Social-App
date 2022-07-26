import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social/models/chat_model/chat_model.dart';

import 'package:social/models/user_model/user_model.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/components/constants.dart';

import 'package:social/shared/cubit/app_cubit/app_cubit.dart';

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
            body: Column(
              children: [
                cubit.messages.isNotEmpty
                    ? Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            var message = cubit.messages[index];
                            if (uId == message.senderId) {
                              return sendMessages(message);
                            }
                            return receiverMessages(message);
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10.0),
                          itemCount: cubit.messages.length,
                        ),
                      )
                    : loadingAnimation(context),
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
                      Expanded(
                        child: TextFormField(
                          key: formKey,
                          maxLines: 1,
                          controller: messageController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type Your Message ...',
                            hintStyle: Theme.of(context).textTheme.bodyText2,
                          ),
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                        child: MaterialButton(
                          minWidth: 1.0,
                          onPressed: () {
                            AppCubit.get(context).sendMessages(
                              messageText: messageController.text,
                              receiverId: userModel.uId!,
                              messageTime: DateTime.now().toString(),
                            );
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
          );
        },
      ),
    );
  }

  Widget sendMessages(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Column(
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
            child: Text(
              model.messageText,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget receiverMessages(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Column(
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
            child: Text(
              model.messageText,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
