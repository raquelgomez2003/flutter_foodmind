import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/primary_button.dart';
import '../onboarding/pack_screen.dart';
import '../home/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Future<void> empezar(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final onboardingHecho =
        prefs.getBool('onboarding_completado') ?? false;

    if (!context.mounted) return;

    if (onboardingHecho) {
      // 👉 ya hizo onboarding → HOME
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    } else {
      // 👉 no lo ha hecho → PACK
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const PackScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 250,
                  child: Image.asset(
                    'assets/images/start_image.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'FOODMIND',
                  style: TextStyle(
                    fontFamily: 'MoreSugar',
                    fontSize: 40,
                    color: Color(0xFF537e5e),
                  ),
                ),
                const SizedBox(height: 40),
                PrimaryButton(
                  text: 'Start Cooking',
                  onPressed: () => empezar(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}