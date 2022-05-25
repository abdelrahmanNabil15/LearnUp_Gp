import 'RoomModel.dart';

class GetRooms{
   GetRoomResult? result;
  GetRooms.fromJson(Map<String, dynamic> json){
    if(json["result"]!= null )

      print("result is not null");
        if(json["result"]["values"]!= null) {
          print("values is not null");
          print(json["result"]["values"]);

          result = GetRoomResult.fromJson(json["result"]["values"]);
        }
      }
  }

//() !
class GetRoomResult{
   Map<String,List<RoomModel>> ?values;
  GetRoomResult({required this.values});
  GetRoomResult.fromJson(Map<String, dynamic> json)
  {
    json.forEach((key, value) {
      print(key);
      print(value);
      List< dynamic> ?listDynamic;
      try{
         listDynamic = value as List<dynamic>;
      }
      catch (e )
      {
        print("error happended");
        print(e);
      }
     values![key] = listDynamic!.map<RoomModel>((e) => RoomModel.fromJson(e)).toList();

    });
  }
}