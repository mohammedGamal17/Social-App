import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social/modules/auth_screens/login_screen.dart';
import 'package:social/shared/cubit/auth_cubit/auth_cubit.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/auth_cubit/auth_states.dart';
import '../../shared/style/colors.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();

  final isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            return navigateToAndReplace(
              context,
              LoginScreen(),
            );
          }
        },
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Images/regpage.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SIGN UP',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              const SizedBox(height: 15.0),
                              textFormField(
                                controller: name,
                                validate: (value) {
                                  if (value.isEmpty ||
                                      value.length < 4 ||
                                      value.length > 50 ||
                                      !RegExp(r'^[a-z A-Z]+$')
                                          .hasMatch(value)) {
                                    return 'Please Enter Yor Valid First Name';
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
                                      value.length > 50 ||
                                      !RegExp(r'^[a-z A-Z]+$')
                                          .hasMatch(value)) {
                                    return 'Please Enter Your Valid Last Name';
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
                                      value.length > 50 ||
                                      !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                          .hasMatch(value)) {
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
                                      value.length > 50 ||
                                      !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                                          .hasMatch(value)) {
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
                              state is! RegisterLoadingState
                                  ? InkWell(
                                      onTap: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.userRegister(context,
                                              email: email.text,
                                              password: password.text,
                                              name: name.text,
                                              phone: phone.text,
                                              lastName: lastName.text);
                                        }
                                      },
                                      child: Center(
                                        child: Container(
                                          height: 40.0,
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            color: buttonColor,
                                            gradient: LinearGradient(
                                              begin:
                                                  AlignmentDirectional.topStart,
                                              end: AlignmentDirectional
                                                  .bottomEnd,
                                              colors: [
                                                HexColor('CCE5FF'),
                                                HexColor('007FFF'),
                                              ],
                                            ),
                                          ),
                                          child: Text(
                                            'SIGN UP'.capitalize!,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: HexColor('004C99'),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'RobotoCondensed',
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Center(child: loadingAnimation(context,text: '')),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
