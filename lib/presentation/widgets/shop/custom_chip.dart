import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
class CustomChip extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color? textColor;

  const CustomChip({
    super.key,
    required this.label,
    required this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingSmall,
        vertical: AppDimensions.paddingTiny,
      ),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: textColor ?? backgroundColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}