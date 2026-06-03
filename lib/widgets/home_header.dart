import 'package:flutter/material.dart';

import '../services/language_service.dart';
import '../utils/app_colors.dart';

class HomeHeader extends StatefulWidget {
  final VoidCallback? onLanguageChanged;

  const HomeHeader({
    super.key,
    this.onLanguageChanged,
  });

  @override
  State<HomeHeader> createState() =>
      _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
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

  Future<void> changeLanguage() async {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading:
                  const Icon(Icons.language),
              title:
                  const Text("English"),
              onTap: () async {
                await LanguageService
                    .saveLanguage(
                  "English",
                );

                setState(() {
                  language = "English";
                });

                widget.onLanguageChanged?.call();

                if (mounted) {
                  Navigator.pop(context);
                }
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.language),
              title:
                  const Text("हिन्दी"),
              onTap: () async {
                await LanguageService
                    .saveLanguage(
                  "Hindi",
                );

                setState(() {
                  language = "Hindi";
                });

                widget.onLanguageChanged?.call();

                if (mounted) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.menu,
            color: AppColors.primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              language == "Hindi"
                  ? "सक्षम उपस्थिति"
                  : "Saksham Attendance",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          TextButton(
            onPressed: changeLanguage,
            child: Text(
              language == "Hindi"
                  ? "हिन्दी"
                  : "EN",
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
