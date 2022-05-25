class RoombyId {
  Result? result;
  late String errors;
  late bool isSuccess;
  late String messageCode;

  RoombyId(
      {this.result,
      required this.errors,
      required this.isSuccess,
      required this.messageCode});

  RoombyId.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    errors = json['errors'] ?? "";
    isSuccess = json['isSuccess'] ?? "";
    messageCode = json['messageCode'] ?? "error";
  }
}

class Result {
  late int id;
  late String ownerId;
  late String ownerName;
  late String name;
  late String description;
  late String statusId;
  // late String status;
  late double price;
  late bool isPublic;
  late String startDate;
  late String expectedEndDate;
  late String finishDate;
  List<Interests>? interests;

  Result(
      {required this.id,
      required this.ownerId,
      required this.ownerName,
      required this.name,
      required this.description,
      required this.statusId,
      // required this.status,
      required this.price,
      required this.isPublic,
      required this.startDate,
      required this.expectedEndDate,
      required this.finishDate,
      this.interests});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    ownerId = json['ownerId'] ?? "";
    ownerName = json['ownerName'] ?? "";
    name = json['name'] ?? "";
    description = json['description'] ?? "";
    statusId = json['statusId'] ?? "";
    // status = json['status'] ?? "";
    price = json['price'] ?? "";
    isPublic = json['isPublic'] ?? "";
    startDate = json['startDate'] ?? "";
    expectedEndDate = json['expectedEndDate'] ?? "";
    finishDate = json['finishDate'] ?? "";
    if (json['interests'] != null) {
      interests = <Interests>[];
      json['interests'].forEach((v) {
        interests!.add(Interests.fromJson(v));
      });
    }
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
