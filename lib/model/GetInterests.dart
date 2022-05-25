class Getinterest {
  List<Result>? result;
 late String errors;
  late bool isSuccess;
  late String messageCode;

  Getinterest({required this.result, required this.errors, required this.isSuccess, required this.messageCode});

  Getinterest.fromJson(Map<String, dynamic> json) {
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
  late String id;
  late bool isDeleted;

  Result({required this.id, required this.isDeleted});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    isDeleted = json['isDeleted']??"";
  }


}