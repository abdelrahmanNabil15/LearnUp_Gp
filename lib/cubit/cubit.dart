// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_print, unrelated_type_equality_checks

import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart ';
import 'package:file_picker/file_picker.dart';
import 'package:LearnUP/cubit/state.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';

import '../model/AnswerModel.dart';
import '../model/CreateRoom.dart';
import '../model/GetInterests.dart';
import '../model/GetRoomByinterest.dart';
import '../model/MaterialsModel.dart';
import '../model/QuestionModel.dart';
import '../model/Report.dart';
import '../model/Requesteduserss.dart';
import '../model/RoomReportById.dart';
import '../model/RoomsByInterests.dart';
import '../model/RoomsJoined.dart';
import '../model/UserRoomReport.dart';
import '../model/UserRoomReport.dart';
import '../model/UserRoomReport.dart';
import '../model/User_model.dart';

import '../model/searchmodel.dart';
import '../modules/Profile/profile_screen.dart';
import '../modules/home/home_screen.dart';
import '../modules/login/Loginscreen.dart';
import '../modules/notification/notification_screen.dart';
import '../network/CacheHelper.dart';
import '../network/DioHelper.dart';
import '../network/end_pionts.dart';
import 'package:http/http.dart' as http;

class learnUpCuibit extends Cubit<learnUpStates> {
  learnUpCuibit() : super(learnUpInitStates());

