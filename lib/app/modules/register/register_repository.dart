import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_integrador/app/config/constants.dart';

@Injectable()
class RegisterRepository extends Disposable {
  Dio dio;
  RegisterRepository(this.dio);

  Future submitRegister(Map<String, dynamic> data) async {
    try {
      final response = await dio.post('$API/auth/signup',
          options: Options(headers: {
            "Content-Type": "application/json",
          }),
          data: data);

      return {"statusCode": 201};
    } catch (error) {
      print("ERRor");
      print(error.response.data);
      if (error is DioError) {
        return error.response.data;
      }
    }
  }

  Future uploadImage(String path, String filename) async {
    FormData formData = FormData.fromMap(
        {'file': await MultipartFile.fromFile(path, filename: filename)});

    try {
      final response = await dio.post('$API/uploads',
          options: Options(headers: {
            "Content-Type": "multipart/form-data",
          }),
          data: formData);
      return response.data;
    } catch (error) {
      return error.response.data;
    }
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
