import 'package:flutter/material.dart';
import 'dislikes_screen.dart';

class AllergiesScreen extends StatefulWidget {
  final String numeroPack;
  final String diet;

  const AllergiesScreen({
    super.key,
    required this.numeroPack,
    required this.diet,
  });

  @override
  State<AllergiesScreen> createState() => _AllergiesScreenState();
}

class _AllergiesScreenState extends State<AllergiesScreen> {
  bool? hasAllergies;
  final TextEditingController _allergyController = TextEditingController();

  @override
  void dispose() {
    _allergyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alergias e intolerancias"),
        backgroundColor: const Color(0xFF537e5e),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "¿Tienes alguna intolerancia o alergia alimentaria?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => hasAllergies = true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: hasAllergies == true
                          ? const Color(0xFF537e5e)
                          : Colors.grey,
                    ),
                    child: const Text("Sí"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => hasAllergies = false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: hasAllergies == false
                          ? const Color(0xFF537e5e)
                          : Colors.white,
                    ),
                    child: const Text("No"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (hasAllergies == true)
              TextField(
                controller: _allergyController,
                decoration: const InputDecoration(
                  hintText: "Escribe tus alergias (separadas por comas)",
                  border: OutlineInputBorder(),
                ),
              ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (hasAllergies == null) return;

                  List<String> allergies = [];

                  if (hasAllergies == true) {
                    allergies = _allergyController.text
                        .split(',')
                        .map((e) => e.trim())
                        .where((e) => e.isNotEmpty)
                        .toList();
                  } else {
                    allergies = ["Ninguna"];
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DislikesScreen(
                        numeroPack: widget.numeroPack,
                        diet: widget.diet,
                        allergies: allergies,
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