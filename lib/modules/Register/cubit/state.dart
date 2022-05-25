import 'package:untitled2/model/RegisterModel.dart';

// ignore: unused_import
import 'package:untitled2/model/User_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final RegisterModel registerModel;

  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends RegisterStates {
  Map<String, dynamic> error;

  RegisterErrorState(this.error);
}
