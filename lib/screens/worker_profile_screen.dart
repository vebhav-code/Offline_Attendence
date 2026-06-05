import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/worker_model.dart';
import '../utils/app_colors.dart';

class WorkerProfileScreen extends StatefulWidget {
  final WorkerModel worker;

  const WorkerProfileScreen({
    super.key,
    required this.worker,
  });

  @override
  State<WorkerProfileScreen> createState() =>
      _WorkerProfileScreenState();
}

class _WorkerProfileScreenState
    extends State<WorkerProfileScreen> {
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();

  final List<int> holidays = [
    7,
    14,
    21,
    28,
  ];

  bool isHoliday(DateTime day) {
    return holidays.contains(day.day);
  }

  @override
  Widget build(BuildContext context) {
    final worker = widget.worker;

    return Scaffold(
      backgroundColor: kBackground,

      appBar: AppBar(
        title: Text(
          worker.name,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            buildProfileCard(worker),

            const SizedBox(height: 20),

            buildSummaryCard(),

            const SizedBox(height: 20),

            buildCalendarCard(),
          ],
        ),
      ),
    );
  }

  Widget buildProfileCard(
    WorkerModel worker,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Column(
        children: [

          CircleAvatar(
            radius: 55,
            backgroundColor:
                kPrimaryLight,
            backgroundImage:
                worker.photos.isNotEmpty
                    ? FileImage(
                        File(
                          worker.photos.first,
                        ),
                      )
                    : null,
            child:
                worker.photos.isEmpty
                    ? const Icon(
                        Icons.person,
                        size: 60,
                      )
                    : null,
          ),

          const SizedBox(height: 16),

          Text(
            worker.name,
            style:
                GoogleFonts.poppins(
              fontSize: 22,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            worker.employeeId,
            style:
                GoogleFonts.poppins(
              color: Colors.grey,
            ),
          ),

          const Divider(height: 30),

          infoRow(
            Icons.phone,
            "Phone",
            worker.phone,
          ),

          const SizedBox(height: 12),

          infoRow(
            Icons.work,
            "Department",
            worker.department,
          ),

          const SizedBox(height: 12),

          infoRow(
            Icons.cake,
            "Age",
            worker.age.toString(),
          ),
        ],
      ),
    );
  }

  Widget infoRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      children: [

        Icon(
          icon,
          color: kPrimary,
        ),

        const SizedBox(width: 10),

        Text(
          "$title : ",
          style:
              GoogleFonts.poppins(
            fontWeight:
                FontWeight.w600,
          ),
        ),

        Expanded(
          child: Text(
            value,
            style:
                GoogleFonts.poppins(),
          ),
        ),
      ],
    );
  }

  Widget buildSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Column(
        children: [

          Text(
            "Attendance Summary",
            style:
                GoogleFonts.poppins(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [

              Expanded(
                child: summaryBox(
                  "Present",
                  "0",
                  Colors.green,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: summaryBox(
                  "Absent",
                  "0",
                  Colors.red,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Container(
            padding:
                const EdgeInsets.all(
              12,
            ),
            decoration:
                BoxDecoration(
              color: kPrimaryLight,
              borderRadius:
                  BorderRadius
                      .circular(
                15,
              ),
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
              children: [

                Text(
                  "Attendance %",
                  style:
                      GoogleFonts
                          .poppins(
                    fontWeight:
                        FontWeight
                            .w600,
                  ),
                ),

                Text(
                  "0%",
                  style:
                      GoogleFonts
                          .poppins(
                    color:
                        kPrimary,
                    fontWeight:
                        FontWeight
                            .bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget summaryBox(
    String title,
    String value,
    Color color,
  ) {
    return Container(
      padding:
          const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            color.withValues(
          alpha: 0.1,
        ),
        borderRadius:
            BorderRadius.circular(
          15,
        ),
      ),
      child: Column(
        children: [

          Text(
            value,
            style:
                GoogleFonts.poppins(
              fontSize: 28,
              color: color,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          Text(
            title,
            style:
                GoogleFonts.poppins(),
          ),
        ],
      ),
    );
  }

  Widget buildCalendarCard() {
    return Container(
      padding:
          const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
          20,
        ),
      ),
      child: TableCalendar(
        firstDay:
            DateTime.utc(2025, 1, 1),
        lastDay:
            DateTime.utc(2035, 12, 31),
        focusedDay: focusedDay,

        selectedDayPredicate:
            (day) =>
                isSameDay(
          selectedDay,
          day,
        ),

        onDaySelected:
            (selected, focused) {
          setState(() {
            selectedDay =
                selected;
            focusedDay =
                focused;
          });
        },

        calendarBuilders:
            CalendarBuilders(
          defaultBuilder:
              (context, day, _) {
            if (isHoliday(day)) {
              return circleDay(
                day.day.toString(),
                Colors.orange
                    .withValues(
                  alpha: 0.2,
                ),
                Colors.orange,
              );
            }

            return null;
          },

          selectedBuilder:
              (context, day, _) {
            return circleDay(
              day.day.toString(),
              kPrimary,
              Colors.white,
            );
          },
        ),
      ),
    );
  }

  Widget circleDay(
    String text,
    Color bg,
    Color textColor,
  ) {
    return Center(
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            text,
            style:
                GoogleFonts.poppins(
              color:
                  textColor,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
