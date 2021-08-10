import 'package:dio/dio.dart';

class DioService {
  static const baseUrl = "https://dictionaryapi.dev/";
  Dio dio = Dio();
  DioService() {
    initializeInterceptors();
  }
  initializeInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(onError: (e, handler) {
      handler.next(e);
    }, onRequest: (r, handler) {
      print(r.method);
      print(r.path);
      handler.next(r);
    }, onResponse: (r, handler) {
      print(r.data);
      handler.next(r);
    }));
  }

  Future<Response> getRequest(String endPoint) async {
    Response response;
    try {
      response = await dio.get(endPoint);
    } on DioError catch (e) {
      print(e);
      throw Exception(e.message);
    }
    return response;
  }
}
