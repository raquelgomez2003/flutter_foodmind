import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../widgets/product_card.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> mockProducts = [
      Product(
        name: "Leche",
        quantity: 2,
        expirationDate: "2026-03-20",
        barcode: "123456",
      ),
      Product(
        name: "Huevos",
        quantity: 12,
        expirationDate: "2026-03-18",
        barcode: "789012",
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Inventario")),
      body: ListView(
        children: mockProducts.map((p) => ProductCard(product: p)).toList(),
      ),
    );
  }
}