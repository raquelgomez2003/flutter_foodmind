import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String endpoint =
      "https://yost.es/website/mvp/despensa_prueba.php";

  static Future<bool> sendInventory(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(endpoint),
      body: {
        "action": "update_inventory",
        "data": jsonEncode(data),
      },
    );

    return response.statusCode == 200;
  }
}