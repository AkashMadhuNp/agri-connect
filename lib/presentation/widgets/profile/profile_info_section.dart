
import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/model/userdatamodel.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/app_strings.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:agri/presentation/widgets/profile/profile_info_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileInfoSection extends StatelessWidget {
  final UserData? userData;
  final User? currentUser;

  const ProfileInfoSection({
    super.key,
    required this.userData,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.accountInformation, style: AppTextStyles.heading3),
        const SizedBox(height: AppDimensions.paddingMedium),
        Container(
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              InfoItem(
                icon: Icons.person_outline,
                label: AppStrings.fullName,
                value: userData?.name ?? currentUser?.displayName ?? AppStrings.notProvided,
              ),
              InfoItem(
                icon: Icons.email_outlined,
                label: AppStrings.email,
                value: userData?.email ?? currentUser?.email ?? AppStrings.notProvided,
              ),
              InfoItem(
                icon: Icons.phone_outlined,
                label: AppStrings.phone,
                value: userData?.phone ?? AppStrings.notProvided,
              ),
              InfoItem(
                icon: Icons.location_on_outlined,
                label: AppStrings.location,
                value: userData?.location ?? AppStrings.notProvided,
              ),
              InfoItem(
                icon: Icons.calendar_today_outlined,
                label: AppStrings.memberSince,
                value: userData?.createdAt != null 
                    ? '${userData!.createdAt.day}/${userData!.createdAt.month}/${userData!.createdAt.year}'
                    : AppStrings.notAvailable,
                isLast: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
