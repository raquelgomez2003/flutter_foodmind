import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController marcaController = TextEditingController();
  final TextEditingController cantidadController =
      TextEditingController(text: '1');

  bool cargando = false;

  @override
  void dispose() {
    nombreController.dispose();
    marcaController.dispose();
    cantidadController.dispose();
    super.dispose();
  }

  Future<void> guardarProducto() async {
    if (nombreController.text.trim().isEmpty ||
        cantidadController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Completa al menos nombre y cantidad"),
        ),
      );
      return;
    }

    setState(() {
      cargando = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final usuarioId = prefs.getInt('usuario_id');

      if (usuarioId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No se encontró el usuario actual"),
          ),
        );
        setState(() {
          cargando = false;
        });
        return;
      }

      final response = await http.post(
        Uri.parse(
          'https://yost.es/SM-IT/2025-26/1B/website/mvp/insertar_despensa.php',
        ),
        body: {
          "usuario_id": usuarioId.toString(),
          "codigo": "",
          "nombre": nombreController.text.trim(),
          "marca": marcaController.text.trim(),
          "ingredientes": "",
          "calorias": "0",
          "cantidad": cantidadController.text.trim(),
          "ultima_accion": "1",
          "favorito": "0",
        },
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      final data = jsonDecode(response.body);

      setState(() {
        cargando = false;
      });

      if (data["ok"] == true) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Error al guardar producto: ${data["error"] ?? "desconocido"}",
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        cargando = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error de red: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Añadir producto")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),
            TextField(
              controller: marcaController,
              decoration: const InputDecoration(labelText: "Marca"),
            ),
            TextField(
              controller: cantidadController,
              decoration: const InputDecoration(labelText: "Cantidad"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            cargando
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: guardarProducto,
                    child: const Text("Guardar"),
                  ),
          ],
        ),
      ),
    );
  }
}