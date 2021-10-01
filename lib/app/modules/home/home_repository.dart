import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_integrador/app/config/constants.dart';
import 'package:projeto_integrador/app/model/user_model.dart';
import 'package:projeto_integrador/app/modules/login/login_bloc.dart';

class HomeRepository extends Disposable {
  LoginBloc _loginBloc = Modular.get<LoginBloc>();
  Dio dio;
  HomeRepository(this.dio);

  Future getDevs(String token) async {
    try {
      Response response = await dio.get(
        "$API/devs",
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}"
        }),
      );

      List<UserModel> listDevs = response.data.map<UserModel>((e) {
        return UserModel.fromJson(e);
      }).toList();

      return listDevs;
    } catch (error) {
      print("ERROR");
      print(error);
    }
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
