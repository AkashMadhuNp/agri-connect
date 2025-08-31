import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/app_strings.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class ProfileSettingsBottomSheet extends StatelessWidget {
  const ProfileSettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.borderRadiusLarge * 1.5),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: AppDimensions.paddingLarge),
              
              // Title
              Text(
                AppStrings.settings, 
                style: AppTextStyles.heading2,
              ),
              const SizedBox(height: AppDimensions.paddingLarge),
              
              // Settings items
              _buildSettingsItem(
                context,
                Icons.notifications_outlined,
                AppStrings.notifications,
                () => _handleNotifications(context),
              ),
              _buildSettingsItem(
                context,
                Icons.security_outlined,
                AppStrings.security,
                () => _handleSecurity(context),
              ),
              _buildSettingsItem(
                context,
                Icons.language_outlined,
                AppStrings.language,
                () => _handleLanguage(context),
              ),
              _buildSettingsItem(
                context,
                Icons.help_outline,
                AppStrings.helpSupport,
                () => _handleHelp(context),
              ),
              
              const SizedBox(height: AppDimensions.paddingLarge),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.primaryGreen,
        size: 24,
      ),
      title: Text(
        title,
        style: AppTextStyles.body1,
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.textSecondary,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingSmall,
      ),
    );
  }

  void _handleNotifications(BuildContext context) {
    Navigator.pop(context);
    debugPrint('Notifications tapped');
  }

  void _handleSecurity(BuildContext context) {
    Navigator.pop(context);
    debugPrint('Security tapped');
  }

  void _handleLanguage(BuildContext context) {
    Navigator.pop(context);
    debugPrint('Language tapped');
  }

  void _handleHelp(BuildContext context) {
    Navigator.pop(context);
    debugPrint('Help tapped');
  }
}