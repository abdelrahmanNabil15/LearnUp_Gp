class UserCreatedRoomsModel {
  Result? result;
  String? errors;
  bool? isSuccess;
  String? messageCode;

  UserCreatedRoomsModel(
      {this.result, this.errors, this.isSuccess, this.messageCode});

  UserCreatedRoomsModel.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    errors = json['errors'];
    isSuccess = json['isSuccess'];
    messageCode = json['messageCode'];
  }


}

class Result {
  String? userId;
  int? numberOfRooms;
  List<RoomActivities>? roomActivities;

  Result({this.userId, this.numberOfRooms, this.roomActivities});

  Result.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    numberOfRooms = json['numberOfRooms'];
    if (json['roomActivities'] != null) {
      roomActivities = <RoomActivities>[];
      json['roomActivities'].forEach((v) {
        roomActivities!.add(new RoomActivities.fromJson(v));
      });
    }
  }


}

class RoomActivities {
  late int roomId;
  late String roomName;
  late String description;
  late String statusId;
  late double price;
  late bool isPublic;
  late String startDate;
  late String expectedEndDate;
  late String finishDate;
  late int numberOfJoinedUsers;
  late int numberOfRequestedUsers;
  late int numberOfRejectedUsers;
  late int numberOfLeftUsers;
  late int addedMaterials;
 late int roomMeetings;
  List<RejectedUserRoomActivities>? rejectedUserRoomActivities;
  List<JoinedUserRoomActivities>? joinedUserRoomActivities;
  List<RequestedUserRoomActivities>? requestedUserRoomActivities;
  List<LeftUserRoomActivities>? leftUserRoomActivities;
  List<RoomMeetingActivities>? roomMeetingActivities;
  List<RoomMaterialsActivities>? roomMaterialsActivities;

  RoomActivities(
      {required this.roomId,
        required this.roomName,
        required this.description,
        required this.statusId,
        required this.price,
        required this.isPublic,
        required this.startDate,
        required this.expectedEndDate,
        required this.finishDate,
        required this.numberOfJoinedUsers,
        required this.numberOfRequestedUsers,
        required this.numberOfRejectedUsers,
        required this.numberOfLeftUsers,
        required this.addedMaterials,
        required this.roomMeetings,
        this.rejectedUserRoomActivities,
        this.joinedUserRoomActivities,
        this.requestedUserRoomActivities,
        this.leftUserRoomActivities,
        this.roomMeetingActivities,
        this.roomMaterialsActivities});

  RoomActivities.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId']??"";
    roomName = json['roomName']??"";
    description = json['description']??"";
    statusId = json['statusId']??"";
    price = json['price']??'';
    isPublic = json['isPublic']??'';
    startDate = json['startDate']??'';
    expectedEndDate = json['expectedEndDate']??"";
    finishDate = json['finishDate']??"";
    numberOfJoinedUsers = json['numberOfJoinedUsers']??"";
    numberOfRequestedUsers = json['numberOfRequestedUsers']??"";
    numberOfRejectedUsers = json['numberOfRejectedUsers']??"";
    numberOfLeftUsers = json['numberOfLeftUsers']??"";
    addedMaterials = json['addedMaterials']??"";
    roomMeetings = json['roomMeetings']??"";
    if (json['rejectedUserRoomActivities'] != null) {
      rejectedUserRoomActivities = <RejectedUserRoomActivities>[];
      json['rejectedUserRoomActivities'].forEach((v) {
        rejectedUserRoomActivities!.add( RejectedUserRoomActivities.fromJson(v));
      });
    }
    if (json['joinedUserRoomActivities'] != null) {
      joinedUserRoomActivities = <JoinedUserRoomActivities>[];
      json['joinedUserRoomActivities'].forEach((v) {
        joinedUserRoomActivities!.add( JoinedUserRoomActivities.fromJson(v));
      });
    }
    if (json['requestedUserRoomActivities'] != null) {
      requestedUserRoomActivities = <RequestedUserRoomActivities>[];
      json['requestedUserRoomActivities'].forEach((v) {
        requestedUserRoomActivities!.add(RequestedUserRoomActivities.fromJson(v));
      });
    }
    if (json['leftUserRoomActivities'] != null) {
      leftUserRoomActivities = <LeftUserRoomActivities>[];
      json['leftUserRoomActivities'].forEach((v) {
        leftUserRoomActivities!.add(LeftUserRoomActivities.fromJson(v));
      });
    }
    if (json['roomMeetingActivities'] != null) {
      roomMeetingActivities = <RoomMeetingActivities>[];
      json['roomMeetingActivities'].forEach((v) {
        roomMeetingActivities!.add(RoomMeetingActivities.fromJson(v));
      });
    }
    if (json['roomMaterialsActivities'] != null) {
      roomMaterialsActivities = <RoomMaterialsActivities>[];
      json['roomMaterialsActivities'].forEach((v) {
        roomMaterialsActivities!.add(  RoomMaterialsActivities.fromJson(v));
      });
    }
  }


}

class RejectedUserRoomActivities {
  late int id;
  late  String userId;
  late String statusId;
  late String userName;
  late String createdAt;
  List<UserRoomHistories>? userRoomHistories;

