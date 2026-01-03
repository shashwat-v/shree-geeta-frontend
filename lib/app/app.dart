import 'package:flutter/material.dart';
import 'package:shree_geeta/features/auth/screens/landing_page.dart';
import 'package:shree_geeta/features/chat/screens/chat_screen.dart';
import 'package:shree_geeta/features/auth/screens/signin_screen.dart';
import '../features/auth/screens/signup_screen.dart';
import '../features/auth/screens/splash_screen.dart';

class App
    extends
        StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(
            255,
            255,
            153,
            51,
          ),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/welcome':
            (
              _,
            ) => GetStarted(),
        '/splash':
            (
              _,
            ) => const SplashScreen(),
        '/login':
            (
              _,
            ) => const SignInScreen(),
        '/signup':
            (
              _,
            ) => const SignUpScreen(),
        '/home':
            (
              _,
            ) => const ChatScreen(),
      },
    );
  }
}
