import 'package:flutter/material.dart';

class OverviewMetricWidget extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const OverviewMetricWidget({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF4CAF50), size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}
