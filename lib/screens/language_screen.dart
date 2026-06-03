import 'package:flutter/material.dart';

import '../services/language_service.dart';
import '../utils/app_colors.dart';
import 'home_screen.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  Future<void> selectLanguage(
    BuildContext context,
    String language,
  ) async {
    await LanguageService.saveLanguage(
      language,
    );

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.background,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.language,
                size: 100,
                color:
                    AppColors.primary,
              ),

              const SizedBox(height: 30),

              const Text(
                "Choose Language",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width:
                    double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    selectLanguage(
                      context,
                      "English",
                    );
                  },
                  child: const Text(
                    "English",
                  ),
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width:
                    double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    selectLanguage(
                      context,
                      "Hindi",
                    );
                  },
                  child: const Text(
                    "हिन्दी",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
