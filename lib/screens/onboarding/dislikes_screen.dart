import 'package:flutter/material.dart';
import '../../widgets/primary_button.dart';
import 'initial_stock_screen.dart';

class DislikesScreen extends StatefulWidget {
  final String numeroPack;
  final String diet;
  final List<String> allergies;

  const DislikesScreen({
    super.key,
    required this.numeroPack,
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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void anadirProducto() {
    if (controller.text.trim().isNotEmpty) {
      setState(() {
        dislikes.add(controller.text.trim());
        controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const verde = Color(0xFF527d5a);
    const beige = Color(0xFFd2b08b);
    const crema = Color(0xFFe9ddd4);
    const mostaza = Color(0xFFf1b810);
    const marron = Color(0xFF9d5d31);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F2),
      appBar: AppBar(
        title: const Text(
          'Preferencias',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: verde,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: verde),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // ICONO
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 92,
                    height: 92,
                    decoration: BoxDecoration(
                      color: crema,
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 0,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: mostaza,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 6,
                    left: 2,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: const BoxDecoration(
                        color: beige,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.thumb_down_alt_rounded,
                    size: 42,
                    color: verde,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // TITULO
              const Text(
                '¿Qué no te gusta?',
                style: TextStyle(
                  fontFamily: 'MoreSugar',
                  fontSize: 24,
                  color: verde,
                ),
              ),

              const SizedBox(height: 12),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Añade alimentos que prefieres evitar para mejorar tus recomendaciones.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    color: Color(0xFF6A6A6A),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // CARD
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: crema,
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // INPUT
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                hintText: 'Ej. brócoli, coco...',
                                filled: true,
                                fillColor: crema.withOpacity(0.55),
                                prefixIcon: const Icon(
                                  Icons.add,
                                  color: verde,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                    color: verde,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: verde,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.add, color: Colors.white),
                              onPressed: anadirProducto,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // LISTA
                      Expanded(
                        child: dislikes.isEmpty
                            ? const Center(
                                child: Text(
                                  'Aún no has añadido nada',
                                  style: TextStyle(
                                    color: Color(0xFF8A8A8A),
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: dislikes.length,
                                itemBuilder: (context, index) {
                                  final item = dislikes[index];

                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: crema.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(
                                                () => dislikes.remove(item));
                                          },
                                          child: const Icon(
                                            Icons.close,
                                            size: 18,
                                            color: marron,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ),

                      const SizedBox(height: 10),

                      // INFO
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: mostaza.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 18,
                              color: marron,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Esto nos ayuda a personalizar mejor tus recetas.',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: marron,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // BOTON
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  text: 'Continuar',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => InitialStockScreen(
                          numeroPack: widget.numeroPack,
                          diet: widget.diet,
                          allergies: widget.allergies,
                          dislikes: dislikes,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}