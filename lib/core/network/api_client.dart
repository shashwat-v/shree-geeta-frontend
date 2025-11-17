import 'package:dio/dio.dart';
import 'package:shree_geeta/core/errors/api_exception.dart';
import 'package:shree_geeta/core/network/network_service.dart';
import 'package:shree_geeta/core/storage/token_storage.dart';
import 'package:shree_geeta/features/auth/models/signin_response.dart';
import 'package:shree_geeta/features/auth/models/signup_response.dart';
import 'package:shree_geeta/features/auth/models/user.dart';
import 'dart:developer' as developer;

class ApiClient {
  final Dio _dio = NetworkService.instance.dio;

  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await _dio.post(
        "/login",
        data: {"email": email.trim().toLowerCase(), "password": password},
      );

      if (response.statusCode == 200) {
        return AuthResponse.fromJSON(response.data);
      } else {
        throw ApiException(
          message: response.data['detail'] ?? 'Login failed',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<RegisterResponse> register(
    String name,
    String email,
    String username,
    String password,
  ) async {
    try {
      final response = await _dio.post(
        "/register",
        data: {
          "name": name.trim(),
          "email": email.trim().toLowerCase(),
          "username": username.trim(),
          "password": password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegisterResponse.fromJSON(response.data);
      } else {
        throw ApiException(
          message: response.data['detail'] ?? 'Registration failed',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<User> getProfile() async {
    try {
      final response = await _dio.get("/me");

      if (response.statusCode == 200) {
        return User.fromJSON(response.data);
      } else {
        throw ApiException(
          message: 'Failed to fetch profiel',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> logout() async {
    try {} catch (e) {
      developer.log('Logout API error: $e', name: 'ApiClient');
    } finally {
      await TokenStorage.clearTokens();
    }
  }

  ApiException _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(
          message: 'Connection timeout. Check your internet',
          statusCode: e.response?.statusCode,
        );
      case DioExceptionType.badResponse:
        final detail = e.response?.data['detail'];
        String message = 'Server error';

        if (detail is String) {
          message = detail;
        } else if (detail is Map) {
          message = detail['msg'] ?? detail['message'] ?? message;
        }

        return ApiException(
          message: message,
          statusCode: e.response?.statusCode,
          data: e.response?.data,
        );
      case DioExceptionType.cancel:
        return ApiException(message: 'Request cancelled');
      case DioExceptionType.connectionError:
        return ApiException(message: 'No internet connection');
      default:
        return ApiException(message: e.message ?? 'Unknown Error');
    }
  }
}
