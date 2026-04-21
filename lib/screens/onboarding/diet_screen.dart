import 'package:flutter/material.dart';
import 'allergies_screen.dart';

class DietScreen extends StatefulWidget {
  final String numeroPack;

  const DietScreen({
    super.key,
    required this.numeroPack,
  });

  @override
  State<DietScreen> createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
  final TextEditingController _dietController = TextEditingController();

  @override
  void dispose() {
    _dietController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tu tipo de dieta"),
        backgroundColor: const Color(0xFF537e5e),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Escribe tu tipo de dieta:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _dietController,
              decoration: const InputDecoration(
                hintText: "Ejemplo: vegetariana, vegana, omnívora...",
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_dietController.text.trim().isEmpty) return;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AllergiesScreen(
                        numeroPack: widget.numeroPack,
                        diet: _dietController.text.trim(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF537e5e),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Continuar",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}