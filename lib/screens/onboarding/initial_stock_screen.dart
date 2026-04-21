import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../home/home_screen.dart';

class InitialStockScreen extends StatefulWidget {
  final String numeroPack;
  final String diet;
  final List<String> allergies;
  final List<String> dislikes;

  const InitialStockScreen({
    super.key,
    required this.numeroPack,
    required this.diet,
    required this.allergies,
    required this.dislikes,
  });

  @override
  State<InitialStockScreen> createState() => _InitialStockScreenState();
}

class _InitialStockScreenState extends State<InitialStockScreen> {
  final TextEditingController controller = TextEditingController();
  final List<String> initialStock = [];
  bool cargando = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> guardarUsuario() async {
    setState(() {
      cargando = true;
    });

    try {
      final response = await http.post(
        Uri.parse(
            'https://yost.es/SM-IT/2025-26/1B/website/mvp/guardar_usuario.php'),
        body: {
          'numero_pack': widget.numeroPack,
          'tipo_dieta': widget.diet,
          'alergias': widget.allergies.join(','),
          'no_gustan': widget.dislikes.join(','),
        },
      );

      final data = jsonDecode(response.body);

      if (data['ok'] == true) {
        final prefs = await SharedPreferences.getInstance();

        await prefs.setBool('onboarding_completado', true);
        await prefs.setInt(
            'usuario_id', int.parse(data['usuario_id'].toString()));
        await prefs.setString('numero_pack', widget.numeroPack);

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(data['error'] ?? 'Error al guardar usuario')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de red: $e')),
      );
    } finally {
      if (!mounted) return;
      setState(() {
        cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("¿Qué tienes en casa?"),
        backgroundColor: const Color(0xFF537e5e),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "Añadir alimento",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (controller.text.trim().isNotEmpty) {
                      setState(() {
                        initialStock.add(controller.text.trim());
                        controller.clear();
                      });
                    }
                  },
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView(
              children: initialStock
                  .map(
                    (item) => ListTile(
                      title: Text(item),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() => initialStock.remove(item));
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: cargando ? null : guardarUsuario,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF537e5e),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: cargando
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Finalizar",
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}