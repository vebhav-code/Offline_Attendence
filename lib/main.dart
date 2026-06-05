import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/splash_screen.dart';
import 'screens/language_screen.dart';
import 'screens/home_screen.dart';
import 'screens/members_screen.dart';
import 'screens/add_member_screen.dart'; 
import 'screens/attendance_camera_screen.dart'; // Added import for the camera screen
import 'utils/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SakshamAttendanceApp());
}

class SakshamAttendanceApp extends StatelessWidget {
  const SakshamAttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saksham Attendance',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        primaryColor: kPrimary,
        scaffoldBackgroundColor: kBackground,

        colorScheme: ColorScheme.fromSeed(
          seedColor: kPrimary,
        ),

        textTheme: GoogleFonts.poppinsTextTheme(),

        appBarTheme: AppBarTheme(
          backgroundColor: kPrimary,
          foregroundColor: Colors.white,
          centerTitle: true,
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => const SplashScreen(),
        '/language': (context) => const LanguageScreen(),
        '/home': (context) => const HomeScreen(),
        '/members': (context) => const MembersScreen(),
        '/add-member': (context) => const AddMemberScreen(), 
        '/attendance-camera': (context) => const AttendanceCameraScreen(), // Added the new route here
      },
    );
  }
}
