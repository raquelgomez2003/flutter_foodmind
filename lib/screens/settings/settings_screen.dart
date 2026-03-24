import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajustes"),
        backgroundColor: Color(0xFF537e5e),
      ),
      body: const Center(
        child: Text("Pantalla de ajustes"),
      ),
    );
  }
}