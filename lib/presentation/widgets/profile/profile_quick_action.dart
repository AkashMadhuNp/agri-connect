
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/app_strings.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:agri/presentation/widgets/profile/action_card.dart';
import 'package:flutter/material.dart';

class ProfileQuickActions extends StatelessWidget {
  final VoidCallback onEditProfile;

  const ProfileQuickActions({
    super.key,
    required this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.quickActions, style: AppTextStyles.heading3),
        const SizedBox(height: AppDimensions.paddingMedium),
        Row(
          children: [
            Expanded(
              child: ActionCard(
                icon: Icons.edit_outlined,
                title: AppStrings.editProfile,
                onTap: onEditProfile,
              ),
            ),
            const SizedBox(width: AppDimensions.paddingSmall * 1.5),
            Expanded(
              child: ActionCard(
                icon: Icons.security_outlined,
                title: AppStrings.security,
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
