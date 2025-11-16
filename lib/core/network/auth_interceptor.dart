import 'package:dio/dio.dart';
import 'dart:developer' as developer;

import 'package:shree_geeta/core/storage/token_storage.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  bool _isRefreshing = false;

  AuthInterceptor(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_isPublicEndPoint(options.path)) {
      return handler.next(options);
    }

    final token = await TokenStorage.getAccesstoken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = "Bearer $token";
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;

      try {
        await TokenStorage.clearTokens();
        return handler.reject(err);
      } catch (e) {
        developer.log('Auth error: $e', name: 'AuthInterceptor');
        await TokenStorage.clearTokens();
        return handler.reject(err);
      } finally {
        _isRefreshing = false;
      }
    }

    handler.next(err);
  }

  bool _isPublicEndPoint(String path) {
    final publicEndPoints = ['/login', '/register'];
    return publicEndPoints.any((endpoint) => path.contains(endpoint));
  }
}
