import 'package:flutter/material.dart';
import 'package:shree_geeta/chat_screen.dart';

void main() {
  runApp(const ShreeGeetaApp());
}

class ShreeGeetaApp extends StatelessWidget {
  const ShreeGeetaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 153, 51),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const Scaffold(body: ChatScreen()),
    );
  }
}