  RejectedUserRoomActivities(
      {required this.id,
        required this.userId,
        required this.statusId,
        required this.userName,
        required this.createdAt,
        this.userRoomHistories});

  RejectedUserRoomActivities.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    userId = json['userId']??"";
    statusId = json['statusId']??"";
    userName = json['userName']??"";
    createdAt = json['createdAt']??"";
    if (json['userRoomHistories'] != null) {
      userRoomHistories = <UserRoomHistories>[];
      json['userRoomHistories'].forEach((v) {
        userRoomHistories!.add( UserRoomHistories.fromJson(v));
      });
    }
  }


}
class JoinedUserRoomActivities {
  late int id;
  late String userId;
  late String statusId;
  late  String userName;
  late String createdAt;
  List<UserRoomHistories>? userRoomHistories;

  JoinedUserRoomActivities(
      {required this.id,
        required this.userId,
        required this.statusId,
        required this.userName,
        required this.createdAt,
        this.userRoomHistories});

  JoinedUserRoomActivities.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    userId = json['userId']??"";
    statusId = json['statusId']??"";
    userName = json['userName']??"";
    createdAt = json['createdAt']??"";
    if (json['userRoomHistories'] != null) {
      userRoomHistories = <UserRoomHistories>[];
      json['userRoomHistories'].forEach((v) {
        userRoomHistories!.add( UserRoomHistories.fromJson(v));
      });
    }
  }


}
class RoomMeetingActivities {
  late int id;
  late String userId;
  late String statusId;
  late  String userName;
  late String createdAt;
  List<UserRoomHistories>? userRoomHistories;

  RoomMeetingActivities(
      {required this.id,
        required this.userId,
        required this.statusId,
        required this.userName,
        required this.createdAt,
        this.userRoomHistories});

  RoomMeetingActivities.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    userId = json['userId']??"";
    statusId = json['statusId']??"";
    userName = json['userName']??"";
    createdAt = json['createdAt']??"";
    if (json['userRoomHistories'] != null) {
      userRoomHistories = <UserRoomHistories>[];
      json['userRoomHistories'].forEach((v) {
        userRoomHistories!.add( UserRoomHistories.fromJson(v));
      });
    }
  }


}

class RequestedUserRoomActivities {
 late int id;
 late String userId;
 late String statusId;
 late String userName;
 late  String createdAt;
  List<UserRoomHistories>? userRoomHistories;

  RequestedUserRoomActivities(
      {required this.id,
        required this.userId,
        required this.statusId,
        required this.userName,
        required this.createdAt,
        this.userRoomHistories});

  RequestedUserRoomActivities.fromJson(Map<String, dynamic> json) {
    id = json['id']??'';
    userId = json['userId']??"";
    statusId = json['statusId']??"";
    userName = json['userName']??"";
    createdAt = json['createdAt']??"";
    if (json['userRoomHistories'] != null) {
      userRoomHistories = <UserRoomHistories>[];
      json['userRoomHistories'].forEach((v) {
        userRoomHistories!.add( UserRoomHistories.fromJson(v));
      });
    }
  }


}
class LeftUserRoomActivities {
  late int id;
  late String userId;
  late String statusId;
  late String userName;
  late String createdAt;
  List<UserRoomHistories>? userRoomHistories;

  LeftUserRoomActivities(
      {required this.id,
        required this.userId,
        required this.statusId,
        required this.userName,
        required this.createdAt,
        this.userRoomHistories});

  LeftUserRoomActivities.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    userId = json['userId']??"";
    statusId = json['statusId']??'';
    userName = json['userName']??'';
    createdAt = json['createdAt']??"";
    if (json['userRoomHistories'] != null) {
      userRoomHistories = <UserRoomHistories>[];
      json['userRoomHistories'].forEach((v) {
        userRoomHistories!.add(UserRoomHistories.fromJson(v));
      });
    }
  }


}

class UserRoomHistories {
late  int userRoomActivityId;
late  String userId;
late  String statusId;
late  int roomId;
late  String comment;
late  String rejectionReason;
late  String suspensionReason;
late  String leaveReason;
late  String userName;
late  String createdAt;

  UserRoomHistories(
      {required this.userRoomActivityId,
        required this.userId,
        required this.statusId,
        required this.roomId,
        required this.comment,
        required this.rejectionReason,
        required this.suspensionReason,
        required this.leaveReason,
        required this.userName,
        required this.createdAt});

  UserRoomHistories.fromJson(Map<String, dynamic> json) {
    userRoomActivityId = json['userRoomActivityId']??"";
    userId = json['userId']??"";
    statusId = json['statusId']??"";
    roomId = json['roomId']??"";
    comment = json['comment']??"";
    rejectionReason = json['rejectionReason']??"";
    suspensionReason = json['suspensionReason']??"";
    leaveReason = json['leaveReason']??"";
    userName = json['userName']??"";
    createdAt = json['createdAt']??"";
  }


}

class RoomMaterialsActivities {
  late int materialId;
  late String materialName;
  late String createdAt;

  RoomMaterialsActivities({required this.materialId, required this.materialName, required this.createdAt});

  RoomMaterialsActivities.fromJson(Map<String, dynamic> json) {
    materialId = json['materialId']??"";
    materialName = json['materialName']??"";
    createdAt = json['createdAt']??"";
  }


}
