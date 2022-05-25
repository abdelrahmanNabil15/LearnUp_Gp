// ignore_for_file: camel_case_types

import 'package:untitled2/modules/Rooms/CreateRoom.dart';

import '../model/CreateRoom.dart';
import '../model/RoomsJoined.dart';
import '../model/User_model.dart';
import '../modules/Profile/cubit/state.dart';

abstract class learnUpStates {}

class learnUpInitStates extends learnUpStates {}

class learnUpBottomNavInitStates extends learnUpStates {}

class learnUploadingsStates extends learnUpStates {}

class learnUpsuccessStates extends learnUpStates {}

class RoomsInitStates extends learnUpStates {}

class RoomsloadingsStates extends learnUpStates {}

class RoomsSuccessStates extends learnUpStates {}

class RoomsErrorStates extends learnUpStates {
  late RoombyId roombyId;

  RoomsErrorStates(this.roombyId);
}

class learnUpErrorStates extends learnUpStates {
  late final String error;

  learnUpErrorStates(this.error);
}
class UserDataInitialState extends learnUpStates {}

class UserDataLoadingState extends learnUpStates {}

class UserDataSuccessState extends learnUpStates {
  final Usermodel usermodel;
  UserDataSuccessState(this.usermodel);
}

class UserDataErrorState extends learnUpStates {}
class InterestsLoadingState extends learnUpStates {}

class InterestsSuccessState extends learnUpStates {

}

class InterestsErrorState extends learnUpStates {}
class GetInterestsLoadingState extends learnUpStates {}

class GetInterestsSuccessState extends learnUpStates {

}

class GetInterestsErrorState extends learnUpStates{}
class GetAllInterestsLoadingState extends learnUpStates {}

class GetAllInterestsSuccessState extends learnUpStates {

}

class GetAllInterestsErrorState extends learnUpStates{}

class CreateRoomLoadingState extends learnUpStates {}

class CreateRoomSuccessState extends learnUpStates {
  late creaateRooms room;

  CreateRoomSuccessState(this.room);
}

class  CreateRoomErrorState extends learnUpStates {}

class GetRoomByInterestLoadingState extends learnUpStates {}

class GetRoomByInterestSuccessState extends learnUpStates {
}
class GetRoomByInterestErrorState extends learnUpStates{}
class JoinRoomLoadingState extends learnUpStates {}

class JoinRoomSuccessState extends learnUpStates {
}
class JoinRoomErrorState extends learnUpStates{}

class RequestedUsersLoadingState extends learnUpStates {}

class RequestedUsersSuccessState extends learnUpStates {
}
class RequestedUsersErrorState extends learnUpStates{}

class AcceptUserLoadingState extends learnUpStates {}

class AcceptUserSuccessState extends learnUpStates {
}
class AcceptUserErrorState extends learnUpStates{}

class RejectUserLoadingState extends learnUpStates {}

class RejectUserSuccessState extends learnUpStates {
}
class RejectUserErrorState extends learnUpStates{}

