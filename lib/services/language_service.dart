import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const String _languageKey = "selected_language";

  /// Save selected language
  static Future<void> saveLanguage(
    String language,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      _languageKey,
      language,
    );
  }

  /// Get saved language
  static Future<String> getLanguage() async {
    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getString(
          _languageKey,
        ) ??
        "English";
  }

  /// Check if language already selected
  static Future<bool> hasLanguage() async {
    final prefs =
        await SharedPreferences.getInstance();

    return prefs.containsKey(
      _languageKey,
    );
  }

  /// Clear language (optional)
  static Future<void> clearLanguage() async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.remove(
      _languageKey,
    );
  }
}
