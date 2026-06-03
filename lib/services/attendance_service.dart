import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AttendanceService {
  static Future<void> saveAttendance() async {
    final prefs =
        await SharedPreferences.getInstance();

    final records =
        prefs.getStringList(
              'attendance_records',
            ) ??
            [];

    final now = DateTime.now();

    final record =
        jsonEncode({
          "date":
              "${now.day}/${now.month}/${now.year}",
          "time":
              "${now.hour}:${now.minute}",
          "status": "Verified",
        });

    records.insert(0, record);

    await prefs.setStringList(
      'attendance_records',
      records,
    );

    // For Status Card
    final today =
        "${now.year}-${now.month}-${now.day}";

    final dates =
        prefs.getStringList(
              'attendance_dates',
            ) ??
            [];

    if (!dates.contains(today)) {
      dates.add(today);

      await prefs.setStringList(
        'attendance_dates',
        dates,
      );
    }
  }

  static Future<List<Map<String, dynamic>>>
      getAttendanceRecords() async {
    final prefs =
        await SharedPreferences.getInstance();

    final records =
        prefs.getStringList(
              'attendance_records',
            ) ??
            [];

    return records
        .map(
          (e) =>
              jsonDecode(e)
                  as Map<String, dynamic>,
        )
        .toList();
  }

  static Future<int> getAttendanceCount() async {
    final records =
        await getAttendanceRecords();

    return records.length;
  }

  static Future<String> getLastAttendanceTime() async {
    final records =
        await getAttendanceRecords();

    if (records.isEmpty) {
      return "--";
    }

    return records.first["time"] ?? "--";
  }

  static Future<int> getCurrentStreak() async {
    final prefs =
        await SharedPreferences.getInstance();

    final dates =
        prefs.getStringList(
              'attendance_dates',
            ) ??
            [];

    int streak = 0;

    DateTime current =
        DateTime.now();

    while (true) {
      final key =
          "${current.year}-${current.month}-${current.day}";

      if (dates.contains(key)) {
        streak++;
        current =
            current.subtract(
          const Duration(days: 1),
        );
      } else {
        break;
      }
    }

    return streak;
  }

  static Future<String> getLastAttendanceDate() async {
    final prefs =
        await SharedPreferences.getInstance();

    final dates =
        prefs.getStringList(
              'attendance_dates',
            ) ??
            [];

    if (dates.isEmpty) {
      return "--";
    }

    return dates.last;
  }
}
