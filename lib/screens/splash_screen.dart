import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'language_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LanguageScreen(),
              ),
            );
          },
          child: Column(
            children: [
              const Spacer(),

              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.verified,
                  size: 70,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Saksham Attendance",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Offline Attendance Made Easy",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textLight,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "आसान ऑफलाइन उपस्थिति",
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.textLight,
                ),
              ),

              const SizedBox(height: 40),

              const Icon(
                Icons.swipe,
                size: 32,
                color: AppColors.primary,
              ),

              const SizedBox(height: 10),

              const Text(
                "Swipe to Continue",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textLight,
                ),
              ),

              const Spacer(),

              Container(
                margin: const EdgeInsets.only(
                  bottom: 30,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.shield,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Trusted by thousands of workers",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
