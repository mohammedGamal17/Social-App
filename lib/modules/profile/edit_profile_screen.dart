import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/cubit/app_cubit/app_cubit.dart';
import 'package:social/shared/cubit/app_cubit/app_states.dart';

import '../../models/user_model/user_model.dart';

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
          var password = TextEditingController();
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
                                    image: NetworkImage(
                                      '${userModel.coverImage}',
                                    ),
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.camera_alt_outlined),
                                  color: Colors.grey),
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
                                  radius: 57.0,
                                  child: Image(
                                    width: 100.0,
                                    height: 100.0,
                                    image: NetworkImage('${userModel.image}'),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.camera_alt_outlined),
                                  color: Colors.grey),
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
                      autoFocus: true,
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
                      autoFocus: true,
                      textInputType: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    textFormField(
                      controller: password,
                      validate: (value) {
                        if (value.isEmpty ||
                            value.length < 8 ||
                            value.length > 50) {
                          return 'Please Enter Valid Password';
                        }
                        return null;
                      },
                      labelText: 'Password',
                      prefix: Icons.lock_outline,
                      borderRadius: 20.0,
                      textInputType: TextInputType.visiblePassword,
                      isPassword: cubit.isPassword,
                      suffix: cubit.suffix,
                      suffixOnTap: () {
                        cubit.changePasswordVisibility();
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
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
