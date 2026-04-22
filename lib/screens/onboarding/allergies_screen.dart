import 'package:flutter/material.dart';
import '../../widgets/primary_button.dart';
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
    const verde = Color(0xFF527d5a);
    const beige = Color(0xFFd2b08b);
    const crema = Color(0xFFe9ddd4);
    const mostaza = Color(0xFFf1b810);
    const marron = Color(0xFF9d5d31);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F2),
      appBar: AppBar(
        title: const Text(
          'Alergias',
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
                    Icons.health_and_safety_rounded,
                    size: 42,
                    color: verde,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Cuéntanos tus alergias',
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
                  'Indícanos si tienes alguna intolerancia o alergia alimentaria para adaptar mejor tus recomendaciones.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    color: Color(0xFF6A6A6A),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.medical_information_outlined,
                          size: 18,
                          color: marron,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '¿Tienes alguna intolerancia o alergia alimentaria?',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: verde,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => hasAllergies = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: hasAllergies == true
                                    ? verde
                                    : crema.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: hasAllergies == true
                                      ? verde
                                      : crema,
                                ),
                              ),
                              child: Text(
                                'Sí',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: hasAllergies == true
                                      ? Colors.white
                                      : verde,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => hasAllergies = false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: hasAllergies == false
                                    ? verde
                                    : crema.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: hasAllergies == false
                                      ? verde
                                      : crema,
                                ),
                              ),
                              child: Text(
                                'No',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: hasAllergies == false
                                      ? Colors.white
                                      : verde,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (hasAllergies == true) ...[
                      const SizedBox(height: 16),
                      TextField(
                        controller: _allergyController,
                        decoration: InputDecoration(
                          hintText: 'Ej. lactosa, gluten, frutos secos...',
                          hintStyle: const TextStyle(
                            color: Color(0xFF8E857D),
                          ),
                          filled: true,
                          fillColor: crema.withOpacity(0.55),
                          prefixIcon: const Icon(
                            Icons.edit_note_rounded,
                            color: verde,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
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
                    ],
                    const SizedBox(height: 12),
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
                              'Si tienes varias, sepáralas con comas.',
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
                            allergies = ['Ninguna'];
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
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Podrás cambiar esta información más adelante.',
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