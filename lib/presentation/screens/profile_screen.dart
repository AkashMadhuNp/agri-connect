
import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/data/profile_service.dart';
import 'package:agri/core/model/userdatamodel.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/app_strings.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:agri/core/utils/snackbar_utils.dart';
import 'package:agri/presentation/widgets/profile/profile_appbar.dart';
import 'package:agri/presentation/widgets/profile/profile_bottom_sheet.dart';
import 'package:agri/presentation/widgets/profile/profile_danger_zone.dart';
import 'package:agri/presentation/widgets/profile/profile_edit_dlg.dart';
import 'package:agri/presentation/widgets/profile/profile_info_section.dart';
import 'package:agri/presentation/widgets/profile/profile_menu_option.dart';
import 'package:agri/presentation/widgets/profile/profile_quick_action.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileService _profileService = ProfileService();
  
  User? currentUser;
  UserData? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() => isLoading = true);

    currentUser = _profileService.getCurrentUser();
    if (currentUser != null) {
      userData = await _profileService.getUserData(currentUser!.uid);
    }

    setState(() => isLoading = false);
  }

  Future<void> _handleSignOut() async {
    final shouldSignOut = await _showSignOutDialog();
    if (shouldSignOut == true) {
      final success = await _profileService.signOut();
      if (success && mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      } else if (mounted) {
        SnackBarUtils.showError(context, 'Failed to sign out. Please try again.');
      }
    }
  }

  Future<bool?> _showSignOutDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
        ),
        title: Text(
          AppStrings.signOut,
          style: AppTextStyles.heading3.copyWith(color: AppColors.textPrimary),
        ),
        content: Text(
          AppStrings.signOutConfirmation,
          style: AppTextStyles.body2,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              AppStrings.cancel,
              style: AppTextStyles.body1.copyWith(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
              ),
            ),
            child: Text(
              AppStrings.signOut,
              style: AppTextStyles.buttonText,
            ),
          ),
        ],
      ),
    );
  }

  void _showEditProfile() {
    showDialog(
      context: context,
      builder: (context) => ProfileEditDialog(
        userData: userData,
        currentUser: currentUser,
        onSave: (updatedData) async {
          if (currentUser != null) {
            final success = await _profileService.updateUserData(
              currentUser!.uid, 
              updatedData,
            );
            if (success) {
              setState(() {
                userData = updatedData;
              });
              if (mounted) {
                SnackBarUtils.showSuccess(context, 'Profile updated successfully');
              }
            } else {
              if (mounted) {
                SnackBarUtils.showError(context, 'Failed to update profile');
              }
            }
          }
        },
      ),
    );
  }

// Add these debug methods to your ProfileScreen class

void _showSettings() {
  print('🔍 _showSettings called');
  try {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        print('🔍 Building ProfileSettingsBottomSheet');
        return const ProfileSettingsBottomSheet();
      },
    ).then((_) {
      print('🔍 Settings bottom sheet closed');
    }).catchError((error) {
      print('❌ Settings bottom sheet error: $error');
    });
  } catch (e) {
    print('❌ Error in _showSettings: $e');
    // Fallback to simple dialog
    _showSettingsDialog();
  }
}

void _showMoreOptions() {
  print('🔍 _showMoreOptions called');
  try {
    showDialog(
      context: context,
      builder: (context) {
        print('🔍 Building ProfileMoreOptionsDialog');
        return ProfileMoreOptionsDialog(
          onEditProfile: () {
            print('🔍 Edit profile selected');
            _showEditProfile();
          },
          onSignOut: () {
            print('🔍 Sign out selected');
            _handleSignOut();
          },
        );
      },
    ).then((_) {
      print('🔍 More options dialog closed');
    }).catchError((error) {
      print('❌ More options dialog error: $error');
    });
  } catch (e) {
    print('❌ Error in _showMoreOptions: $e');
    // Fallback to simple dialog
    _showSimpleMoreOptions();
  }
}

// Fallback methods with minimal widgets
void _showSettingsDialog() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Settings'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Notifications'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            title: const Text('Security'), 
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            title: const Text('Language'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            title: const Text('Help & Support'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}

void _showSimpleMoreOptions() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Options'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Edit Profile'),
            onTap: () {
              Navigator.pop(context);
              _showEditProfile();
            },
          ),
          ListTile(
            title: const Text('Sign Out'),
            onTap: () {
              Navigator.pop(context);
              _handleSignOut();
            },
          ),
        ],
      ),
    ),
  );
}
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
              ),
            )
          : RefreshIndicator(
              onRefresh: _loadUserData,
              color: AppColors.primaryGreen,
              child: CustomScrollView(
                slivers: [
                  ProfileAppBar(
                    userData: userData,
                    currentUser: currentUser,
                    onSettingsPressed: _showSettings,
                    onMorePressed: _showMoreOptions,
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileQuickActions(onEditProfile: _showEditProfile),
                          const SizedBox(height: AppDimensions.paddingXLarge),
                          ProfileInfoSection(
                            userData: userData,
                            currentUser: currentUser,
                          ),
                          const SizedBox(height: AppDimensions.paddingXLarge),
                          ProfileDangerZone(onSignOut: _handleSignOut),
                          const SizedBox(height: AppDimensions.paddingXLarge),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
