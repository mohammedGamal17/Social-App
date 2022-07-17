import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/cubit/app_cubit/app_cubit.dart';
import 'package:social/shared/cubit/app_cubit/app_states.dart';

import '../../models/user_model/user_model.dart';
import '../../shared/style/colors.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          var firstName = TextEditingController();
          var lastName = TextEditingController();
          var email = TextEditingController();
          var phone = TextEditingController();
          var bio = TextEditingController();

          firstName.text = userModel.name!;
          lastName.text = userModel.lastName!;
          email.text = userModel.email;
          phone.text = userModel.phone!;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Edit'),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
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
                                        ? FileImage(cubit.coverImage!,
                                            scale: 1.0) as ImageProvider
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
                                          borderRadius:
                                          BorderRadius.circular(5.0),
                                        ),
                                        actions: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    cubit.getCoverImageCamera(context);
                                                  },
                                                  child: Column(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .camera_alt_outlined,
                                                      ),
                                                      const SizedBox(
                                                          height: 5.0),
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
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 56.0,
                                  backgroundImage: cubit.profileImage != null
                                      ? FileImage(cubit.profileImage!) as ImageProvider
                                      : NetworkImage('${userModel.image}'),
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
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        actions: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    cubit.getProfileImageCamera(context);
                                                  },
                                                  child: Column(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .camera_alt_outlined,
                                                      ),
                                                      const SizedBox(
                                                          height: 5.0),
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
                                                    cubit.getProfileImageGallery(context);
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
                    ),
                    const SizedBox(height: 10.0),
                    textFormField(
                      controller: firstName,
                      validate: (value) {
                        if (value.isEmpty ||
                            value.length < 4 ||
                            value.length > 50) {
                          return 'Please Enter Yor First Name';
                        }
                        return null;
                      },
                      labelText: 'First Name',
                      prefix: Icons.account_circle_outlined,
                      borderRadius: 15.0,
                      autoFocus: true,
                      textInputType: TextInputType.name,
                      hintText: userModel.name,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    textFormField(
                      controller: lastName,
                      validate: (value) {
                        if (value.isEmpty ||
                            value.length < 4 ||
                            value.length > 50) {
                          return 'Please Enter Yor Last Name';
                        }
                        return null;
                      },
                      labelText: 'Last Name',
                      prefix: Icons.account_circle_outlined,
                      borderRadius: 15.0,
                      textInputType: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    textFormField(
                      controller: email,
                      validate: (value) {
                        if (value.isEmpty ||
                            value.length < 14 ||
                            value.length > 50) {
                          return 'Please Enter Valid Email';
                        }
                        return null;
                      },
                      labelText: 'Email',
                      prefix: Icons.email_outlined,
                      borderRadius: 20.0,
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    textFormField(
                      controller: phone,
                      validate: (value) {
                        if (value.isEmpty ||
                            value.length < 11 ||
                            value.length > 50) {
                          return 'Please Enter Valid Phone';
                        }
                        return null;
                      },
                      labelText: 'Phone',
                      prefix: Icons.phone,
                      borderRadius: 15.0,
                      textInputType: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: bio,
                      maxLines: 10,
                      maxLength: 100,
                      minLines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          if (value.length < 25) {
                            return 'Bio must me more than 25 character';
                          }
                          if (value.length > 100) {
                            return 'Bio must me less than 100 character';
                          }
                          return "Mustn't be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: iconColor, width: 3.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: lightBackground, width: 1.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.5),
                        ),
                        focusColor: iconColor,
                        hoverColor: HexColor('023E8A'),
                        filled: true,
                        labelText: 'Bio',
                        prefixStyle: TextStyle(color: textColor),
                        labelStyle: TextStyle(color: textColor),
                        hintStyle: TextStyle(color: textColor),
                        counterStyle: TextStyle(color: textColor),
                        helperStyle: TextStyle(color: textColor),
                      ),
                      style: TextStyle(color: iconColor),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
