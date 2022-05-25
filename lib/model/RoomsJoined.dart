import 'RoomModel.dart';

class RoombyId {
  RoomModel? result;
  late String errors;
  late bool isSuccess;
  late String messageCode;

  RoombyId({this.result, required this.errors, required this.isSuccess, required this.messageCode});

  RoombyId.fromJson(Map<String, dynamic> json) {
    result=(json['result'] != null ?  RoomModel.fromJson(json['result']) : null)!;
    errors = json['errors']??"";
    isSuccess = json['isSuccess']??"";
    messageCode = json['messageCode']??"";
  }


}