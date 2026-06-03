import 'package:flutter/material.dart';

import '../services/attendance_service.dart';

class SyncStatusCard extends StatefulWidget {
  const SyncStatusCard({super.key});

  @override
  State<SyncStatusCard> createState() =>
      _SyncStatusCardState();
}

class _SyncStatusCardState
    extends State<SyncStatusCard> {
  int attendanceCount = 0;
  String lastTime = "--";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    attendanceCount =
        await AttendanceService
            .getAttendanceCount();

    lastTime =
        await AttendanceService
            .getLastAttendanceTime();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const Text(
                "Records",
              ),
              const SizedBox(height: 6),
              Text(
                attendanceCount
                    .toString(),
                style:
                    const TextStyle(
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Text(
                "Last Marked",
              ),
              const SizedBox(height: 6),
              Text(
                lastTime,
                style:
                    const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
