import 'dart:io';

import 'package:flutter/material.dart';

import '../services/attendance_service.dart';
import '../services/language_service.dart';
import '../utils/app_colors.dart';

class FaceVerificationScreen extends StatefulWidget {
  final String imagePath;

  const FaceVerificationScreen({
    super.key,
    required this.imagePath,
  });

  @override
  State<FaceVerificationScreen> createState() =>
      _FaceVerificationScreenState();
}

class _FaceVerificationScreenState
    extends State<FaceVerificationScreen> {
  bool faceDetected = true;
  bool livelinessCheck = true;
  bool identityMatch = true;

  String language = "English";

  @override
  void initState() {
    super.initState();
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    language =
        await LanguageService.getLanguage();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> verifyAttendance() async {
    await AttendanceService.saveAttendance();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          language == "Hindi"
              ? "उपस्थिति सफलतापूर्वक दर्ज हुई"
              : "Attendance Verified Successfully",
        ),
      ),
    );

    Navigator.popUntil(
      context,
      (route) => route.isFirst,
    );
  }

  Widget statusTile(
    String title,
    bool status,
  ) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            status
                ? Icons.check_circle
                : Icons.cancel,
            color: status
                ? Colors.green
                : Colors.red,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.background,
      appBar: AppBar(
        title: Text(
          language == "Hindi"
              ? "चेहरा सत्यापन"
              : "Face Verification",
        ),
        backgroundColor:
            AppColors.primary,
        foregroundColor:
            Colors.white,
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(
                  20,
                ),
              ),
              clipBehavior:
                  Clip.antiAlias,
              child: Image.file(
                File(
                  widget.imagePath,
                ),
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 24),

            statusTile(
              language == "Hindi"
                  ? "चेहरा मिला"
                  : "Face Detected",
              faceDetected,
            ),

            statusTile(
              language == "Hindi"
                  ? "लाइवनेस जांच"
                  : "Liveliness Check",
              livelinessCheck,
            ),

            statusTile(
              language == "Hindi"
                  ? "पहचान सत्यापित"
                  : "Identity Match",
              identityMatch,
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed:
                    verifyAttendance,
                icon: const Icon(
                  Icons.verified,
                ),
                label: Text(
                  language == "Hindi"
                      ? "उपस्थिति सत्यापित करें"
                      : "Verify Attendance",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
