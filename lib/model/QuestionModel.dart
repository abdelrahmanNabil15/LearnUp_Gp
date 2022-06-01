class QuestionModel {
  List<Question>? Questions;
  String? errors;
  bool? isSuccess;
  String? messageCode;

  QuestionModel({this.Questions,   this.errors,  this.isSuccess,  this.messageCode});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      Questions = <Question>[];
      json['result'].forEach((v) {
        Questions!.add( Question.fromJson(v));
      });
    }
    errors = json['errors'];
    isSuccess = json['isSuccess'];
    messageCode = json['messageCode'];
  }


}

class Question {
  int? roomId;
  String? questionTitle;
  int? id;
  String? questionDescription;
  bool? isAnswered;
  String? statusId;
  String? userId;
  String? userName;
  List<Answers>? answers;

  Question(
      {this.roomId,
        this.questionTitle,
        this.id,
        this.questionDescription,
        this.isAnswered,
        this.statusId,
        this.userId,
        this.userName,
        this.answers});

  Question.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId'];
    questionTitle = json['questionTitle'];
    id = json['id'];
    questionDescription = json['questionDescription'];
    isAnswered = json['isAnswered'];
    statusId = json['statusId'];
    userId = json['userId'];
    userName = json['userName'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(new Answers.fromJson(v));
      });
    }
  }


}

class Answers {
  String? answerDescription;
  int? answerId;
  int? questionId;
  bool? isAccepted;
  String? userId;
  String? userName;

  Answers(
      {this.answerDescription,
        this.answerId,
        this.questionId,
        this.isAccepted,
        this.userId,
        this.userName});

  Answers.fromJson(Map<String, dynamic> json) {
    answerDescription = json['answerDescription'];
    answerId = json['answerId'];
    questionId = json['questionId'];
    isAccepted = json['isAccepted'];
    userId = json['userId'];
    userName = json['userName'];
  }


}
