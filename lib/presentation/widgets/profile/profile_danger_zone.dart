
import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/app_strings.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class ProfileDangerZone extends StatelessWidget {
  final VoidCallback onSignOut;

  const ProfileDangerZone({
    super.key,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
        border: Border.all(color: AppColors.error.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.dangerZone,
            style: AppTextStyles.heading3.copyWith(color: AppColors.error),
          ),
          const SizedBox(height: AppDimensions.paddingSmall * 1.5),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.logout, color: AppColors.error),
            title: Text(
              AppStrings.signOut,
              style: AppTextStyles.body1.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.error,
              ),
            ),
            subtitle: Text(
              AppStrings.signOutDescription,
              style: AppTextStyles.caption,
            ),
            onTap: onSignOut,
          ),
        ],
      ),
    );
  }
}
