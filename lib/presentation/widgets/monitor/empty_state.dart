import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget? action;

  const EmptyStateWidget({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingXLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: AppColors.textLight),
            const SizedBox(height: AppDimensions.paddingMedium),
            Text(title, style: AppTextStyles.heading3),
            if (subtitle != null) ...[
              const SizedBox(height: AppDimensions.paddingSmall),
              Text(subtitle!, style: AppTextStyles.body2),
            ],
            if (action != null) ...[
              const SizedBox(height: AppDimensions.paddingMedium),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}