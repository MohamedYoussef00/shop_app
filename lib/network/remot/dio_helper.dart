
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;

  static init (){
    dio=Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
      ),

    );
  }

  static Future<Response> getData({
    @required String url,
    @required Map<String,dynamic> query,
    String lang='en',
    String token
  })async
  {
    dio.options.headers={
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token
    };
    return await dio.get(
        url,
        queryParameters: query
    );
  }

  static Future<Response> postData({
    @required String url,
     Map<String,dynamic> query,
     Map<String,dynamic> data,
    String lang='en',
    String token
  })async
  {
    dio.options.headers={
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token
    };
    return await dio.post(
        url,
        data:data,
        queryParameters: query
    );
  }

}