import 'QuestionModel.dart';

class AnswerModel {
   Question? Questions;
  String? errors;
  bool? isSuccess;
  String? messageCode;

  AnswerModel({this.Questions,   this.errors,  this.isSuccess,  this.messageCode});

  AnswerModel.fromJson(Map<String, dynamic> json) {

    Questions=(json['result'] != null ?  Question.fromJson(json['result']) : null)!;

    errors = json['errors'];
    isSuccess = json['isSuccess'];
    messageCode = json['messageCode'];
  }


}