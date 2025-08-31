import 'package:agri/core/utils/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:agri/core/colors/colors.dart';

class DailyStatWidget extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const DailyStatWidget({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: AppDimensions.iconSize),
        const SizedBox(height: AppDimensions.paddingTiny),
        Text(
          value, 
          style: TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.bold, 
            color: color,
          ),
        ),
        Text(
          label, 
          style: const TextStyle(
            fontSize: 10,
            color: AppColors.textSecondary,
          ), 
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
