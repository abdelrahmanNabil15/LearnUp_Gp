// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/model/User_model.dart';
import 'package:untitled2/modules/login/cubit/state.dart';
import 'package:untitled2/network/CacheHelper.dart';
import 'package:untitled2/network/DioHelper.dart';
import 'package:untitled2/network/end_pionts.dart';

import '../../../model/RegisterModel.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  late Usermodel userModel;
  late RegisterModel registerModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data: {
        'username': email,
        'password': password,
      },
    ).then((value) {
      registerModel = RegisterModel.fromJson(value.data);

      if (registerModel.isSuccess == true) {
        print("Token::::::::::::::" + registerModel.result.toString());
        print(registerModel.messageCode);
        CacheHelper.putData(key: 'result', value: registerModel.result);
        dynamic token = CacheHelper.getData(key: 'result');
        print("result");
        print(token);
        emit(LoginSuccessState(registerModel));
      } else {
        print(registerModel.result);
        print(registerModel.messageCode);
        emit(LoginErrorState());
      }
    }).catchError((error) {
      emit(LoginErrorState());
      print(error.toString());
    });
  }
}
