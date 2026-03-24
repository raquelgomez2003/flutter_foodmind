import 'package:flutter/material.dart';
import 'initial_stock_screen.dart';

class DislikesScreen extends StatefulWidget {
  final String diet;
  final List<String> allergies;

  const DislikesScreen({
    super.key,
    required this.diet,
    required this.allergies,
  });

  @override
  State<DislikesScreen> createState() => _DislikesScreenState();
}

class _DislikesScreenState extends State<DislikesScreen> {
  final TextEditingController controller = TextEditingController();
  final List<String> dislikes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Productos que no te gustan")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "Añadir producto",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      setState(() {
                        dislikes.add(controller.text);
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
              children: dislikes
                  .map((d) => ListTile(
                        title: Text(d),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() => dislikes.remove(d));
                          },
                        ),
                      ))
                  .toList(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => InitialStockScreen(
                    diet: widget.diet,
                    allergies: widget.allergies,
                    dislikes: dislikes,
                  ),
                ),
              );
            },
            child: const Text("Continuar"),
          ),
        ],
      ),
    );
  }
}