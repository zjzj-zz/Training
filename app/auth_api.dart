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



// lib/api/auth_api.dart
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class AuthApi {
  final Dio _dio;

  AuthApi()
      : _dio = Dio(BaseOptions(
          baseUrl: 'https://your.api.com/', // 必要に応じて変更
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
          headers: {
            'Content-Type': 'application/json',
          },
        )) {
    // ログインタセプター追加
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
      logPrint: (object) => print('[DIO] $object'), // 任意のログフォーマット
    ));
  }

  Future<String> login({
    required String store,
    required String account,
    required String password,
  }) async {
    final timestamp = DateFormat("yyyy-MM-ddTHH:mm:ss'Z'").format(DateTime.now().toUtc());

    final response = await _dio.post('/login', data: {
      'store': store,
      'account': account,
      'password': password,
      'timestamp': timestamp,
    });

    return response.data['token'] as String;
  }
}