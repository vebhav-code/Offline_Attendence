import 'dart:io';
import 'worker_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../repositories/local_repository.dart';
import '../models/worker_model.dart';
import '../utils/app_colors.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  final TextEditingController searchController = TextEditingController();
  List<WorkerModel> filteredWorkers = [];

  @override
  void initState() {
    super.initState();
    filteredWorkers = List.from(LocalRepository.workers);
  }

  void searchMember(String value) {
    setState(() {
      filteredWorkers = LocalRepository.workers.where((worker) {
        return worker.name.toLowerCase().contains(value.toLowerCase()) ||
            worker.employeeId.toLowerCase().contains(value.toLowerCase()) ||
            worker.phone.contains(value);
      }).toList();
    });
  }

  bool isPresent(int workerId) {
    return LocalRepository.attendance.any(
      (attendance) => attendance.workerId == workerId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: Text(
          "Members",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kPrimary,
        onPressed: () {
          Navigator.pushNamed(context, "/add-member").then((_) {
            // Refresh list when returning from Add Member screen
            setState(() {
              filteredWorkers = List.from(LocalRepository.workers);
            });
          });
        },
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: const Text(
          "Add Member",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          buildSearchBar(),
          Expanded(
            child: filteredWorkers.isEmpty
                ? buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredWorkers.length,
                    itemBuilder: (context, index) {
                      return buildMemberCard(filteredWorkers[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: searchController,
        onChanged: searchMember,
        decoration: InputDecoration(
          hintText: "Search name, phone or ID",
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget buildMemberCard(WorkerModel worker) {
    bool present = isPresent(worker.id);

    return InkWell(
      onTap: () {
  Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) =>
        WorkerProfileScreen(
      worker: worker,
    ),
  ),
);
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
            )
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: kPrimaryLight,
              // Update: Use photos list instead of photoPath
              backgroundImage: worker.photos.isNotEmpty
                  ? FileImage(File(worker.photos.first))
                  : null,
              child: worker.photos.isEmpty
                  ? Text(
                      worker.name[0].toUpperCase(),
                      style: GoogleFonts.poppins(
                        color: kPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    worker.name,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    worker.employeeId,
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    worker.department,
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: present
                    ? kSuccess.withValues(alpha: 0.15)
                    : kAbsent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                present ? "Present" : "Absent",
                style: GoogleFonts.poppins(
                  color: present ? kSuccess : kAbsent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 20),
          Text(
            "No Members Found",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Add your first worker",
            style: GoogleFonts.poppins(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
