import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;
  DioClient() : _dio = Dio() {
    _dio.options = BaseOptions(
        baseUrl: 'http://192.168.15.8:3000',
        contentType: 'application/json',
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        connectTimeout: const Duration(seconds: 15));
  }
  Dio get dio => _dio;
}
