import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SloganTicker extends StatefulWidget {
  const SloganTicker({super.key});

  @override
  State<SloganTicker> createState() => _SloganTickerState();
}

class _SloganTickerState extends State<SloganTicker> {
  final List<String> slogans = [
    '🏗️ मजदूर की मेहनत, देश की ताकत',
    '✅ Har Din Haazri, Har Din Tarakki',
    '💪 Shramik Ka Samman, Rashtra Ka Maan',
    '⏰ Samay Par Aao, Aage Badho',
    '🌟 Attendance Today, Success Tomorrow',
    '🇮🇳 Apna Kaam, Apni Pehchaan',
  ];

  int currentIndex = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        if (mounted) {
          setState(() {
            currentIndex =
                (currentIndex + 1) % slogans.length;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Text(
            slogans[currentIndex],
            key: ValueKey(currentIndex),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
