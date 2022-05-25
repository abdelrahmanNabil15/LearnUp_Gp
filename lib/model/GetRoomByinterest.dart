import 'RoomModel.dart';

class RoombyInterest {
  List<RoomModel>? result;
late String errors;
  late bool isSuccess;
  late String messageCode;

  RoombyInterest({this.result, required this.errors, required this.isSuccess, required this.messageCode});

  RoombyInterest.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <RoomModel>[];
      json['result'].forEach((v) {
        result!.add(RoomModel.fromJson(v));
      });
    }
    errors = json['errors']??"";
    isSuccess = json['isSuccess']??"";
    messageCode = json['messageCode']??"";
  }


}

