
import 'RegisterModel.dart';

class creaateRooms {
 late int result;
 List<Errors>? errors;
 late  bool isSuccess;
 late String messageCode;

  creaateRooms({required this.result,  this.errors, required this.isSuccess, required this.messageCode});

  creaateRooms.fromJson(Map<String, dynamic> json) {
    result = json['result']??'';
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(Errors.fromJson(v));
      });
    }
    isSuccess = json['isSuccess']??"";
    messageCode = json['messageCode']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['result'] = this.result;
    data['errors'] = this.errors;
    data['isSuccess'] = this.isSuccess;
    data['messageCode'] = this.messageCode;
    return data;
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
