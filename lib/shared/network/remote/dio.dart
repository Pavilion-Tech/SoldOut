import 'dart:async';
import 'package:dio/dio.dart';
import 'package:soldout/shared/components/constants.dart';

class DioHelper {
  static late Dio dio;
  static late Response response;

  static void init1() {
    dio = Dio(
      BaseOptions(//https://soldout.pavilionapp.tech/api
        baseUrl: 'https://soldout.sa/api',
        receiveTimeout: Duration(seconds: 60),
        connectTimeout: Duration(seconds: 60),
        receiveDataWhenStatusError: true,
        validateStatus: (status) => true,
        followRedirects: true,
      ),
    );
  }

  static Future<Response> getData(
      {
        required String url,
        Map<String, dynamic>? query,
        String? token,
        String? lang,
      }) async {

    dio.options.headers =
    {
      'lang' : myLocale,
      'Authorization':token ,
      //'Accept-Language':lang??myLocale,
      'Content-Type': 'application/json',
    };
      return response = await dio.get(url, queryParameters: query);

  }

  static Future<Response> postData({
    required String url,
    Map<String , dynamic>? data,
    String? token,
    String? lang ,


  }) async {
    dio.options.headers =
    {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':token ,
      'lang' : myLocale,

    };

    return response = await dio.post(url, data: data,);
  }

  static Future<Response> postData2({
    required String url,
    Map<String , dynamic>? data,
    String? token,
    String? lang ,
    FormData? formData,


  }) async {

    dio.options.headers =
    {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':token ,
      'lang' : myLocale,

    };

    return response = await dio.post(url, data: formData,);
  }


  static Future<Response> putData({
    required String url,
    required Map<String , dynamic> data,
    String? token,
    String lang = 'en',


  }) async {
    dio.options.headers =
    {
      'lang' : myLocale,
      'Authorization':token ,
      'Content-Type': 'application/json'
    };
    return response = await dio.put(url, data: data);
  }
}
