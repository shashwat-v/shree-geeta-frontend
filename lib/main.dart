import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shree_geeta/features/auth/provider/auth_provider.dart';
import 'package:shree_geeta/app/app.dart';

void main() {
  runApp(const ShreeGeetaApp());
}

class ShreeGeetaApp extends StatelessWidget {
  const ShreeGeetaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..checkAuthState()),
      ],
      child: const App(),
    );
  }
}
