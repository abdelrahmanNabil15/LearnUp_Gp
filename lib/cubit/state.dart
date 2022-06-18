// ignore_for_file: camel_case_types


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

class InterestsErrorState extends learnUpStates {
  late final String error;

  InterestsErrorState(this.error);

}
class DeleteInterestLoadingState extends learnUpStates {}
class DeleteInterestSuccessState extends learnUpStates {

}

class DeleteInterestErrorState extends learnUpStates {}
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
class AddQuestionLoadingState extends learnUpStates {}

class AddQuestionSuccessState extends learnUpStates {
}
class AddQuestionErrorState extends learnUpStates{

  final dynamic error=[];
  AddQuestionErrorState(error);

}
class GetanswerLoadingState extends learnUpStates {}

class GetanswerSuccessState extends learnUpStates {
}
class GetanswerErrorState extends learnUpStates{}
class GetQuestionLoadingState extends learnUpStates {}

class GetQuestionSuccessState extends learnUpStates {
}
class GetQuestionErrorState extends learnUpStates{}
class UploadFilesLoadingState extends learnUpStates {}

class UploadFilesSuccessState extends learnUpStates {
}
class UploadFilesErrorState extends learnUpStates{}
class DeleteanswerLoadingState extends learnUpStates {}

class DeleteanswerSuccessState extends learnUpStates {
}
class DeleteanswerErrorState extends learnUpStates{}
class FilesPickedSuccessState extends learnUpStates{}
class UpdateanswerLoadingState extends learnUpStates {}
class UpdateanswerSuccessState extends learnUpStates {
}
class UpdateanswerErrorState extends learnUpStates{}
class AddanswerLoadingState extends learnUpStates {}

class AddanswerSuccessState extends learnUpStates {
}
class AddanswerErrorState extends learnUpStates{}


class GetMaterialsLoadingState extends learnUpStates {}

class GetMaterialsSuccessState extends learnUpStates {
}
class GetMaterialsErrorState extends learnUpStates{}
class GetCreatedRoomsReportsLoadingState extends learnUpStates {}

class GetCreatedRoomsReportsSuccessState extends learnUpStates {
}
class GetCreatedRoomsReportsErrorState extends learnUpStates{}

class GetRoomReportLoadingState extends learnUpStates {}

class GetRoomReportSuccessState extends learnUpStates {
}
class GetRoomReportErrorState extends learnUpStates{}

class SearchLoadingState extends learnUpStates {}

class SearchSuccessState extends learnUpStates {
}
class SearchErrorState extends learnUpStates{}
  class InvitesLoadingState extends learnUpStates {}

class InvitesSuccessState extends learnUpStates {
}
class InvitesErrorState extends learnUpStates{

  late final String error;

  InvitesErrorState(this.error);
}

class GetInvitesLoadingState extends learnUpStates {}

class GetInvitesSuccessState extends learnUpStates {
}
class GetInvitesErrorState extends learnUpStates{}

class AcceptInvitesLoadingState extends learnUpStates {}

class AcceptInvitesSuccessState extends learnUpStates {
}
class AcceptInvitesErrorState extends learnUpStates{
  late final String error;

  AcceptInvitesErrorState(this.error);

}

class RejectInvitesLoadingState extends learnUpStates {}

class RejectInvitesSuccessState extends learnUpStates {
}
class RejectInvitesErrorState extends learnUpStates{
  late final String error;

  RejectInvitesErrorState(this.error);

}

