import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:developer' as developer;

class TokenStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  static const String _accessTokenKey = "access_token";
  static const String _userDataKey = "user_data";

  static Future<void> saveAccessToken(String token) async {
    try {
      await _storage.write(key: _accessTokenKey, value: token);
      developer.log('Access token saved!', name: 'TokenStorage');
    } catch (e) {
      developer.log('Failed to save access token: $e', name: 'TokenSotrage');
      rethrow;
    }
  }

  static Future<void> saveUserData(String userData) async {
    try {
      await _storage.write(key: _userDataKey, value: userData);
      developer.log('User Data Saved', name: 'TokenStorage');
    } catch (e) {
      developer.log('Failed to save user data: $e', name: 'TokenStorage');
    }
  }

  static Future<String?> getAccesstoken() async {
    try {
      return await _storage.read(key: _accessTokenKey);
    } catch (e) {
      developer.log('Failed to read user data: $e', name: 'TokenStorage');
      return null;
    }
  }

  static Future<String?> getUserData() async {
    try {
      return await _storage.read(key: _userDataKey);
    } catch (e) {
      developer.log('Failed to read user data: $e', name: 'TokenStorage');
      return null;
    }
  }

  static Future<bool> isAuthenticated() async {
    final token = await getAccesstoken();
    return token != null && token.isNotEmpty;
  }

  static Future<void> clearTokens() async {
    try {
      await _storage.deleteAll();
      developer.log("All tokens cleared", name: 'TokenStorage');
    } catch (e) {
      developer.log('Failed to clear tokens: $e', name: 'TokenStorage');
      rethrow;
    }
  }
}
