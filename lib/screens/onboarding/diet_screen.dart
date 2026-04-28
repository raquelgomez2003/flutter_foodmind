import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/primary_button.dart';
import 'allergies_screen.dart';

class DietScreen extends StatefulWidget {
  final String numeroPack;
  final bool editingFromSettings;

  const DietScreen({
    super.key,
    required this.numeroPack,
    this.editingFromSettings = false,
  });

  @override
  State<DietScreen> createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
  final TextEditingController _dietController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cargarDietaGuardada();
  }

  Future<void> cargarDietaGuardada() async {
    final prefs = await SharedPreferences.getInstance();
    _dietController.text = prefs.getString('dieta_usuario') ?? '';
  }

  Future<void> guardarDieta(String dieta) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('dieta_usuario', dieta);
  }

  @override
  Widget build(BuildContext context) {
    const verde = Color(0xFF527d5a);
    const crema = Color(0xFFe9ddd4);
    const beige = Color(0xFFd2b08b);
    const mostaza = Color(0xFFf1b810);
    const marron = Color(0xFF9d5d31);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F2),
      appBar: AppBar(
        title: const Text(
          'Tu dieta',
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
                  const Icon(Icons.eco_rounded, size: 42, color: verde),
                ],
              ),

              const SizedBox(height: 24),

              const Text(
                'Cuéntanos tu dieta',
                style: TextStyle(
                  fontFamily: 'MoreSugar',
                  fontSize: 26,
                  color: verde,
                ),
              ),

              const SizedBox(height: 12),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Escribe el tipo de alimentación que sigues para adaptar mejor tu experiencia.',
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
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: crema, width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.restaurant_menu_rounded,
                            size: 18, color: marron),
                        SizedBox(width: 8),
                        Text(
                          'Tipo de dieta',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: verde,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: _dietController,
                      decoration: InputDecoration(
                        hintText: 'Ej. vegetariana, vegana, omnívora...',
                        hintStyle: const TextStyle(color: Color(0xFF8E857D)),
                        filled: true,
                        fillColor: crema.withOpacity(0.55),
                        prefixIcon:
                            const Icon(Icons.spa_rounded, color: verde),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: verde, width: 1.5),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ADVERTENCIA
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: mostaza.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline,
                              size: 18, color: marron),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Puedes indicar cualquier tipo de dieta o estilo de alimentación.',
                              style: TextStyle(
                                fontSize: 13,
                                color: marron,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        text: 'Continuar',
                        onPressed: () async {
                          final dieta = _dietController.text.trim();
                          if (dieta.isEmpty) return;

                          await guardarDieta(dieta);

                          if (widget.editingFromSettings) {
                            Navigator.pop(context);
                            return;
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AllergiesScreen(
                                numeroPack: widget.numeroPack,
                                diet: dieta,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Podrás modificar esta información más adelante.',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF8A8A8A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
