// lib/api/auth_api.dart
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class AuthApi {
  final Dio _dio;

  AuthApi()
      : _dio = Dio(BaseOptions(
          baseUrl: 'https://your.api.com/', // 実際のエンドポイントに変更
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        )) {
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
      logPrint: (object) => print('[DIO] $object'),
    ));
  }

  Future<String> login({
    required String store,
    required String account,
    required String password,
  }) async {
    final timestamp = DateFormat("yyyy-MM-ddTHH:mm:ss'Z'").format(DateTime.now().toUtc());

    final formData = {
      'store': store,
      'account': account,
      'password': password,
      'timestamp': timestamp,
    };

    final response = await _dio.post(
      '/login',
      data: formData,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );

    return response.data['token'] as String;
  }
}