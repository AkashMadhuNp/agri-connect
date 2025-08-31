
import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/model/userdatamodel.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/app_strings.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileEditDialog extends StatelessWidget {
  final UserData? userData;
  final User? currentUser;
  final Function(UserData) onSave;

  const ProfileEditDialog({
    super.key,
    required this.userData,
    required this.currentUser,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
      ),
      title: Text(
        AppStrings.editProfile,
        style: AppTextStyles.heading3,
      ),
      content: Text(
        AppStrings.editProfileDescription,
        style: AppTextStyles.body2,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            AppStrings.close,
            style: AppTextStyles.body1.copyWith(color: AppColors.primaryGreen),
          ),
        ),
      ],
    );
  }
}
