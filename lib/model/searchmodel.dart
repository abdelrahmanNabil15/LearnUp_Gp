import 'RoomModel.dart';

class SearchModel {
  Result? result;
 late String errors;
  late bool isSuccess;
  late String messageCode;

  SearchModel({this.result, required this.errors, required this.isSuccess, required this.messageCode});

  SearchModel.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    errors = json['errors']??"";
    isSuccess = json['isSuccess']??"";
    messageCode = json['messageCode']??"";
  }

}

class Result {
  late int roomsNumber;
  late int usersNumber;
  late int interestsNumber;
  List<RoomModel>? rooms;
  List<Users>? users;
  List<Interests>? interests;

  Result(
      {required this.roomsNumber,
        required this.usersNumber,
        required this.interestsNumber,
        this.rooms,
        this.users,
        this.interests});

  Result.fromJson(Map<String, dynamic> json) {
    roomsNumber = json['roomsNumber'];
    usersNumber = json['usersNumber'];
    interestsNumber = json['interestsNumber'];
    if (json['rooms'] != null) {
      rooms = <RoomModel>[];
      json['rooms'].forEach((v) {
        rooms!.add(RoomModel.fromJson(v));
      });
    }
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
    if (json['interests'] != null) {
      interests = <Interests>[];
      json['interests'].forEach((v) {
        interests!.add(new Interests.fromJson(v));
      });
    }
  }

}







class Users {
  late String id;
  late String name;
  late String statusId;
  late String birthdate;
  late String createdAt;
  late bool isDeleted;
  late String userName;
  late String phoneNumber;
  UserRoomStatus? status;
  late String interests;
  late String joinedRooms;
  late String requestedRooms;
  late  String createdRooms;

  Users(
      {required this.id,
        required this.name,
        required this.statusId,
        required this.birthdate,
        required this.createdAt,
        required this.isDeleted,
        required this.userName,
        required this.phoneNumber,
        this.status,
        required this.interests,
        required this.joinedRooms,
        required this.requestedRooms,
        required this.createdRooms});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    name = json['name']??"";
    statusId = json['statusId']??"";
    birthdate = json['birthdate']??"";
    createdAt = json['createdAt']??"";
    isDeleted = json['isDeleted']??"";
    userName = json['userName']??"";
    phoneNumber = json['phoneNumber']??"";
    status = json['status'] != null
        ?   UserRoomStatus.fromJson(json['status'])
        : null;
    interests = json['interests']??"";
    joinedRooms = json['joinedRooms']??"";
    requestedRooms = json['requestedRooms']??"";
    createdRooms = json['createdRooms']??"";
  }

}


