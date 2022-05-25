// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/modules/Register/cubit/state.dart';
import 'package:untitled2/network/CacheHelper.dart';
import 'package:untitled2/network/DioHelper.dart';
import 'package:untitled2/network/end_pionts.dart';

import '../../../model/RegisterModel.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  late RegisterModel registerModel;

  void userregister({
    required String date,
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());

    DioHelper.postData(
      url: REGISTER,
      data: {
        'email': email,
        'name': name,
        'phonenumber': phone,
        'brithDate': date,
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

        emit(RegisterSuccessState(registerModel));
      }
    }).catchError((e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
      print(Map<String, dynamic>.from(e.response?.data));

      emit(RegisterErrorState(Map<String, dynamic>.from(e.response?.data)));
    });
  }
}