  static learnUpCuibit get(context) => BlocProvider.of(context);
  RoombyId? roombyId;
  dynamic token = CacheHelper.getData(key: 'result');
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItem = [
    const BottomNavigationBarItem(
      icon: Icon(Iconsax.home),
      label: "home ",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Iconsax.notification),
      label: "noitfication ",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Iconsax.profile_2user),
      label: "Profile ",
    )
  ];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(learnUpBottomNavInitStates());
  }
  List<Widget> Screen = [
    HomeScreen(),
    Notification_screen(),
    profile_screen()
  ];
  List<dynamic> business = [];
  Widget? getFAB() {
    if (Screen[currentIndex] == 0) {
      return const FloatingActionButton(
          backgroundColor: Colors.cyan,
          child: Icon(Icons.add),
          onPressed: null);
    } else {
      return FloatingActionButton(
          backgroundColor: Colors.deepOrange[800],
          child: const Icon(Icons.shopping_cart),
          onPressed: null);
    }
  }
  void startTimer(double _progress) {
    Timer.periodic(
      const Duration(seconds: 1),
          (Timer timer) =>
      (() {
        if (_progress == 1) {
          timer.cancel();
        } else {
          _progress += 0.2;
        }
      }),
    );
  }
  void GetRoombyId(int id) {
    emit(RoomsloadingsStates());
    DioHelper.getData(url: ROOMbyId + id.toString(), token: token).then((
        value) {
      roombyId = RoombyId.fromJson(value.data);


      emit(RoomsSuccessStates());
    }).catchError((error) {
      print(roombyId?.result?.name);
      print('Error sending request!');
      print(error.response.data);
      print(error.response.headers);
      print(error.response.requestOptions);
      print(error.requestOptions);

      print(token);
      emit(RoomsErrorStates(roombyId!));
      {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(error.message);
        print(error.response.data);
        print(error.response.headers);
        print(error.response.requestOptions);
        print(error.requestOptions);
        emit(RoomsErrorStates(roombyId!));
      }
    });
  }
  Usermodel? usermodel;
  Getinterest? getinterest;
  Getinterest? getAllinterest;
  dynamic interest = [];
  void GetUserdata() {
    emit(UserDataLoadingState());
    DioHelper.getData(url: User, token: token).then((value) {
      usermodel = Usermodel.fromJson(value.data);


      CacheHelper.putData(key: 'id', value: usermodel!.result!.id);


      emit(UserDataSuccessState(usermodel!));
    }).catchError((error) {
      if (error) {
        print(token);
        print('Dio error!');
        print(token);
        emit(UserDataErrorState());
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(error.message);

        emit(UserDataErrorState());
      }
    });
  }
  void GetInterest() {
    emit(GetInterestsLoadingState());
    DioHelper.getData(url: Interest, token: token).then((value) {
      getinterest = Getinterest.fromJson(value.data);
      if (kDebugMode) {
        print(getinterest?.messageCode);
        print(getinterest?.result![4].id);
        print(token);
      }
      emit(GetInterestsSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(getinterest?.errors);
      }
      if (kDebugMode) {
        print('Error sending request!');
      }
      if (kDebugMode) {
        print(error);
      }

      if (kDebugMode) {
        print(token);
      }
      emit(GetInterestsErrorState());
      {
        // Error due to setting up or sending the request
        if (kDebugMode) {
          print('Error sending request!');
        }
        if (kDebugMode) {
          print(error.message);
        }

        emit(GetInterestsErrorState());
      }
    });
  }
  void GetAllInterests() {
    emit(GetAllInterestsLoadingState());
    DioHelper.getData(url: GetAllInterest, token: token).then((value) {
      getAllinterest = Getinterest.fromJson(value.data);
      if (kDebugMode) {
        print(getAllinterest?.messageCode);
        print(getAllinterest?.result![4].id);
        print(token);
      }
      emit(GetAllInterestsSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(getinterest?.errors);
      }
      if (kDebugMode) {
        print('Error sending request!');
      }
      if (kDebugMode) {
        print(error);
      }

      if (kDebugMode) {
        print(token);
      }
      emit(GetAllInterestsErrorState());
      {
        // Error due to setting up or sending the request
        if (kDebugMode) {
          print('Error sending request!');
        }
        if (kDebugMode) {
          print(error.message);
        }

        emit(GetAllInterestsErrorState());
      }
    });
  }
  void Addintrest({required List interestdata}) {
    emit(InterestsLoadingState());
    DioHelper.postData(url: Interest, token: token, data: {
      "Interests": interestdata,
    },).then((value) {
      if (kDebugMode) {
        print(value.data);
      }
      emit(InterestsSuccessState());
    }).catchError((error) {
      if (error.response != null) {
        if (kDebugMode) {
          print('Dio error!');
        }
        if (kDebugMode) {
          print('STATUS: ${error.response?.statusCode}');
        }
        if (kDebugMode) {
          print('DATA: ${error.response?.data}');
        }
        if (kDebugMode) {
          print('HEADERS: ${error.response?.headers}');
        }
        emit(InterestsErrorState(errors["messageCode"]));
      } else {
        // Error due to setting up or sending the request
        if (kDebugMode) {
          print('Error sending request!');
        }
        if (kDebugMode) {
          print(error.message);
        }
        emit(InterestsErrorState(errors["messageCode"]));
      }
    });
  }
  void SignOut(context) {
    CacheHelper.removeData(key: 'result').then((value) {
      if (value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    }
    );
    CacheHelper.removeData(key: 'id').then((value) {
      if (value) {


      }
    }
    );
  }
  creaateRooms?rooms;
  ///create Room
  void CreateRooms({required String Name, required String description, required int Cost, required List interests, required DateTime StartDate, required DateTime EndDate,}) {
    emit(CreateRoomLoadingState());

    DioHelper.postData(
      url: CreateRoom,
      token: token,
      data: {
        'roomName': Name,
        'roomDescription': description,
        'price': Cost,
        'expectedEndDate': EndDate.toIso8601String(),
        'startDate': StartDate.toIso8601String(),
        'interests': interests,

      },
    ).then((value) {
      rooms = creaateRooms.fromJson(value.data);

      if (kDebugMode) {
        print(rooms!.result);
      }
      emit(CreateRoomSuccessState(rooms!));
    }).catchError((error) {
      if (kDebugMode) {
        print('Dio error!');
      }
      if (kDebugMode) {
        print('STATUS: ${error.response?.statusCode}');
      }
      if (kDebugMode) {
        print('DATA: ${error.response?.data}');
      }
      if (kDebugMode) {
        print('HEADERS: ${error.response?.headers}');
      }
      emit(CreateRoomErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  RoombyInterest? roombyInterest;
  void GetRoomByInterest(String Interests) {
    emit(GetRoomByInterestLoadingState());
    DioHelper.getData(url: GetRoomInterest + Interests, token: token).then((
        value) {
      roombyInterest = RoombyInterest.fromJson(value.data);

      emit(GetRoomByInterestSuccessState());
    }).catchError((error) {
      if (error) {
        print(token);
        print('Dio error!');


        print(token);
        emit(GetRoomByInterestErrorState());
      } else {
        if (kDebugMode) {
          print('STATUS: ${error.response?.statusCode}');
        }
        if (kDebugMode) {
          print('DATA: ${error.response?.data}');
        }
        if (kDebugMode) {
          print('HEADERS: ${error.response?.headers}');
        }
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(error.message);

        emit(GetRoomByInterestErrorState());
      }
    });
  }
  dynamic join = [];
  void joinRoom(String idRoom) {
    emit(JoinRoomLoadingState());
    DioHelper.postData(
        url: JoinRoom1 + idRoom + JoinRoom2, token: token, data: {}).then((
        value) {
      join = value.data;
      if (kDebugMode) {
        print(join["result"]);
      }
      emit(JoinRoomSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(getinterest?.errors);
      }
      if (kDebugMode) {
        print('Error sending request!');
      }
      if (kDebugMode) {
        print(error);
      }

      if (kDebugMode) {
        print(token);
      }
      emit(JoinRoomErrorState());
      {
        // Error due to setting up or sending the request
        if (kDebugMode) {
          print('Error sending request!');
        }
        if (kDebugMode) {
          print(error.message);
        }

        emit(JoinRoomErrorState());
      }
    });
  }
  Requesteduserss? requesteduserss;
  void RequestedUsers(String idRooms) {
    emit(RequestedUsersLoadingState());
    DioHelper.getData(url: JoinRoom1 + idRooms + requestedUsers, token: token)
        .then((value) {
      requesteduserss = Requesteduserss.fromJson(value.data);
      emit(RequestedUsersSuccessState());
    }).catchError((error) {
      if (error) {
        print(token);
        print('Dio error!');


        print(token);
        emit(RequestedUsersErrorState());
      } else {
        if (kDebugMode) {
          print('STATUS: ${error.response?.statusCode}');
        }
        if (kDebugMode) {
          print('DATA: ${error.response?.reasonPhrase}');
        }
        if (kDebugMode) {
          print('HEADERS: ${error.response?.headers}');
        }
        // Error due to setting up or sending the request


        emit(RequestedUsersErrorState());
      }
    });
  }
  void AcceptUsers({required String Iduser, required String IdofRooms,}) {
    emit(AcceptUserLoadingState());

    DioHelper.putdata(
      url: JoinRoom1 + IdofRooms + AcceptUser + Iduser,
      token: token,
      data: {
      },
    ).then((value) {
      if (kDebugMode) {
        print("Done");
      }
      emit(AcceptUserSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print('Dio error!');
      }
      if (kDebugMode) {
        print('STATUS: ${error.response?.statusCode}');
      }
      if (kDebugMode) {
        print('DATA: ${error.response?.data}');
      }
      if (kDebugMode) {
        print('HEADERS: ${error.response?.headers}');
      }
      emit(AcceptUserErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  Future<void> RejectUser({required String Iduser, required String IdofRooms,}) async {
    emit(RejectUserLoadingState());

    DioHelper.putdata(
      url: JoinRoom1 + IdofRooms + RejectUsers + Iduser,
      token: token,
      data: {
      },
    ).then((value) {
      if (kDebugMode) {
        print("Done");
      }
      emit(RejectUserSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print('Dio error!');
      }
      if (kDebugMode) {
        print('STATUS: ${error.response?.statusCode}');
      }
      if (kDebugMode) {
        print('DATA: ${error.response?.data}');
      }
      if (kDebugMode) {
        print('HEADERS: ${error.response?.headers}');
      }
      emit(RejectUserErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  ///List<dynamic> geetRoom=[];
  ///GetRooms?getRooms;
  void GetRoom() {
    DioHelper.getData(url: GetRoomss, token: token).then((value) {
      print(value.data);

      var list = [];

      value.data.forEach((key, value) {
        list.add(value);
      });
      // for(var productInfo in list)
      // {
      //   Product product = new Product.fromJson(productInfo);
      //   // add product to your List...
      // }
      print(list);
      // getRooms = GetRooms.fromJson(jsonDecode(value.data));
      //   if (value.data){
      //  var geetRoom=value.data;
      //  var list =   [];
      //  geetRoom.forEach((key, value){
      //    list.add(value);
      //  });
      //
      //  print(list);
      //

      //   // if (kDebugMode) {
      //   //   print( "googomgomgom"+
      //   //       // geetRoom.length.toString()
      //   //        getRooms!.result!.values![2]![3].ownerName
      //   //   );
      //   // }
      //  }


    }).catchError((error) {
      if (error) {
        print(token);
        print('Dio error!');

        if (kDebugMode) {
          print('STATUS: ${error.response?.statusCode}');
        }
        if (kDebugMode) {
          print('DATA: ${error.response?.data}');
        }
        if (kDebugMode) {
          print('HEADERS: ${error.response?.headers}');
        }
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(error.message);
      } else {
        if (kDebugMode) {
          print('STATUS: ${error.response?.statusCode}');
        }
        if (kDebugMode) {
          print('DATA: ${error.response?.data}');
        }
        if (kDebugMode) {
          print('HEADERS: ${error.response?.headers}');
        }
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(error.message);
      }
    });
  }
  dynamic errors = [];
  void CreateQuestion({required String title, required String description, required id,}) {
    emit(AddQuestionLoadingState());

    DioHelper.postData(
      url: AddQuestion + id + AddQuestion1,
      token: token,
      data: {
        'questionTitle': title,
        'questionDescription': description,
      },
    ).then((value) {
      print("done");
      GetQuestions(idRoom: id);
      emit(AddQuestionSuccessState());
    }).catchError((error) {
      errors = error.response?.data;
      print(errors["errors"][0]["message"]);

      emit(AddQuestionErrorState(errors));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  QuestionModel?questionModel;
  void GetQuestions({required String idRoom}) {
    emit(GetQuestionLoadingState());

    DioHelper.getData(url: AddQuestion + idRoom + AddQuestion1, token: token)
        .then((value) {
      questionModel = QuestionModel.fromJson(value.data);
      print(questionModel!.Questions![0].questionDescription);


      emit(GetQuestionSuccessState());
    }).catchError((error) {
      if (error) {
        print(token);
        print('Dio error!');

        if (kDebugMode) {
          print('STATUS: ${error.response?.statusCode}');
        }
        if (kDebugMode) {
          print('DATA: ${error.response?.data}');
        }
        if (kDebugMode) {
          print('HEADERS: ${error.response?.headers}');
        }
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(error.message);
        emit(GetQuestionErrorState());
      } else {
        if (kDebugMode) {
          print('STATUS: ${error.response?.statusCode}');
        }
        if (kDebugMode) {
          print('DATA: ${error.response?.data}');
        }
        if (kDebugMode) {
          print('HEADERS: ${error.response?.headers}');
        }
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(error.message);

        emit(GetQuestionErrorState());
      }
    });
  }
  AnswerModel?answerModel;
  void Getanswer({required String idquestion}) {
    emit(GetanswerLoadingState());
    DioHelper.getData(url: AddQuestion + idquestion, token: token).then((
        value) {
      answerModel = AnswerModel.fromJson(value.data);
      print(answerModel!.Questions!.questionDescription);
      emit(GetanswerSuccessState());
    }).catchError((error) {
      if (error) {
        // Error due to setting up or sending the request
        print(error.message);
        emit(GetanswerErrorState());
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(error.message);
        emit(GetanswerErrorState());
      }
    });
  }
  String fileType = 'All';
  var fileTypeList = ['All', 'Image', 'Video', 'Audio', 'MultipleFile,Pdf'];
  FilePickerResult? result;
  late PlatformFile file;
  void pickFiles({String? filetype,required String IdRoomfile}) async {
    switch (filetype) {
      case 'All':
        result = await FilePicker.platform.pickFiles();
        if (result == null) return;
        file = result!.files.first;
        emit(FilesPickedSuccessState());
        break;
    }


    Upload(IdRoomfile);
  }
  Future<void> Upload(IdRoomfile) async {
    String fileName = file.path!.split('/').last;
    String? mimeType = mime(fileName);

    emit(UploadFilesLoadingState());
    final uri = Uri.parse("http://abdonabil-001-site1.itempurl.com/api/Rooms/$IdRoomfile/Materials");
    var request = http.MultipartRequest('POST', uri);
    final httpImage = await http.MultipartFile.fromPath('Files', file.path!,
        contentType: MediaType.parse(mimeType!), filename: fileName);
    request.files.add(httpImage);
    request.headers.addAll({'Authorization': 'Bearer $token'});

    final response = await request.send();

    print(response.statusCode);

    var responsed = await http.Response.fromStream(response);
    final responsedData = jsonDecode(responsed.body);
    if (response.statusCode == 200) {
      emit(UploadFilesSuccessState());
      print("success");
      print(responsedData);
    } else {
      print("erorr");
      emit(UploadFilesErrorState());
    }
  }
  Future<void> Deleteanswer({required String idasnwer,}) async {
    emit(DeleteanswerLoadingState());

    DioHelper.Deletedata(
      url: DeleteAnswer + idasnwer, token: token,
    ).then((value) {
      if (kDebugMode) {
        print("Done");
      }
      emit(DeleteanswerSuccessState());
    }).catchError((error) {
      emit(DeleteanswerErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  Future<void> UpdateYourAnswer({required String UpdateAnswer, required String IdAns }) async {
    emit(UpdateanswerLoadingState());
    DioHelper.putdata(data: {
      "answerDescription":  UpdateAnswer
    }, url: UpdateUAnswer+IdAns,token: token).then((value) {

       print("success");
emit(UpdateanswerSuccessState());
    }).catchError((error) {
      emit(UpdateanswerErrorState());
      if (error) {
        // Error due to setting up or sending the request
        print(error.message);
        print('DATA: ${error.response?.data}');
        emit(UpdateanswerErrorState());
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(error.message);
        emit(UpdateanswerErrorState());
        print('DATA: ${error.response?.data}');
      }
    });
  }
  Future<void>  AddAnswers({required String YourAnwer,  required int?  id,required Idansweer }) async {
    emit(AddQuestionLoadingState());

    DioHelper.postData(
      url: AddQuestion + id.toString() + AddQuestion1+"/$Idansweer"+AddAnswer,
      token: token,
      data: {
        'answerDescription': YourAnwer,

      },
    ).then((value) {

      emit( AddanswerSuccessState());
    }).catchError((error) {
      errors = error.response?.data;
      print(errors["errors"][0]["message"]);

      emit( AddanswerErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  Future<void> DeleteQuestions({required String IdQs,}) async {
    emit(DeleteanswerLoadingState());

    DioHelper.Deletedata(
      url: DeleteQuestion + IdQs, token: token,
    ).then((value) {
      if (kDebugMode) {
        print("Done");
      }
      emit(DeleteanswerSuccessState());
    }).catchError((error) {
      emit(DeleteanswerErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  Map materialsModel={};
  Future<void> GetMaterial({required String idRoom}) async {
    emit(GetMaterialsLoadingState());

    DioHelper.getData(url:JoinRoom1+idRoom+getMaterials, token: token)
        .then((value) {


      materialsModel=value.data;
      print(materialsModel["result"].length);



          emit(GetMaterialsSuccessState ());
    }).catchError((error) {
      if (error) {
        print(token);
        print('Dio error!');

        if (kDebugMode) {
          print('STATUS: ${error.response?.statusCode}');
        }
        if (kDebugMode) {
          print('DATA: ${error.response?.data}');
        }
        if (kDebugMode) {
          print('HEADERS: ${error.response?.headers}');
        }
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(error.message);
        emit(GetMaterialsErrorState());
      } else {
        if (kDebugMode) {
          print('STATUS: ${error.response?.statusCode}');
        }
        if (kDebugMode) {
          print('DATA: ${error.response?.data}');
        }
        if (kDebugMode) {
          print('HEADERS: ${error.response?.headers}');
        }
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(error.message);

        emit(GetMaterialsErrorState());
      }
    });
  }
  Map CreatedRoomsReports={};Future<void> GetUserCreatedRoomsReports( ) async {
    emit(GetCreatedRoomsReportsLoadingState());

    DioHelper.getData(url:GetUserCreatedRoomsReport, token: token)
        .then((value) {


      CreatedRoomsReports=value.data;
      print(CreatedRoomsReports["result"]["roomActivities"]);



          emit(GetCreatedRoomsReportsSuccessState ());
    }).catchError((error) {
      if (error) {
        print(token);
        print('Dio error!');

        if (kDebugMode) {
          print('STATUS: ${error.response?.statusCode}');
        }
        if (kDebugMode) {
          print('DATA: ${error.response?.data}');
        }
        if (kDebugMode) {
          print('HEADERS: ${error.response?.headers}');
        }
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(error.message);
        emit(GetCreatedRoomsReportsErrorState());
      } else {
        if (kDebugMode) {
          print('STATUS: ${error.response?.statusCode}');
        }
        if (kDebugMode) {
          print('DATA: ${error.response?.data}');
        }
        if (kDebugMode) {
          print('HEADERS: ${error.response?.headers}');
        }
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(error.message);

        emit(GetCreatedRoomsReportsErrorState());
      }
    });
  }
  Map GetUserRoomsReportMap={};
  UserRoomsReports?userRoomsReport;
  Future<void> GetUserRoomsReport( ) async {
    emit(GetCreatedRoomsReportsLoadingState());

    DioHelper.getData(url:GetUserRoomsReports, token: token)
        .then((value) {

      userRoomsReport=UserRoomsReports.fromJson(value.data);
      GetUserRoomsReportMap=value.data;
      print(userRoomsReport!.result!.numberOfJoinedRooms);



          emit(GetCreatedRoomsReportsSuccessState ());
    }).catchError((error) {
      if (error) {
        print(token);
        print('Dio error!');

        if (kDebugMode) {
          print('STATUS: ${error.response?.statusCode}');
        }
        if (kDebugMode) {
          print('DATA: ${error.response?.data}');
        }
        if (kDebugMode) {
          print('HEADERS: ${error.response?.headers}');
        }
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(error.message);
        emit(GetCreatedRoomsReportsErrorState());
      } else {
        if (kDebugMode) {
          print('STATUS: ${error.response?.statusCode}');
        }
        if (kDebugMode) {
          print('DATA: ${error.response?.data}');
        }
        if (kDebugMode) {
          print('HEADERS: ${error.response?.headers}');
        }
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(error.message);

        emit(GetCreatedRoomsReportsErrorState());
      }
    });
  }
  late Map GetRoomReportsModel={};
  Future<void> GetRoomReports({required String idroom} ) async {
    emit(GetRoomReportLoadingState());
    DioHelper.getData(url:GetRoomReport+idroom, token: token)
        .then((value) {
      GetRoomReportsModel=value.data;
          emit(GetRoomReportSuccessState ());
    }).catchError((error) {
      if (error) {
        print(token);
        print('Dio error!');

        if (kDebugMode) {
          print('STATUS: ${error.response?.statusCode}');
        }
        if (kDebugMode) {
          print('DATA: ${error.response?.data}');
        }
        if (kDebugMode) {
          print('HEADERS: ${error.response?.headers}');
        }
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(error.message);
        emit(GetRoomReportErrorState());
      } else {
        if (kDebugMode) {
          print('STATUS: ${error.response?.statusCode}');
        }
        if (kDebugMode) {
          print('DATA: ${error.response?.data}');
        }
        if (kDebugMode) {
          print('HEADERS: ${error.response?.headers}');
        }
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(error.message);

        emit(GetRoomReportErrorState());
      }
    });
  }
  SearchModel? searchModel;
  Future<void> SearchR( {required String Word, bool?SkipRooms , bool?SkipInterests} ) async {
    bool?SkipRooms;
    bool?SkipInterests;
    emit(SearchLoadingState());
    DioHelper.getData(url:Search+Word   , token: token)
        .then((value) {
          searchModel=SearchModel.fromJson(value.data);
          emit(SearchSuccessState ());
    }).catchError((error) {
       if (error) {
        print('Dio error!');
        if (kDebugMode) {
          print('STATUS: ${error.response?.statusCode}');
        }
        if (kDebugMode) {
          print('DATA: ${error.response?.data}');
        }
        if (kDebugMode) {
          print('HEADERS: ${error.response?.headers}');
        }
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(error.message);
        emit(GetRoomReportErrorState());
      } else {
        if (kDebugMode) {
          print('STATUS: ${error.response?.statusCode}');
        }
        if (kDebugMode) {
          print('DATA: ${error.response?.data}');
        }
        if (kDebugMode) {
          print('HEADERS: ${error.response?.headers}');
        }
           /// Error due to setting up or sending the request
        print('Error sending request!');
        print(error.message);
        emit(SearchErrorState());
      }
    });
  }
  dynamic listinvite={};
  Future<void>  Invites({required String RoomId,   required String UserId }) async {
          emit(InvitesLoadingState());

    DioHelper.postData(
      url: JoinRoom1 + RoomId + InvitesPeople+UserId,
      token: token,
      data: {
      },
    ).then((value) {
          listinvite=value.data;
          emit( InvitesSuccessState());
    }).catchError((error) {
           errors = error.response?.data;
           print(errors["messageCode"]);
           emit( InvitesErrorState(errors["messageCode"]));
           if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  dynamic Myinvite={};
  Future<void> GetInvites(  ) async {
    emit(GetInvitesLoadingState());

    DioHelper.getData(url :GetInvitesPeople , token: token)
        .then((value) {
             Myinvite=value.data;
             emit(GetInvitesSuccessState ());
    }).catchError((error) {
      if (error) {

             print('Dio error!');

               if (kDebugMode) {
          print('STATUS: ${error.response?.statusCode}');
        }
               if (kDebugMode) {
          print('DATA: ${error.response?.data}');
        }
               if (kDebugMode) {
          print('HEADERS: ${error.response?.headers}');
        }
        /// Error due to setting up or sending the request
             print('Error sending request!');
               print(error.message);
               emit(GetInvitesErrorState());
      } else {
            if (kDebugMode) {
          print('STATUS: ${error.response?.statusCode}');
        }
            if (kDebugMode) {
          print('DATA: ${error.response?.data}');
        }
            if (kDebugMode) {
          print('HEADERS: ${error.response?.headers}');
        }
       /// Error due to setting up or sending the request
            print('Error sending request!');
            print(error.message);
            emit(GetInvitesErrorState());
      }
    });
  }

  Future<void> Requestedinvite(String idRooms) async {
    emit(RequestedUsersLoadingState());
    DioHelper.getData(url: JoinRoom1 + idRooms + requestedUsers, token: token)
        .then((value) {
      requesteduserss = Requesteduserss.fromJson(value.data);
      emit(RequestedUsersSuccessState());
    }).catchError((error) {
      if (error) {
        print(token);
        print('Dio error!');


        print(token);
        emit(RequestedUsersErrorState());
      } else {
        if (kDebugMode) {
          print('STATUS: ${error.response?.statusCode}');
        }
        if (kDebugMode) {
          print('DATA: ${error.response?.reasonPhrase}');
        }
        if (kDebugMode) {
          print('HEADERS: ${error.response?.headers}');
        }
        // Error due to setting up or sending the request


        emit(RequestedUsersErrorState());
      }
    });
  }

  Future<void>  AcceptInvites({required String InviteId, }) async {
    emit(AcceptInvitesLoadingState());

    DioHelper.putdata(
      url:InvitesPeople + InviteId + AcceptInvite,
      token: token,
      data: {
      },
    ).then((value) {
      if (kDebugMode) {
        print("Done");
      }
      emit(AcceptInvitesSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print('Dio error!');
      }
      if (kDebugMode) {
        print('STATUS: ${error.response?.statusCode}');
      }
      if (kDebugMode) {
        print('DATA: ${error.response?.data}');
      }
      if (kDebugMode) {
        print('HEADERS: ${error.response?.headers}');
      }
      emit(AcceptInvitesErrorState(errors["messageCode"]));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void>  RejectInvites({required String InviteId, }) async {
    emit(RejectInvitesLoadingState());

    DioHelper.putdata(
      url:InvitesPeople + InviteId + RejectInvite,
      token: token,
      data: {
      },
    ).then((value) {
      if (kDebugMode) {
        print("Done");
        print(value.data);
      }
      emit(RejectInvitesSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print('Dio error!');
      }
      if (kDebugMode) {
        print('STATUS: ${error.response?.statusCode}');
      }
      if (kDebugMode) {
        print('DATA: ${error.response?.data}');
      }
      if (kDebugMode) {
        print('HEADERS: ${error.response?.headers}');
      }
      emit(RejectInvitesErrorState(errors["messageCode"]));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void>   DeleteInterests({required String InterestId,}) async {
    emit(DeleteInterestLoadingState());
    DioHelper.Deletedata(
      url: DeleteInterest + InterestId, token: token,
    ).then((value) {
      if (kDebugMode) {
        print("Done");
      }
      emit(DeleteInterestSuccessState());
    }).catchError((error) {
      emit(DeleteInterestErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }


}