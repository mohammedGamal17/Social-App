import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:social/main.dart';
import 'package:social/modules/auth_screens/register_screen.dart';
import 'package:social/modules/home_screen.dart';
import 'package:social/shared/components/components.dart';

import '../../shared/cubit/auth_cubit/auth_cubit.dart';
import '../../shared/cubit/auth_cubit/auth_states.dart';
import '../../shared/style/colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  final isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            sharedPreferences.setString('isLogin', '${state.model.uId}');
            return navigateToAndReplace(
              context,
              const HomeScreen(),
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
                  image: AssetImage('assets/Images/loginpage.png'),
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
                                'LOGIN',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              const SizedBox(height: 15.0),
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
                                borderRadius: 5.0,
                                autoFocus: true,
                                textInputType: TextInputType.emailAddress,
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
                                  borderRadius: 5.0,
                                  textInputType: TextInputType.visiblePassword,
                                  isPassword: cubit.isPassword,
                                  suffix: cubit.suffix,
                                  suffixOnTap: () {
                                    cubit.changePasswordVisibility();
                                  },
                                  onSubmit: (value) {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userLogin(
                                        context,
                                        email: email.text,
                                        password: password.text,
                                      );
                                    }
                                  }),
                              const SizedBox(
                                height: 10.0,
                              ),
                              state is! LoginLoadingState
                                  ? InkWell(
                                      onTap: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.userLogin(
                                            context,
                                            email: email.text,
                                            password: password.text,
                                          );
                                        }
                                      },
                                      child: Center(
                                        child: Container(
                                          height: 40.0,
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
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
                                            'Login',
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
                                  : Center(child: circularProgressIndicator()),
                              const SizedBox(height: 10.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "If You Don't have an Account ",
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  Center(
                                    child: TextButton(
                                      onPressed: () {
                                        return navigateTo(
                                          context,
                                          RegisterScreen(),
                                        );
                                      },
                                      child: Text(
                                        'Register Now!',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: iconColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
