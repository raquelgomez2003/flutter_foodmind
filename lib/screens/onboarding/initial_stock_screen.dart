import 'package:flutter/material.dart';
import '../home/home_screen.dart';

class InitialStockScreen extends StatefulWidget {
  final String diet;
  final List<String> allergies;
  final List<String> dislikes;

  const InitialStockScreen({
    super.key,
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
                    if (controller.text.isNotEmpty) {
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
                onPressed: () async {
                  // Aquí guardarás los datos en SharedPreferences o Hive
                  // Por ahora solo navegamos a HomeScreen

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen()
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF537e5e),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
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