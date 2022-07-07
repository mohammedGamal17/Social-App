import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/shared/cubit/auth_cubit/auth_cubit.dart';

import '../../shared/cubit/auth_cubit/auth_states.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: const SingleChildScrollView(
              child: Center(
                child: Text('RegisterScreen'),
              ),
            ),
          );
        },
      ),
    );
  }
}
