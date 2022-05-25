class Requesteduserss {
  List<Result>? result;
  late  String errors;
  late bool  isSuccess;
  late String  messageCode;

  Requesteduserss({this.result, required this.errors, required this.isSuccess, required this.messageCode});

  Requesteduserss.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add( Result.fromJson(v));
      });
    }
    errors = json['errors']??"";
    isSuccess = json['isSuccess']??"";
    messageCode = json['messageCode']??"";
  }


}

class Result {
  late String  id;
  late String  name;
  late String  statusId;
  late String  birthdate;
  late String  createdAt;
  late bool    isDeleted;
  late String  userName;
  late String  phoneNumber;
  late String  status;
  late String  interests;
  late  String joinedRooms;
  late String  requestedRooms;
 late String   createdRooms;

  Result(
      {required this.id,
        required this.name,
        required this.statusId,
        required this.birthdate,
        required this.createdAt,
        required this.isDeleted,
         required this.userName,
        required this.phoneNumber,
         required this.status,
         required this.interests,
        required this.joinedRooms,
        required this.requestedRooms,
       required this.createdRooms
      });

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    name = json['name']??"";
    statusId = json['statusId']??"";
    birthdate = json['birthdate']??"";
    createdAt = json['createdAt']??"";
    isDeleted = json['isDeleted']??"";
   userName = json['userName']??"";
    phoneNumber = json['phoneNumber']??"";
   status = json['status']??"";
    interests = json['interests']??"";
    joinedRooms = json['joinedRooms']??"";
    requestedRooms = json['requestedRooms']??"";
    createdRooms = json['createdRooms']??"";
  }

}
