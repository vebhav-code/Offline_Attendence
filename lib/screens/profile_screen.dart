import 'dart:io';

import 'package:flutter/material.dart';

import '../services/profile_storage_service.dart';
import '../utils/app_colors.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {
  Map<String, String> profile = {};

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final data =
        await ProfileStorageService.getProfile();

    if (mounted) {
      setState(() {
        profile = data;
      });
    }
  }

  Widget buildInfoTile(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              AppColors.primary.withValues(
            alpha: 0.10,
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(value),
      ),
    );
  }

  Future<void> openEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const EditProfileScreen(),
      ),
    );

    if (result == true) {
      loadProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.background,
      appBar: AppBar(
        title: const Text(
          "Worker Profile",
        ),
        backgroundColor:
            AppColors.primary,
        foregroundColor:
            Colors.white,
      ),
      body: profile.isEmpty
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding:
                  const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.all(
                      20,
                    ),
                    decoration:
                        BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(
                        24,
                      ),
                    ),
                    child: Column(
                      children: [
                        profile["imagePath"] !=
                                    null &&
                                profile["imagePath"]!
                                    .isNotEmpty
                            ? CircleAvatar(
                                radius: 55,
                                backgroundImage:
                                    FileImage(
                                  File(
                                    profile[
                                        "imagePath"]!,
                                  ),
                                ),
                              )
                            : const CircleAvatar(
                                radius: 55,
                                backgroundColor:
                                    AppColors.primary,
                                child: Icon(
                                  Icons.person,
                                  size: 55,
                                  color:
                                      Colors.white,
                                ),
                              ),

                        const SizedBox(
                          height: 15,
                        ),

                        Text(
                          profile["name"] ?? "",
                          style:
                              const TextStyle(
                            fontSize: 24,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration:
                              BoxDecoration(
                            color:
                                Colors.blue.shade50,
                            borderRadius:
                                BorderRadius.circular(
                              20,
                            ),
                          ),
                          child: Text(
                            profile["workerId"] ?? "",
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  buildInfoTile(
                    Icons.phone,
                    "Phone Number",
                    profile["phone"] ?? "",
                  ),

                  buildInfoTile(
                    Icons.work,
                    "Department",
                    profile["department"] ??
                        "",
                  ),

                  buildInfoTile(
                    Icons.location_on,
                    "Site Location",
                    profile["site"] ?? "",
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    width:
                        double.infinity,
                    height: 55,
                    child:
                        ElevatedButton.icon(
                      onPressed:
                          openEditProfile,
                      icon: const Icon(
                        Icons.edit,
                      ),
                      label: const Text(
                        "Edit Profile",
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  SizedBox(
                    width:
                        double.infinity,
                    height: 55,
                    child:
                        OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.language,
                      ),
                      label: const Text(
                        "Language Preference",
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  SizedBox(
                    width:
                        double.infinity,
                    height: 55,
                    child:
                        OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.support_agent,
                      ),
                      label: const Text(
                        "Help & Support",
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
