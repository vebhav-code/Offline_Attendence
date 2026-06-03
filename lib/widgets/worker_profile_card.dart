import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class WorkerProfileCard extends StatelessWidget {
  const WorkerProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: AppColors.primary,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 32,
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  "Ayush Gupta",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text("EMP-8829-24"),
                Text("Construction • Site A"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
