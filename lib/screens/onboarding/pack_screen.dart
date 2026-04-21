import 'package:flutter/material.dart';
import '../../widgets/primary_button.dart';
import 'diet_screen.dart';

class PackScreen extends StatefulWidget {
  const PackScreen({super.key});

  @override
  State<PackScreen> createState() => _PackScreenState();
}

class _PackScreenState extends State<PackScreen> {
  final TextEditingController numeroPackController = TextEditingController();

  @override
  void dispose() {
    numeroPackController.dispose();
    super.dispose();
  }

  void continuar() {
    if (numeroPackController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Introduce el número de pack')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DietScreen(
          numeroPack: numeroPackController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu dispositivo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Introduce el número de tu lector',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: numeroPackController,
              decoration: const InputDecoration(
                labelText: 'Número de pack',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            PrimaryButton(
              text: 'Continuar',
              onPressed: continuar,
            ),
          ],
        ),
      ),
    );
  }
}