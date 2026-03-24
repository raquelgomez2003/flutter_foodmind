import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static Future<void> saveDiet(String diet) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("diet", diet);
  }

  static Future<String?> getDiet() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("diet");
  }

  static Future<void> saveAllergies(List<String> allergies) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("allergies", allergies);
  }

  static Future<List<String>> getAllergies() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("allergies") ?? [];
  }

  static Future<void> saveDislikes(List<String> dislikes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("dislikes", dislikes);
  }

  static Future<List<String>> getDislikes() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("dislikes") ?? [];
  }

  static Future<void> saveInventory(List<String> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("inventory", items);
  }

  static Future<List<String>> getInventory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("inventory") ?? [];
  }

  static Future<void> setOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("onboardingCompleted", true);
  }

  static Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("onboardingCompleted") ?? false;
  }
}