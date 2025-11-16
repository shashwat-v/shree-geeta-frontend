import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;
import 'auth_interceptor.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();
  late final Dio _dio;

  factory NetworkService() => _instance;

  NetworkService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _getBaseUrl(),
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );

    _dio.interceptors.addAll([
      AuthInterceptor(_dio),
      if (kDebugMode)
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
          error: true,
          logPrint: (obj) => developer.log(obj.toString(), name: 'Dio'),
        ),
    ]);
  }

  static NetworkService get instance => _instance;

  Dio get dio => _dio;

  String _getBaseUrl() {
    if (kReleaseMode) {
      return "https://api.shreegeeta.com";
    } else {
      return "http://127.0.0.1:8000";
    }
  }
}
