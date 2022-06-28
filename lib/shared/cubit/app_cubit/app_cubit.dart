import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/shared/cubit/app_cubit/app_states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppInit());

  static AppCubit get(context) => BlocProvider.of(context);

}