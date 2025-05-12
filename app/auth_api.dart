import 'package:dio/dio.dart';

class AuthApi {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://your.api.com/',
    headers: {'Content-Type': 'application/json'},
  ));

  static Future<String> login({
    required String store,
    required String account,
    required String password,
  }) async {
    final response = await _dio.post('/login', data: {
      'store': store,
      'account': account,
      'password': password,
    });

    return response.data['token'] as String;
  }
}