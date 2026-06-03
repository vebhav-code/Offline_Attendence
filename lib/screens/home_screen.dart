import 'dart:io';
import 'package:flutter/material.dart';
import '../services/profile_storage_service.dart';

import '../services/language_service.dart';
import '../utils/app_colors.dart';
import '../widgets/home_header.dart';
import '../widgets/status_card.dart';
import '../widgets/action_card.dart';
import '../widgets/reminder_card.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/sync_status_card.dart';
import '../widgets/activity_card.dart';

import 'attendance_dashboard_screen.dart';
import 'history_screen.dart';
import 'profile_screen.dart';
import 'attendance_camera_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {
  String language = "English";
  String workerName = "Worker";
  String profileImage = "";

  @override
  void initState() {
    super.initState();
    loadLanguage();
    loadWorker();
  }

  Future<void> loadWorker() async {
    final profile =
        await ProfileStorageService.getProfile();

    if (mounted) {
      setState(() {
        workerName =
            profile["name"] ?? "Worker";

        profileImage =
            profile["imagePath"] ?? "";
      });
    }
  }

  Future<void> loadLanguage() async {
    language =
        await LanguageService.getLanguage();

    if (mounted) {
      setState(() {});
    }
  }

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (language == "Hindi") {
      if (hour < 12) {
        return "सुप्रभात, $workerName";
      } else if (hour < 17) {
        return "नमस्कार, $workerName";
      } else if (hour < 21) {
        return "शुभ संध्या, $workerName";
      } else {
        return "शुभ रात्रि, $workerName";
      }
    }

    if (hour < 12) {
      return "Good Morning, $workerName";
    } else if (hour < 17) {
      return "Good Afternoon, $workerName";
    } else if (hour < 21) {
      return "Good Evening, $workerName";
    } else {
      return "Good Night, $workerName";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.background,
      bottomNavigationBar:
          const BottomNav(),
      body: SafeArea(
        child: Column(
          children: [
            HomeHeader(
              onLanguageChanged:
                  loadLanguage,
            ),

            Container(
              width: double.infinity,
              height: 28,
              color: Colors.green.shade500,
              alignment: Alignment.center,
              child: Text(
                language == "Hindi"
                    ? "● ऑफलाइन तैयार"
                    : "● Offline Ready",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                16,
                20,
                10,
              ),
              child: Row(
                children: [
                  profileImage.isNotEmpty
                      ? CircleAvatar(
                          radius: 28,
                          backgroundImage:
                              FileImage(
                            File(profileImage),
                          ),
                        )
                      : const CircleAvatar(
                          radius: 28,
                          backgroundColor:
                              AppColors.primary,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          getGreeting(),
                          style:
                              const TextStyle(
                            fontSize: 22,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          language == "Hindi"
                              ? "आज का कार्य दिवस शुरू करें"
                              : "Ready to start today's work",
                          style:
                              const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    StatusCard(
                      key: ValueKey(
                        "status_$language",
                      ),
                    ),

                    const SizedBox(height: 16),

                    SyncStatusCard(
                      key: ValueKey(
                        "sync_$language",
                      ),
                    ),

                    const SizedBox(height: 16),

                    ActivityCard(
                      key: ValueKey(
                        "activity_$language",
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 110,
                      child:
                          ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const AttendanceCameraScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 36,
                        ),
                        label: Text(
                          language ==
                                  "Hindi"
                              ? "उपस्थिति दर्ज करें"
                              : "Mark Attendance",
                          style:
                              const TextStyle(
                            fontSize: 22,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: ActionCard(
                            icon:
                                Icons.history,
                            title: language ==
                                    "Hindi"
                                ? "इतिहास"
                                : "History",
                            subtitle: language ==
                                    "Hindi"
                                ? "उपस्थिति देखें"
                                : "View attendance",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const HistoryScreen(),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: ActionCard(
                            icon: Icons
                                .person_outline,
                            title: language ==
                                    "Hindi"
                                ? "प्रोफाइल"
                                : "Profile",
                            subtitle: language ==
                                    "Hindi"
                                ? "कार्यकर्ता प्रोफाइल"
                                : "Worker profile",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const ProfileScreen(),
                                ),
                              ).then((_) {
                                loadWorker();
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    ActionCard(
                      icon:
                          Icons.calendar_month,
                      title: language ==
                              "Hindi"
                          ? "उपस्थिति डैशबोर्ड"
                          : "Attendance Dashboard",
                      subtitle: language ==
                              "Hindi"
                          ? "कैलेंडर और रिपोर्ट"
                          : "View calendar & reports",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const AttendanceDashboardScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    ReminderCard(
                      key: ValueKey(
                        "reminder_$language",
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
