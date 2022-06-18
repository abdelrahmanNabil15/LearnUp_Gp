class UserRoomsReports {
  Result? result;
  String? errors;
  bool? isSuccess;
  String? messageCode;

  UserRoomsReports({this.result, this.errors, this.isSuccess, this.messageCode});

  UserRoomsReports.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    errors = json['errors'];
    isSuccess = json['isSuccess'];
    messageCode = json['messageCode'];
  }

}

class Result {
 late String userId;
 late String userName;
 late int totalRequestedRooms;
 late int numberOfRequestedRooms;
 late  int numberOfJoinedRooms;
 late  int numberOfRejectedRooms;
 late  int numberOfLeftRooms;
  List<RequestedRooms>? requestedRooms;
  List<JoinedRooms>? joinedRooms;
  List<RejectedRooms>? rejectedRooms;
  List<LeftRooms>? leftRooms;

  Result(
      {required this.userId,
        required this.userName,
        required this.totalRequestedRooms,
        required this.numberOfRequestedRooms,
        required this.numberOfJoinedRooms,
        required this.numberOfRejectedRooms,
        required this.numberOfLeftRooms,
        this.requestedRooms,
        this.joinedRooms,
        this.rejectedRooms,
        this.leftRooms});

  Result.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    totalRequestedRooms = json['totalRequestedRooms'];
    numberOfRequestedRooms = json['numberOfRequestedRooms'];
    numberOfJoinedRooms = json['numberOfJoinedRooms'];
    numberOfRejectedRooms = json['numberOfRejectedRooms'];
    numberOfLeftRooms = json['numberOfLeftRooms'];
    if (json['requestedRooms'] != null) {
      requestedRooms = <RequestedRooms>[];
      json['requestedRooms'].forEach((v) {
        requestedRooms!.add( RequestedRooms.fromJson(v));
      });
    }
    if (json['joinedRooms'] != null) {
      joinedRooms = <JoinedRooms>[];
      json['joinedRooms'].forEach((v) {
        joinedRooms!.add( JoinedRooms.fromJson(v));
      });
    }
    if (json['rejectedRooms'] != null) {
      rejectedRooms = <RejectedRooms>[];
      json['rejectedRooms'].forEach((v) {
        rejectedRooms!.add(RejectedRooms.fromJson(v));
      });
    }
    if (json['leftRooms'] != null) {
      leftRooms = <LeftRooms>[];
      json['leftRooms'].forEach((v) {
        leftRooms!.add(LeftRooms.fromJson(v));
      });
    }
  }


}
class RequestedRooms {
  late int id;
  late String ownerId;
  late  String ownerName;
  late  String requestDate;
  late  String finalDate;
  late  String statusId;
  late String roomName;

  RequestedRooms(
      {required this.id,
        required this.ownerId,
        required this.ownerName,
        required this.requestDate,
        required this.finalDate,
        required this.statusId,
        required this.roomName});

  RequestedRooms.fromJson(Map<String, dynamic> json) {
    id = json['id']??'';
    ownerId = json['ownerId']??'';
    ownerName = json['ownerName']??"";
    requestDate = json['requestDate']??"";
    finalDate = json['finalDate']??"";
    statusId = json['statusId']??"";
    roomName = json['roomName']??"";
  }

}
class JoinedRooms {
  late int id;
 late String ownerId;
  late  String ownerName;
  late  String requestDate;
  late  String finalDate;
  late  String statusId;
  late String roomName;

  JoinedRooms(
      {required this.id,
        required this.ownerId,
        required this.ownerName,
        required this.requestDate,
        required this.finalDate,
        required this.statusId,
        required this.roomName});

  JoinedRooms.fromJson(Map<String, dynamic> json) {
    id = json['id']??'';
    ownerId = json['ownerId']??'';
    ownerName = json['ownerName']??"";
    requestDate = json['requestDate']??"";
    finalDate = json['finalDate']??"";
    statusId = json['statusId']??"";
    roomName = json['roomName']??"";
  }

}
class RejectedRooms {
  late int id;
  late String ownerId;
  late  String ownerName;
  late  String requestDate;
  late  String finalDate;
  late  String statusId;
  late String roomName;

  RejectedRooms(
      {required this.id,
        required this.ownerId,
        required this.ownerName,
        required this.requestDate,
        required this.finalDate,
        required this.statusId,
        required this.roomName});

  RejectedRooms.fromJson(Map<String, dynamic> json) {
    id = json['id']??'';
    ownerId = json['ownerId']??'';
    ownerName = json['ownerName']??"";
    requestDate = json['requestDate']??"";
    finalDate = json['finalDate']??"";
    statusId = json['statusId']??"";
    roomName = json['roomName']??"";
  }

}
class LeftRooms {
  late int id;
  late String ownerId;
  late  String ownerName;
  late  String requestDate;
  late  String finalDate;
  late  String statusId;
  late String roomName;

  LeftRooms(
      {required this.id,
        required this.ownerId,
        required this.ownerName,
        required this.requestDate,
        required this.finalDate,
        required this.statusId,
        required this.roomName});

  LeftRooms.fromJson(Map<String, dynamic> json) {
    id = json['id']??'';
    ownerId = json['ownerId']??'';
    ownerName = json['ownerName']??"";
    requestDate = json['requestDate']??"";
    finalDate = json['finalDate']??"";
    statusId = json['statusId']??"";
    roomName = json['roomName']??"";
  }

}