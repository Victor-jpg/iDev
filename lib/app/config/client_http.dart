import 'package:dio/dio.dart';

import 'constants.dart';

class ClientHttp {
  Dio dio = Dio();
  String _currentToken = '';

  ClientHttp() {
    dio.interceptors.clear();
    dio.options.baseUrl = API;

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          print("OLA");
          if (_currentToken.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $_currentToken';
            options.headers['Content-Type'] = 'application/json';
          }
          handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) =>
            handler.resolve(response),
        onError: (DioError error, ErrorInterceptorHandler handler) async {
          print("dsadasdsadasda");
          if (error.response?.statusCode == 401) {
            dio.interceptors.requestLock.lock();
            dio.interceptors.responseLock.lock();

            RequestOptions options = error.response.requestOptions;

            dio.interceptors.requestLock.unlock();
            dio.interceptors.responseLock.unlock();

            return handler.reject(error);
            // return dio.request(
            //   options.path,
            //   options: options.data,
            // );
          }
          return handler.reject(error);
        },
      ),
    );
  }
  Dio getClient() => dio;
}
