import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:login_pratice/model/response_model.dart';
import 'package:login_pratice/shared/shared.dart';

class ApiService with SharedManager {
  final Dio _dio = Dio();

  Future<ResponseModel?> login(
      String username, String password, BuildContext context) async {
    try {
      Response response = await _dio.post(
        'http://192.168.1.105:81/api/login/authentication',
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return ResponseModel.fromJson(response.data);
      } else {
        debugPrint(
            "Api isteği başarısız : ${response.statusCode} - ${response.data}");
        return null;
      }
    } catch (e) {
      debugPrint("Api isteği hatası : $e");
      return null;
    }
  }

  Future<ResponseModel?> signIn(
      String username, String password, BuildContext context) async {
    ResponseModel? responseData = await login(username, password, context);
    return responseData;
  }
}
