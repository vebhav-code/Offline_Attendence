import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final time =
        "${now.hour}:${now.minute.toString().padLeft(2, '0')}";

    return Container(
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            color: Colors.green,
            size: 14,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              "Worker Active • Last seen $time",
            ),
          ),
        ],
      ),
    );
  }
}
