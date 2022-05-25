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
  }) {
    return dio.post(
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
