import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_integrador/app/config/constants.dart';
import 'package:projeto_integrador/app/model/user_model.dart';
import 'package:projeto_integrador/app/modules/login/login_bloc.dart';

class Authentication {
  bool isValid;
  bool loading;
}

class LoginEvent implements Authentication {
  String message;
  bool isValid;
  bool loading;
  String userToken;
  Map<String, dynamic> errorData;
  LoginEvent({this.message, this.isValid, this.errorData, this.userToken});
}

class CurrentUser {
  UserModel userData;
  bool isValid;

  CurrentUser({this.isValid, this.userData});
}

class LoginRepository extends Disposable {
  Dio dio;
  LoginRepository(this.dio);

  Future<LoginEvent> login(String email, String password) async {
    print(email);
    print(password);
    try {
      final response = await dio.post('$API/auth/signin',
          options: Options(headers: {
            "Content-Type": "application/json",
          }),
          data: {"email": email, "password": password});

      return LoginEvent(
        message: "OK",
        isValid: true,
        userToken: response.data["access_token"],
      );
    } catch (e) {
      print(e);

      return LoginEvent(message: "Credenciais Inválidas.", isValid: false);
    }
  }

  Future<CurrentUser> currentUser(String token) async {
    try {
      final response = await dio.get('$API/auth/profile',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          }));

      UserModel userData = UserModel.fromJson(response.data);

      return CurrentUser(isValid: true, userData: userData);
    } catch (e) {
      return CurrentUser(isValid: false);
    }
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
