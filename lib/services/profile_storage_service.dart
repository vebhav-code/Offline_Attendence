import 'package:shared_preferences/shared_preferences.dart';

class ProfileStorageService {
  static Future<void> saveProfile({
    required String workerId,
    required String name,
    required String phone,
    required String department,
    required String site,
    String? imagePath,
  }) async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      "workerId",
      workerId,
    );

    await prefs.setString(
      "name",
      name,
    );

    await prefs.setString(
      "phone",
      phone,
    );

    await prefs.setString(
      "department",
      department,
    );

    await prefs.setString(
      "site",
      site,
    );

    if (imagePath != null) {
      await prefs.setString(
        "imagePath",
        imagePath,
      );
    }
  }

  static Future<Map<String, String>>
      getProfile() async {
    final prefs =
        await SharedPreferences.getInstance();

    return {
      "workerId":
          prefs.getString(
            "workerId",
          ) ??
          "EMP-8829-24",

      "name":
          prefs.getString(
            "name",
          ) ??
          "Ayush Gupta",

      "phone":
          prefs.getString(
            "phone",
          ) ??
          "+91 9876543210",

      "department":
          prefs.getString(
            "department",
          ) ??
          "Construction",

      "site":
          prefs.getString(
            "site",
          ) ??
          "Site A",

      "imagePath":
          prefs.getString(
            "imagePath",
          ) ??
          "",
    };
  }
}
