import '../../../model/RegisterModel.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final RegisterModel registerModel;

  LoginSuccessState(this.registerModel);
}

class LoginErrorState extends LoginStates {}