import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/profile_storage_service.dart';
import '../utils/app_colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
  });

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState
    extends State<EditProfileScreen> {
  final workerIdController =
      TextEditingController();

  final nameController =
      TextEditingController();

  final phoneController =
      TextEditingController();

  final departmentController =
      TextEditingController();

  final siteController =
      TextEditingController();

  String imagePath = "";

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final profile =
        await ProfileStorageService
            .getProfile();

    workerIdController.text =
        profile["workerId"] ?? "";

    nameController.text =
        profile["name"] ?? "";

    phoneController.text =
        profile["phone"] ?? "";

    departmentController.text =
        profile["department"] ?? "";

    siteController.text =
        profile["site"] ?? "";

    imagePath =
        profile["imagePath"] ?? "";
  }

  Future<void> saveProfile() async {
    await ProfileStorageService
        .saveProfile(
      workerId:
          workerIdController.text,
      name: nameController.text,
      phone: phoneController.text,
      department:
          departmentController.text,
      site: siteController.text,
      imagePath: imagePath,
    );

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;

    setState(() {
      imagePath = image.path;
    });
  }

  Widget field(
    String label,
    TextEditingController controller,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 14,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(
              12,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.background,
      appBar: AppBar(
        title:
            const Text("Edit Profile"),
        backgroundColor:
            AppColors.primary,
        foregroundColor:
            Colors.white,
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: imagePath.isNotEmpty
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          FileImage(
                        File(imagePath),
                      ),
                    )
                  : const CircleAvatar(
                      radius: 50,
                      backgroundColor:
                          AppColors.primary,
                      child: Icon(
                        Icons.camera_alt,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
            ),

            const SizedBox(height: 20),

            field(
              "Worker ID",
              workerIdController,
            ),

            field(
              "Full Name",
              nameController,
            ),

            field(
              "Phone Number",
              phoneController,
            ),

            field(
              "Department",
              departmentController,
            ),

            field(
              "Site Location",
              siteController,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed:
                    saveProfile,
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      AppColors.primary,
                  foregroundColor:
                      Colors.white,
                ),
                child: const Text(
                  "Save Profile",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
