import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/worker_model.dart';
import '../repositories/local_repository.dart';
import '../utils/app_colors.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({super.key});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  final ageController = TextEditingController();

  String department = "Construction";

  File? selectedImage;

  final picker = ImagePicker();

  String get employeeId {
    return "EMP-${1000 + LocalRepository.workers.length}";
  }

  Future<void> pickGalleryImage() async {
    final image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;

    setState(() {
      selectedImage = File(image.path);
    });
  }

  Future<void> pickCameraImage() async {
    final image = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (image == null) return;

    setState(() {
      selectedImage = File(image.path);
    });
  }

  void saveMember() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    LocalRepository.workers.add(
      WorkerModel(
        id: DateTime.now().millisecondsSinceEpoch,
        name: nameController.text.trim(),
        employeeId: employeeId,
        phone: phoneController.text.trim(),
        age: int.parse(ageController.text),
        department: department,
        photos: selectedImage != null 
            ? [selectedImage!.path] 
            : [],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Member Added"),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: const Text(
          "Add Member",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              buildPhotoPicker(),
              const SizedBox(
                height: 20,
              ),
              buildField(
                controller: nameController,
                label: "Full Name",
              ),
              buildField(
                controller: phoneController,
                label: "Phone Number",
                keyboard: TextInputType.phone,
              ),
              buildField(
                controller: ageController,
                label: "Age",
                keyboard: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                initialValue: department,
                decoration: const InputDecoration(
                  labelText: "Department",
                ),
                items: [
                  "Construction",
                  "Electrical",
                  "Plumbing",
                  "Carpentry",
                ]
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    department = value!;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: kPrimaryLight,
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                ),
                child: Text(
                  "Employee ID : $employeeId",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: saveMember,
                  child: const Text(
                    "Save Member",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPhotoPicker() {
    return Column(
      children: [
        CircleAvatar(
          radius: 55,
          backgroundColor: kPrimaryLight,
          backgroundImage: selectedImage != null
              ? FileImage(
                  selectedImage!,
                )
              : null,
          child: selectedImage == null
              ? const Icon(
                  Icons.person,
                  size: 50,
                )
              : null,
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: pickGalleryImage,
                icon: const Icon(
                  Icons.image,
                ),
                label: const Text(
                  "Gallery",
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: pickCameraImage,
                icon: const Icon(
                  Icons.camera_alt,
                ),
                label: const Text(
                  "Camera",
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Required";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
        ),
      ),
    );
  }
}
