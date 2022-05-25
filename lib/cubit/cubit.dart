// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_print, unrelated_type_equality_checks

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled2/cubit/state.dart';
import 'package:untitled2/model/RoomsJoined.dart';
import 'package:untitled2/modules/Profile/profile_screen.dart';
import 'package:untitled2/modules/home/home_screen.dart';
import 'package:untitled2/modules/notification/notification_screen.dart';

import '../model/CreateRoom.dart';
import '../model/GetInterests.dart';
import '../model/GetRoomByinterest.dart';
import '../model/Requesteduserss.dart';
import '../model/RoomsByInterests.dart';
import '../model/User_model.dart';

import '../modules/login/Loginscreen.dart';
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
    const notification_screen(),
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
      (Timer timer) => (() {
        if (_progress == 1) {
          timer.cancel();
        } else {
          _progress += 0.2;
        }
      }),
    );
  }

  void GetRoombyId(int id){
    emit(RoomsloadingsStates());
    DioHelper.getData(url: ROOMbyId+id.toString(), token: token).then((value) {
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

  dynamic interest=[];


  void GetUserdata() {
    emit(UserDataLoadingState());
    DioHelper.getData(url: User, token: token).then((value) {
      usermodel = Usermodel.fromJson(value.data);


      CacheHelper.putData(key: 'id', value: usermodel!.result!.id);



      emit(UserDataSuccessState(usermodel!));
    }).catchError((error) {

      if (error ) {
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
  void GetInterest(){
    emit(GetInterestsLoadingState());
    DioHelper.getData(url: Interest, token: token).then((value) {
      getinterest =   Getinterest.fromJson(value.data);
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
  void GetAllInterests(){
    emit(GetAllInterestsLoadingState());
    DioHelper.getData(url: GetAllInterest, token: token).then((value) {
      getAllinterest =   Getinterest.fromJson(value.data);
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

  void Addintrest({required String interestdata}) {

    emit(InterestsLoadingState());
    DioHelper.postData(url: Interest, token: token, data: {
      "interest": interestdata,
      "ignoreSimilarity": true

    },).then((value) {


      if (kDebugMode) {
        print(value.data);
      }
      emit(InterestsSuccessState());
    }).catchError((error) {
      if (error.response != null) {
        if (kDebugMode) {
          print(token);
        }
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
        if (kDebugMode) {
          print(token);
        }
        emit(InterestsErrorState());
      } else {
        // Error due to setting up or sending the request
        if (kDebugMode) {
          print('Error sending request!');
        }
        if (kDebugMode) {
          print(error.message);
        }

        emit(UserDataErrorState());
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
    ); CacheHelper.removeData(key: 'id').then((value) {
      if (value) {


      }
    }
    );
  }
  creaateRooms?rooms;

//create Room
  void CreateRooms({
    required String Name,
    required String description,
    required int Cost,
    required List interests,
    required String StartDate,
    required String EndDate,
  }) {
    emit(CreateRoomLoadingState());

    DioHelper.postData(
      url: CreateRoom,
      token: token,
      data: {
        'roomName': Name,
        'roomDescription': description,
        'price': Cost,
        'expectedEndDate': EndDate,
        'startDate': StartDate,
        'interests': interests,

      },
    ).then((value) {
      rooms= creaateRooms.fromJson(value.data);

      if (kDebugMode) {
        print(rooms!.result);
      }
        emit(CreateRoomSuccessState( rooms!));

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
    DioHelper.getData(url: GetRoomInterest+Interests, token: token).then((value) {
      roombyInterest = RoombyInterest.fromJson(value.data);

      emit(GetRoomByInterestSuccessState());
    }).catchError((error) {
      if (error ) {
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
dynamic join=[];
  void joinRoom(String idRoom){
    emit(JoinRoomLoadingState());
    DioHelper.postData(url: JoinRoom1+idRoom+JoinRoom2, token: token, data: {}).then((value) {
      join =  value.data;
      if (kDebugMode) {

        print( join["result"]);
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
    DioHelper.getData(url: JoinRoom1+idRooms+requestedUsers, token: token).then((value) {
      requesteduserss= Requesteduserss.fromJson(value.data);
      emit(RequestedUsersSuccessState());
    }).catchError((error) {
      if ( error) {
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

  void AcceptUsers({
    required String Iduser,


    required String IdofRooms,

  }) {
    emit(AcceptUserLoadingState());

    DioHelper.putdata(
      url: JoinRoom1+IdofRooms+AcceptUser+Iduser,
      token: token,
      data: {
      },
    ).then((value) {


      if (kDebugMode) {
        print("Done");
      }
      emit(AcceptUserSuccessState( ));

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

  Future<void> RejectUser({
    required String Iduser,


    required String IdofRooms,

  }) async {
    emit(RejectUserLoadingState());

    DioHelper.putdata(
      url: JoinRoom1+IdofRooms+RejectUsers+Iduser,
      token: token,
      data: {
      },
    ).then((value) {


      if (kDebugMode) {
        print("Done");
      }
      emit(RejectUserSuccessState( ));

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
//List<dynamic> geetRoom=[];
  //GetRooms?getRooms;
  void GetRoom() {

    DioHelper.getData(url: GetRoomss, token: token).then((value) {

      print(value.data);

      var list = [ ];

      value.data.forEach((key, value){
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
      if (error ) {
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

}
