import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/language_service.dart';
import '../utils/app_colors.dart';

class StatusCard extends StatefulWidget {
  const StatusCard({super.key});

  @override
  State<StatusCard> createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> {
  bool isMarked = false;
  String language = "English";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    language = await LanguageService.getLanguage();

    final dates =
        prefs.getStringList('attendance_dates') ?? [];

    final today =
        "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";

    if (mounted) {
      setState(() {
        isMarked = dates.contains(today);
      });
    }
  }

  String getFormattedDate() {
    final now = DateTime.now();

    if (language == "Hindi") {
      const months = [
        "",
        "जनवरी",
        "फरवरी",
        "मार्च",
        "अप्रैल",
        "मई",
        "जून",
        "जुलाई",
        "अगस्त",
        "सितंबर",
        "अक्टूबर",
        "नवंबर",
        "दिसंबर"
      ];

      const days = [
        "",
        "सोमवार",
        "मंगलवार",
        "बुधवार",
        "गुरुवार",
        "शुक्रवार",
        "शनिवार",
        "रविवार"
      ];

      return "${days[now.weekday]}, ${now.day} ${months[now.month]} ${now.year}";
    }

    const months = [
      "",
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];

    const days = [
      "",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];

    return "${days[now.weekday]}, ${now.day} ${months[now.month]} ${now.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  language == "Hindi"
                      ? "वर्तमान स्थिति"
                      : "CURRENT STATUS",
                  style: const TextStyle(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  isMarked
                      ? (language == "Hindi"
                          ? "उपस्थिति दर्ज"
                          : "Attendance Marked")
                      : (language == "Hindi"
                          ? "उपस्थिति नहीं"
                          : "Not Marked Yet"),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  getFormattedDate(),
                  style: const TextStyle(
                    fontWeight:
                        FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  isMarked
                      ? (language == "Hindi"
                          ? "आज की उपस्थिति सफलतापूर्वक दर्ज की गई।"
                          : "Today's attendance has been marked successfully.")
                      : (language == "Hindi"
                          ? "आज की उपस्थिति अभी दर्ज नहीं हुई है।"
                          : "Today's attendance has not been marked."),
                ),
              ],
            ),
          ),

          CircleAvatar(
            radius: 30,
            backgroundColor: isMarked
                ? Colors.green.shade100
                : Colors.red.shade100,
            child: Icon(
              isMarked
                  ? Icons.check_circle
                  : Icons.cancel,
              color: isMarked
                  ? Colors.green
                  : Colors.red,
              size: 34,
            ),
          ),
        ],
      ),
    );
  }
}
