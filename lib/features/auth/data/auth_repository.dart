import 'dart:convert';

import 'package:shree_geeta/core/network/api_client.dart';
import 'package:shree_geeta/core/storage/token_storage.dart';
import 'package:shree_geeta/features/auth/models/user.dart';

class AuthRepository {
  final ApiClient _apiClient = ApiClient();

  Future<void> login(String email, String password) async {
    final auth = await _apiClient.login(email, password);
    await TokenStorage.saveAccessToken(auth.accessToken);
  }

  Future<User> signup(
    String name,
    String email,
    String username,
    String password,
  ) async {
    final reg = await _apiClient.register(name, email, username, password);

    final auth = await _apiClient.login(email, password);
    await TokenStorage.saveAccessToken(auth.accessToken);

    return User(id: reg.id, name: name, email: email, username: reg.username);
  }

  Future<User> getCurrentUser() async {
    final user = await _apiClient.getProfile();
    await TokenStorage.saveUserData(jsonEncode(user.toJson()));
    return user;
  }

  Future<User?> getCachedUser() async {
    final cached = await TokenStorage.getUserData();
    if (cached == null) return null;
    return User.fromJSON(jsonDecode(cached));
  }

  Future<bool> isAuthenticated() async {
    return TokenStorage.isAuthenticated();
  }

  Future<void> logout() async {
    await _apiClient.logout();
  }
}
