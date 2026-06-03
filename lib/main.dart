import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';
import 'utils/app_colors.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Saksham Attendance',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor:
            AppColors.background,
      ),
      home: const SplashScreen(),
    );
  }
}
