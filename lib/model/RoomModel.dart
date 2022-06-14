

class RoomModel {
  late int id;
  late String ownerId;
  late String ownerName;
  late String name;
  late String description;
  late String statusId;
  late int numberOfJoinedUsers;
  late int numberOfRejectedUsers;
  late int numberOfRequestedUsers;
  late Status status;
  late double price;

  late bool isPublic;
  late  String startDate;
  late String expectedEndDate;
  late String finishDate;
  List<Interests>? interests;
 late UserRoomStatus userRoomStatus;
  RoomModel(
      {required this.id,
      required this.numberOfJoinedUsers,
      required this.numberOfRequestedUsers,
      required this.numberOfRejectedUsers,
        required this.ownerId,
        required this.ownerName,
        required this.name,
        required this.description,
        required this.statusId,
       required this.status,
        required this.price,
        required this.isPublic,
        required this.startDate,
        required this.expectedEndDate,
            required this.finishDate,
        this.interests});

  RoomModel.fromJson( dynamic json) {
    id = json['id']??"";
    numberOfJoinedUsers = json['numberOfJoinedUsers']??"";
    numberOfRequestedUsers = json['numberOfRequestedUsers']??"";
    numberOfRejectedUsers = json['numberOfRejectedUsers']??"";
    ownerId = json['ownerId']??"";
    ownerName = json['ownerName']??"";
    name = json['name']??"";
    description = json['description']??"";
    statusId = json['statusId']??"";
    status =
   (json['status'] != null ?  Status.fromJson(json['status']) : null)!;
    price = json['price']??0;
   isPublic = json['isPublic']??false;
    startDate = json['startDate']??"";
    expectedEndDate = json['expectedEndDate']??"";
    finishDate = json['finishDate']??"";
    userRoomStatus =(json['userRoomStatus'] != null ?  UserRoomStatus.fromJson(json['userRoomStatus']) : null)!;


    if (json['interests'] != null) {
      interests = <Interests>[];
      json['interests'].forEach((v) {
        interests!.add(Interests.fromJson(v));
      });
    }
  }


}

class Status {
  late String id;
  late String nameArabic;
  late String nameEnglish;
  late bool  isDeleted;


  Status({required this.id,required this.isDeleted, required this.nameArabic, required this.nameEnglish,});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    nameArabic = json['nameArabic']??"";
    nameEnglish = json['nameEnglish']??"";
    isDeleted=json['isDeleted']??"";

  }


}

class UserRoomStatus {
  late String id;
  late String nameArabic;
  late String nameEnglish;



  UserRoomStatus({required this.id , required this.nameArabic, required this.nameEnglish,});

  UserRoomStatus.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    nameArabic = json['nameArabic']??"";
    nameEnglish = json['nameEnglish']??"";


  }


}





class Interests {
  late String id;
  late bool isDeleted;

  Interests({required this.id, required this.isDeleted});

  Interests.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    isDeleted = json['isDeleted']??"";
  }


}