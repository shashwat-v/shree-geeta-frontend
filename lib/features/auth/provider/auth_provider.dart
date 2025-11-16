import 'package:flutter/material.dart';
import 'package:shree_geeta/core/errors/api_exception.dart';
import 'package:shree_geeta/features/auth/data/auth_repository.dart';
import 'package:shree_geeta/features/auth/models/user.dart';
import 'dart:developer' as developer;

enum AuthState { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repo = AuthRepository();

  AuthState _state = AuthState.initial;
  User? _user;
  String? _error;

  AuthState get state => _state;
  User? get user => _user;
  String? get error => _error;
  bool get isLoading => _state == AuthState.loading;
  bool get isAuthenticated => _state == AuthState.authenticated;

  Future<void> checkAuthState() async {
    try {
      final hasToken = await _repo.isAuthenticated();

      if (!hasToken) {
        _state = AuthState.unauthenticated;
      } else {
        _user = await _repo.getCachedUser();
        try {
          _user = await _repo.getCurrentUser();
          _state = AuthState.authenticated;
        } catch (_) {
          _state = _user != null
              ? AuthState.authenticated
              : AuthState.unauthenticated;
        }
      }
    } catch (e) {
      developer.log("Auth check failed: $e");
      _state = AuthState.unauthenticated;
    }
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _state = AuthState.loading;
    notifyListeners();

    try {
      await _repo.login(email, password);
      _user = await _repo.getCurrentUser();
      _state = AuthState.authenticated;
      notifyListeners();
      return true;
    } on ApiException catch (e) {
      _error = e.message;
      _state = AuthState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signup(
    String name,
    String email,
    String username,
    String password,
  ) async {
    _state = AuthState.loading;
    notifyListeners();

    try {
      _user = await _repo.signup(name, email, username, password);
      _state = AuthState.authenticated;
      notifyListeners();
      return true;
    } on ApiException catch (e) {
      _error = e.message;
      _state = AuthState.error;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    _user = null;
    _state = AuthState.unauthenticated;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
