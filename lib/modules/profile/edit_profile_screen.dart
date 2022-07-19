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
      create: (context) => AppCubit()..getUserData(context),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          var firstName = TextEditingController();
          var lastName = TextEditingController();
          var phone = TextEditingController();
          var bio = TextEditingController();

          firstName.text = userModel.name!;
          lastName.text = userModel.lastName!;
          phone.text = userModel.phone!;
          bio.text = userModel.bio!;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Edit'),
              actions: [
                TextButton(
                  onPressed: () {
                    //cubit.uploadProfileImage(context);
                    cubit.updateData(
                      name: firstName.text,
                      lastName: lastName.text,
                      phone: phone.text,
                      bio: bio.text,
                      context,
                    );
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
            body: state is GetHomeDataSuccess
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          if (state is GetHomeDataLoading)
                            loadingAnimation(context),
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
                            maxLength: 50,
                            minLines: 1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                if (value.length < 10) {
                                  return 'Bio must me more than 10 character';
                                }
                                if (value.length > 50) {
                                  return 'Bio must me less than 50 character';
                                }
                                return "Mustn't be empty";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: iconColor, width: 3.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: lightBackground, width: 1.0),
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
                  )
                : loadingAnimation(context),
          );
        },
      ),
    );
  }
}
