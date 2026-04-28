import 'package:flutter/material.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recetas"),
        backgroundColor: const Color(0xFF537e5e),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF537e5e),
        onPressed: () {
          // Aquí luego abrirás cámara / IA
          print("Abrir IA");
        },
        child: const Icon(Icons.camera_alt),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            
            SizedBox(height: 10),

            Text(
              "Recomendaciones diarias",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 15),

            Text(
              "Esta sección ofrece recetas diarias generadas mediante "
              "inteligencia artificial.\n\n"
              "Podrás descubrir platos en función de tus ingredientes o "
              "subiendo una imagen desde tu dispositivo.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 30),

            Center(
              child: Text(
                "Las recetas aparecerán aquí",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}