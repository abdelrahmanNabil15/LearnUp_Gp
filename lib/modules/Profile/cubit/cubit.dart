// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/modules/Profile/cubit/state.dart';
import 'package:untitled2/modules/login/Loginscreen.dart';
import 'package:untitled2/network/CacheHelper.dart';

import '../../../model/GetInterests.dart';
import '../../../model/User_model.dart';
import '../../../network/DioHelper.dart';
import '../../../network/end_pionts.dart';
/*
class UserDataCubit extends Cubit<UserDataStates> {
  UserDataCubit() : super(UserDataInitialState());
  Usermodel? usermodel;
  Getinterest? getinterest;
  dynamic token = CacheHelper.getData(key: 'result');
dynamic interest=[];
  static UserDataCubit get(context) => BlocProvider.of(context);

  void GetUserdata() {
    emit(UserDataLoadingState());
    DioHelper.getData(url: User, token: token).then((value) {
      usermodel = Usermodel.fromJson(value.data);

      emit(UserDataSuccessState(usermodel!));
    }).catchError((error) {
      if (error ) {
        print(token);
        print('Dio error!');


        print(token);
        emit(UserDataErrorState());
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(error.message);

        emit(UserDataErrorState());
      }
    });
  }
  void GetInterest(){
    emit(GetInterestsLoadingState());
    DioHelper.getData(url: Interest, token: token).then((value) {
      getinterest =   Getinterest.fromJson(value.data);
      print(getinterest?.messageCode);
      print(getinterest?.result![4].id);
      if (kDebugMode) {
        print(token);
      }
      emit(GetInterestsSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(getinterest?.errors);
      }
      if (kDebugMode) {
        print('Error sending request!');
      }
      if (kDebugMode) {
        print(error);
      }

      if (kDebugMode) {
        print(token);
      }
      emit(GetInterestsErrorState());
      {
        // Error due to setting up or sending the request
        if (kDebugMode) {
          print('Error sending request!');
        }
        if (kDebugMode) {
          print(error.message);
        }

        emit(GetInterestsErrorState());
      }
    });
  }

  void Addintrest({required String interestdata}) {

    emit(InterestsLoadingState());
    DioHelper.postData(url: Interest, token: token, data: {
      "interest": interestdata,
      "ignoreSimilarity": true

    },).then((value) {


      if (kDebugMode) {
        print(value.data);
      }
      emit(InterestsSuccessState());
    }).catchError((error) {
      if (error.response != null) {
        if (kDebugMode) {
          print(token);
        }
        if (kDebugMode) {
          print('Dio error!');
        }
        if (kDebugMode) {
          print('STATUS: ${error.response?.statusCode}');
        }
        if (kDebugMode) {
          print('DATA: ${error.response?.data}');
        }
        if (kDebugMode) {
          print('HEADERS: ${error.response?.headers}');
        }
        if (kDebugMode) {
          print(token);
        }
        emit(InterestsErrorState());
      } else {
        // Error due to setting up or sending the request
        if (kDebugMode) {
          print('Error sending request!');
        }
        if (kDebugMode) {
          print(error.message);
        }

        emit(UserDataErrorState());
      }
    });
  }

  void SignOut(context) {
    CacheHelper.removeData(key: 'result').then((value) {
      if (value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    }
    );
  }

}*/