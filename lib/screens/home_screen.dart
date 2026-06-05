import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../repositories/local_repository.dart';
import '../utils/app_colors.dart';
import '../widgets/sidebar_drawer.dart';
import '../widgets/slogan_ticker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  bool isPresent(DateTime day) {
    return LocalRepository.attendance.any(
      (attendance) =>
          attendance.date.day == day.day &&
          attendance.date.month ==
              day.month &&
          attendance.date.year ==
              day.year,
    );
  }

  int get totalLabour =>
      LocalRepository.workers.length;

  int get presentToday =>
      LocalRepository.attendance.length;

  int get totalPresent =>
      LocalRepository.attendance.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,

      drawer: const SidebarDrawer(),

      floatingActionButton:
          FloatingActionButton(
        backgroundColor: kPrimary,
        elevation: 4,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/attendance-camera',
          );
        },
        child: const Icon(
          Icons.camera_alt_rounded,
          color: Colors.white,
        ),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation
              .centerDocked,

      bottomNavigationBar:
          buildBottomNavigation(),

      body: SafeArea(
        child: Column(
          children: [

            buildHeader(),

            Expanded(
              child:
                  SingleChildScrollView(
                padding:
                    const EdgeInsets.all(
                  16,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [

                    buildCalendarCard(),

                    const SizedBox(
                      height: 20,
                    ),

                    Text(
                      "${selectedDay.day} ${_monthName(selectedDay.month)} — Team Overview",
                      style:
                          GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    Row(
                      children: [

                        Expanded(
                          child:
                              buildStatBox(
                            Icons
                                .check_circle_outline,
                            "Present Today",
                            presentToday
                                .toString(),
                          ),
                        ),

                        const SizedBox(
                          width: 12,
                        ),

                        Expanded(
                          child:
                              buildStatBox(
                            Icons.people,
                            "Total Labour",
                            totalLabour
                                .toString(),
                          ),
                        ),

                        const SizedBox(
                          width: 12,
                        ),

                        Expanded(
                          child:
                              buildStatBox(
                            Icons
                                .bar_chart_rounded,
                            "Total Present",
                            totalPresent
                                .toString(),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: kPrimary,
      ),
      child: Column(
        children: [

          Row(
            children: [

              Builder(
                builder: (context) =>
                    IconButton(
                  onPressed: () {
                    Scaffold.of(context)
                        .openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ),
              ),

              Expanded(
                child: Text(
                  "Saksham Attendance",
                  style:
                      GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),

              Container(
                padding:
                    const EdgeInsets
                        .symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration:
                    BoxDecoration(
                  color: Colors.white
                      .withValues(
                    alpha: 0.15,
                  ),
                  borderRadius:
                      BorderRadius
                          .circular(
                    20,
                  ),
                ),
                child: const Text(
                  "EN",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          const SloganTicker(),
        ],
      ),
    );
  }

  Widget buildCalendarCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
          24,
        ),
      ),
      padding:
          const EdgeInsets.all(12),
      child: TableCalendar(
        firstDay:
            DateTime.utc(2025, 1, 1),
        lastDay:
            DateTime.utc(2035, 12, 31),
        focusedDay: focusedDay,

        selectedDayPredicate:
            (day) {
          return isSameDay(
            selectedDay,
            day,
          );
        },

        onDaySelected:
            (selected, focused) {
          setState(() {
            selectedDay = selected;
            focusedDay = focused;
          });
        },

        calendarBuilders:
            CalendarBuilders(
          defaultBuilder:
              (context, day, _) {
            if (isHoliday(day)) {
              return _circleDay(
                day.day.toString(),
                const Color(
                    0xFFF6E7B0),
                Colors.orange,
              );
            }

            if (isPresent(day)) {
              return _circleDay(
                day.day.toString(),
                Colors.green
                    .withValues(
                        alpha: 0.2),
                Colors.green,
              );
            }

            return null;
          },

          selectedBuilder:
              (context, day, _) {
            return _circleDay(
              day.day.toString(),
              kPrimary,
              Colors.white,
            );
          },
        ),
      ),
    );
  }

  Widget _circleDay(
    String text,
    Color bg,
    Color textColor,
  ) {
    return Center(
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            text,
            style:
                GoogleFonts.poppins(
              color: textColor,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStatBox(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
          20,
        ),
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [

          Icon(
            icon,
            color: kPrimary,
            size: 30,
          ),

          const SizedBox(height: 12),

          Text(
            value,
            style:
                GoogleFonts.poppins(
              fontSize: 32,
              color: kPrimary,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            title,
            textAlign:
                TextAlign.center,
            style:
                GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomNavigation() {
    return BottomAppBar(
      shape:
          const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment
                  .spaceAround,
          children: [

            Column(
              mainAxisAlignment:
                  MainAxisAlignment
                      .center,
              children: const [
                Icon(
                  Icons.home,
                  color: kPrimary,
                ),
                Text("Home"),
              ],
            ),

            const SizedBox(
              width: 50,
            ),

            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/members',
                );
              },
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment
                        .center,
                children: const [
                  Icon(
                    Icons.people,
                    color: Colors.grey,
                  ),
                  Text("Members"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    return months[month];
  }
}
