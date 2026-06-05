import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';
import 'language_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,

      body: SafeArea(
        child: GestureDetector(
          onHorizontalDragEnd: (_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const LanguageScreen(),
              ),
            );
          },

          child: Column(
            children: [

              const Spacer(),

              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: kPrimary.withValues(alpha: 0.15),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.construction_rounded,
                  size: 75,
                  color: kPrimary,
                ),
              ),

              const SizedBox(height: 30),

              Text(
                "Saksham Attendance",
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight:
                      FontWeight.w700,
                  color: kPrimary,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Offline Attendance Made Easy",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: kTextSecondary,
                  fontWeight:
                      FontWeight.w500,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "आसान ऑफलाइन उपस्थिति",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: kTextSecondary,
                ),
              ),

              const SizedBox(height: 40),

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryLight,
                  borderRadius:
                      BorderRadius.circular(
                    30,
                  ),
                ),
                child: Row(
                  mainAxisSize:
                      MainAxisSize.min,
                  children: [

                    const Icon(
                      Icons.swipe,
                      color: kPrimary,
                    ),

                    const SizedBox(width: 10),

                    Text(
                      "Swipe To Continue",
                      style:
                          GoogleFonts.poppins(
                        color: kPrimary,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              Container(
                margin:
                    const EdgeInsets.only(
                  bottom: 25,
                ),
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                    30,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withValues(alpha: 0.04),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize:
                      MainAxisSize.min,
                  children: [

                    const Icon(
                      Icons.verified_user,
                      color: kPrimary,
                    ),

                    const SizedBox(width: 8),

                    Text(
                      "Trusted by Workers",
                      style:
                          GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight:
                            FontWeight.w500,
                      ),
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
