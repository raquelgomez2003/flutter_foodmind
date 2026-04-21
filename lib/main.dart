import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme/app_theme.dart';
import 'screens/welcome/welcome_screen.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(const FoodMindApp());
}

class FoodMindApp extends StatelessWidget {
  const FoodMindApp({super.key});

  Future<bool> comprobarOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarding_completado') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodMind',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: FutureBuilder<bool>(
        future: comprobarOnboarding(),
        builder: (context, snapshot) {
          // 🔄 mientras carga
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final onboardingHecho = snapshot.data!;

          // ✅ SI YA LO HIZO → HOME
          if (onboardingHecho) {
            return const HomeScreen();
          }

          // ❌ SI NO → FORMULARIO
          return const WelcomeScreen();
        },
      ),
    );
  }
}