
class BaseModel{

  late List<String> errors;
  late bool isSuccess;
  late String messageCode;
  BaseModel.fromJson(Map<String, dynamic> json) {

    errors = json['errors']??"";
    isSuccess = json['isSuccess']??"";
    messageCode = json['messageCode']??"";
  }
}