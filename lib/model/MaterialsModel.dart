  class MaterialsModel {
  List<Materials>? result;
  late String errors;
 late bool? isSuccess;
 late String messageCode;

  MaterialsModel({this.result, required this.errors, this.isSuccess, required this.messageCode});

  MaterialsModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Materials>[];
      json['result'].forEach((v) {
        result!.add( Materials.fromJson(v));
      });
    }
    errors = json['errors'];
    isSuccess = json['isSuccess'];
    messageCode = json['messageCode'];
  }


}

class Materials {
 late int id;
 late int roomId;
 late String filePath;
 late String fileName;
 late bool isActive;

  Materials({required this.id, required this.roomId, required this.filePath, required this.fileName, required this.isActive});

  Materials.fromJson(Map<String, dynamic> json) {
    id = json['id']??="";
    roomId = json['roomId']??"";
    filePath = json['filePath']??"";
    fileName = json['fileName']??"";
    isActive = json['isActive']??"";
  }


}
