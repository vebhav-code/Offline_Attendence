import 'package:flutter/material.dart';

import '../services/attendance_service.dart';
import '../utils/app_colors.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() =>
      _HistoryScreenState();
}

class _HistoryScreenState
    extends State<HistoryScreen> {
  List<Map<String, dynamic>>
      records = [];

  @override
  void initState() {
    super.initState();
    loadRecords();
  }

  Future<void> loadRecords() async {
    final data =
        await AttendanceService
            .getAttendanceRecords();

    if (mounted) {
      setState(() {
        records = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.background,
      appBar: AppBar(
        title: const Text(
          "Attendance History",
        ),
        backgroundColor:
            AppColors.primary,
        foregroundColor:
            Colors.white,
      ),
      body: records.isEmpty
          ? const Center(
              child: Text(
                "No attendance records found",
              ),
            )
          : ListView(
              padding:
                  const EdgeInsets.all(
                16,
              ),
              children: [
                Container(
                  padding:
                      const EdgeInsets.all(
                    20,
                  ),
                  decoration:
                      BoxDecoration(
                    color:
                        Colors.white,
                    borderRadius:
                        BorderRadius.circular(
                      18,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Total Attendance",
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        records.length
                            .toString(),
                        style:
                            const TextStyle(
                          fontSize: 32,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                const Align(
                  alignment:
                      Alignment.centerLeft,
                  child: Text(
                    "Attendance Logs",
                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                ...records.map(
                  (record) {
                    return Card(
                      child: ListTile(
                        leading:
                            const CircleAvatar(
                          backgroundColor:
                              Colors.green,
                          child: Icon(
                            Icons.check,
                            color:
                                Colors.white,
                          ),
                        ),
                        title: Text(
                          record["date"] ??
                              "",
                        ),
                        subtitle: Text(
                          record["time"] ??
                              "",
                        ),
                        trailing: Text(
                          record["status"] ??
                              "",
                          style:
                              const TextStyle(
                            color:
                                Colors.green,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}
