import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:login_pratice/model/response_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<ResponseModel?> login(String username, String password) async {
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

  Future<void> signIn(
      String username, String password, BuildContext context) async {
    
    ResponseModel? responseData = await login(username, password);

    if (responseData != null &&
        responseData.status == true &&
        responseData.token != null) {
      String token = responseData.token!;
      int userId = responseData.userID!;
      

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Giriş başarılı. Token: $token, UserID: $userId'),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Giriş yapılamadı. Kullanıcı adı veya şifre hatalı.'),
        ),
      );
    }
  }
}
