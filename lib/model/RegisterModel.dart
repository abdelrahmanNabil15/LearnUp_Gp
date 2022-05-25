// ignore_for_file: file_names

class RegisterModel {
  late String result;
  List<Errors>? errors;
  late bool isSuccess;
  late String messageCode;

  RegisterModel(
      {required this.result,
      this.errors,
      required this.isSuccess,
      required this.messageCode});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
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
