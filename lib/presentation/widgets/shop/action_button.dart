import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
class ActionButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isOutlined;

  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isPrimary = true,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon != null 
          ? Icon(icon, size: AppDimensions.iconSizeSmall) 
          : const SizedBox.shrink(),
        label: Text(label, style: AppTextStyles.caption),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.darkGreen,
          side: const BorderSide(color: AppColors.darkGreen),
        ),
      );
    }

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon != null 
        ? Icon(icon, size: AppDimensions.iconSizeSmall) 
        : const SizedBox.shrink(),
      label: Text(label, style: AppTextStyles.caption),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? AppColors.darkGreen : AppColors.grey,
        foregroundColor: AppColors.textWhite,
      ),
    );
  }
}