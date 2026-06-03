import 'package:flutter/material.dart';

import '../services/language_service.dart';

class ReminderCard extends StatefulWidget {
  const ReminderCard({super.key});

  @override
  State<ReminderCard> createState() =>
      _ReminderCardState();
}

class _ReminderCardState
    extends State<ReminderCard> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3CD),
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              language == "Hindi"
                  ? "शिफ्ट शुरू होने से पहले उपस्थिति दर्ज करना न भूलें।"
                  : "Remember to mark attendance before shift starts.",
            ),
          ),
        ],
      ),
    );
  }
}
