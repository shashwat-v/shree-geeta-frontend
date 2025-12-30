import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shree_geeta/features/auth/provider/auth_provider.dart';
import 'package:shree_geeta/core/storage/token_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    // If the user hasn't seen onboarding, send them to the welcome (GetStarted) screen first
    final seenOnboarding = await TokenStorage.hasSeenOnboarding();
    if (!mounted) return;
    if (!seenOnboarding) {
      Navigator.pushReplacementNamed(context, '/welcome');
      return;
    }

    final auth = context.read<AuthProvider>();
    await auth.checkAuthState();

    if (!mounted) return;

    if (auth.isAuthenticated) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
