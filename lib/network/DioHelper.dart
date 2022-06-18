// ignore_for_file: file_names, avoid_print

import 'package:dio/dio.dart';

import 'end_pionts.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(BaseOptions(

          baseUrl: BASE_URL,    ));
  }

  static Future<Response> postData({
    required Map<String, dynamic> data,
    required String url,
    String? token,
    String? ContentType,
  }) {
    return dio.post(
      url,
      data: data,
      options: Options(
        headers: {
          'Content-Type':ContentType,
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
          "Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST,GET, OPTIONS"
        },
      ),
    );
  }

  static Future<Response> getdata({
    required String url,
    required Map<String,dynamic> query,

})async{
    return await dio.get(url,queryParameters: query,);
  }


  static Future<Response> getData({
    required String url,
    String? token,

    Map<String, dynamic>? query,
  }) {
    return dio.get(
      url,

      options: Options(

        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),

      queryParameters: query,
    );
  }

 static Future<Response> Deletedata({
    required String url,
    String? token,
    Map<String, dynamic>? query,
  }) {
    return dio.delete(
      url,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
      queryParameters: query,
    );
  }

  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    print("onError: ${err.response!.statusCode}");
    return handler.next(err);  // <--- THE TIP IS HERE
  }
  static Future<Response> putdata({
    required Map<String, dynamic> data,
    required String url,
    String? token,
  }) {
    return dio.put(
      url,
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }


}
