import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../services/attendance_service.dart';
import '../utils/app_colors.dart';

class AttendanceDashboardScreen extends StatefulWidget {
  const AttendanceDashboardScreen({super.key});

  @override
  State<AttendanceDashboardScreen> createState() =>
      _AttendanceDashboardScreenState();
}

class _AttendanceDashboardScreenState
    extends State<AttendanceDashboardScreen> {
  final DateTime _focusedDay = DateTime.now();

  final Set<String> attendanceDates = {};

  int streak = 0;
  String lastAttendance = "--";

  @override
  void initState() {
    super.initState();
    loadAttendance();
  }

  Future<void> loadAttendance() async {
    final prefs =
        await SharedPreferences.getInstance();

    final data =
        prefs.getStringList(
              'attendance_dates',
            ) ??
            [];

    streak =
        await AttendanceService
            .getCurrentStreak();

    lastAttendance =
        await AttendanceService
            .getLastAttendanceDate();

    setState(() {
      attendanceDates.addAll(data);
    });
  }

  String dateKey(DateTime date) {
    return "${date.year}-${date.month}-${date.day}";
  }

  int get presentDays => attendanceDates.length;

  int get workingDays => 30;

  int get holidays => 2;

  int get leaves =>
      workingDays -
      holidays -
      presentDays;

  double get attendancePercent {
    return (presentDays /
            (workingDays - holidays)) *
        100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          "Attendance Dashboard",
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _card(
                    "Present",
                    presentDays.toString(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _card(
                    "Working",
                    workingDays.toString(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: _card(
                    "Leaves",
                    leaves.toString(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _card(
                    "Holidays",
                    holidays.toString(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: _card(
                    "Streak",
                    "$streak Days",
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _card(
                    "Last Mark",
                    lastAttendance,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              padding:
                  const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius:
                    BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    "Attendance %",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "${attendancePercent.toStringAsFixed(1)}%",
                    style:
                        const TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius:
                    BorderRadius.circular(16),
              ),
              child: const Text(
                "Tap dates with ✓ to view attendance records",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 16),

            TableCalendar(
              firstDay: DateTime(2024),
              lastDay: DateTime(2035),
              focusedDay: _focusedDay,
              calendarBuilders:
                  CalendarBuilders(
                markerBuilder:
                    (context, day, events) {
                  if (attendanceDates
                      .contains(
                    dateKey(day),
                  )) {
                    return const Align(
                      alignment:
                          Alignment.bottomCenter,
                      child: Icon(
                        Icons.check_circle,
                        color:
                            Colors.green,
                        size: 18,
                      ),
                    );
                  }

                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(
    String title,
    String value,
  ) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Text(title),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
