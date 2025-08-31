import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/app_strings.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class ProfileMoreOptionsDialog extends StatelessWidget {
  final VoidCallback onEditProfile;
  final VoidCallback onSignOut;

  const ProfileMoreOptionsDialog({
    super.key,
    required this.onEditProfile,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
      ),
      title: Text(AppStrings.moreOptions, style: AppTextStyles.heading3),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit, color: AppColors.primaryGreen),
            title: Text(AppStrings.editProfile, style: AppTextStyles.body1),
            onTap: onEditProfile,
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.error),
            title: Text(AppStrings.signOut, style: AppTextStyles.body1),
            onTap: onSignOut,
          ),
        ],
      ),
    );
  }
}

