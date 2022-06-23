// ignore_for_file: file_names

class Usermodel {
  late Result? result;
  List<Errors>? errors;
  late bool isSuccess;
  late String messageCode;

  Usermodel(
      {this.result,
      this.errors,
      required this.isSuccess,
      required this.messageCode});

  Usermodel.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(Errors.fromJson(v));
      });
    }
    isSuccess = json['isSuccess'];
    messageCode = json['messageCode'];
  }


}

class Result {
  late String id;
  late String name;
  late String statusId;
  late String birthdate;
  late String createdAt;
  late bool isDeleted;
  late String userName;
  late String requestedRooms;
  late String phoneNumber;
  Status?   status;
  List<Interests>? interests;
  List<CreatedRooms>? createdRooms;

  List<JoinedRoomss>? joinRooms;

  Result({
    required this.id,
    required this.name,
    required this.requestedRooms,
    required this.statusId,
    required this.birthdate,
    required this.createdAt,
    required this.isDeleted,
    required this.userName,
    required this.phoneNumber,
    required this.status,
    required this.interests,
    this.createdRooms,
    this.joinRooms

  });

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
    statusId = json['statusId'] ?? "";
    birthdate = json['birthdate'] ?? "";
    createdAt = json['createdAt'] ?? "";
    isDeleted = json['isDeleted'] ?? "";
    userName = json['userName'] ?? "";
    phoneNumber = json['phoneNumber'] ?? "";
    requestedRooms = json['requestedRooms'] ?? "";

  status = (json['status'] != null ? Status.fromJson(json['status']) : null)!;
    if (json['interests'] != null) {
      interests = <Interests>[];
      json['interests'].forEach((v) {
        interests!.add(Interests.fromJson(v));
      });
    }else{ interests=null;}

    if (json['createdRooms'] != null) {
      createdRooms = <CreatedRooms>[];
      json['createdRooms'].forEach((v) {
        createdRooms!.add(CreatedRooms.fromJson(v));
      });
    }else{
      createdRooms= null;
    }
    if (json['joinedRooms'] != null) {
      joinRooms = <JoinedRoomss>[];
      json['joinedRooms'].forEach((v) {
        joinRooms!.add(JoinedRoomss.fromJson(v));
      });
    }else{
      joinRooms= null;
    }
  }
}



class JoinedRoomss {


  late  int id;
  late String ownerId;
  late String ownerName;
  late int numberOfJoinedUsers;
  late int numberOfRejectedUsers;
  late int numberOfRequestedUsers;
  late String name;
  late String description;
  late  String statusId;
  late String status;
  late Status userRoomStatus;
  late double price;
  late bool isPublic;
  late String startDate;
  late String expectedEndDate;
  late String finishDate;
  late String interests;


  JoinedRoomss(
      {required this.id,
        required this.ownerId,
        required this.ownerName,
        required this.name,
        required this.numberOfJoinedUsers,
        required this.numberOfRequestedUsers,
        required this.numberOfRejectedUsers,
        required this.description,
        required this.statusId,
        required this.status,
        required this.userRoomStatus,
        required this.price,
        required this.isPublic,
        required this.startDate,
        required this.expectedEndDate,
        required this.finishDate,
        required this.interests,
      });

  JoinedRoomss.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    ownerId = json['ownerId']??"";
    ownerName = json['ownerName']??"";
    name = json['name']??"";
    numberOfJoinedUsers = json['numberOfJoinedUsers']??"";
    numberOfRequestedUsers = json['numberOfRequestedUsers']??"";
    numberOfRejectedUsers = json['numberOfRejectedUsers']??"";
    description = json['description']??"";
    statusId = json['statusId']??"";
    status = json['status']??"";
    userRoomStatus = (json['userRoomStatus'] != null
        ? Status.fromJson(json['userRoomStatus'])
        : null)!;
    price = json['price']??"";
    isPublic = json['isPublic']??"";
    startDate = json['startDate']??"";
    expectedEndDate = json['expectedEndDate']??"";
    finishDate = json['finishDate']??"";
    interests = json['interests']??"";
  }





}

class Status {
  late String id;
  late String nameArabic;
  late String nameEnglish;

  Status(
      {required this.id, required this.nameArabic, required this.nameEnglish});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    nameArabic = json['nameArabic'] ?? "";
    nameEnglish = json['nameEnglish'] ?? "";
  }
}

class Errors {
  late String fieldName;
  late String message;
  late String code;

  Errors({required this.fieldName, required this.message, required this.code});

  Errors.fromJson(Map<String, dynamic> json) {
    fieldName = json['fieldName'] ?? "";
    message = json['message'] ?? "";
    code = json['code'] ?? "";
  }
}

class Interests {
  late String id;
  late bool isDeleted;

  Interests({required this.id, required this.isDeleted});

  Interests.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    isDeleted = json['isDeleted'] ?? "";
  }
}

class CreatedRooms {
  late  int id;
  late String ownerId;
  late String ownerName;
  late int numberOfJoinedUsers;
  late int numberOfRejectedUsers;
  late int numberOfRequestedUsers;
  late String name;
  late String description;
  late  String statusId;
  late String status;
  late Status userRoomStatus;
  late double price;
  late bool isPublic;
  late String startDate;
  late String expectedEndDate;
  late String finishDate;
  late String interests;


  CreatedRooms(
      {required this.id,
        required this.ownerId,
        required this.ownerName,
        required this.name,
        required this.numberOfJoinedUsers,
        required this.numberOfRequestedUsers,
        required this.numberOfRejectedUsers,
        required this.description,
        required this.statusId,
        required this.status,
        required this.userRoomStatus,
        required this.price,
        required this.isPublic,
        required this.startDate,
        required this.expectedEndDate,
        required this.finishDate,
        required this.interests,
     });

  CreatedRooms.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    ownerId = json['ownerId']??"";
    numberOfJoinedUsers = json['numberOfJoinedUsers']??"";
    numberOfRequestedUsers = json['numberOfRequestedUsers']??"";
    numberOfRejectedUsers = json['numberOfRejectedUsers']??"";
    ownerName = json['ownerName']??"";
    name = json['name']??"";
    description = json['description']??"";
    statusId = json['statusId']??"";
    status = json['status']??"";
    userRoomStatus = (json['userRoomStatus'] != null
        ? Status.fromJson(json['userRoomStatus'])
        : null)!;
    price = json['price']??"";
    isPublic = json['isPublic']??"";
    startDate = json['startDate']??"";
    expectedEndDate = json['expectedEndDate']??"";
    finishDate = json['finishDate']??"";
    interests = json['interests']??"";
  }


}