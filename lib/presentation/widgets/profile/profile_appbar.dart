
import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/model/userdatamodel.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget {
  final UserData? userData;
  final User? currentUser;
  final VoidCallback onSettingsPressed;
  final VoidCallback onMorePressed;

  const ProfileAppBar({
    super.key,
    required this.userData,
    required this.currentUser,
    required this.onSettingsPressed,
    required this.onMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.primaryGreen,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.primaryGreen, AppColors.darkGreen],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                _buildProfilePicture(),
                const SizedBox(height: 12),
                _buildUserName(),
                const SizedBox(height: 4),
                _buildUserEmail(),
              ],
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: onSettingsPressed,
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: onMorePressed,
        ),
      ],
    );
  }

  Widget _buildProfilePicture() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
        border: Border.all(color: AppColors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Icon(
        Icons.person,
        size: 40,
        color: AppColors.primaryGreen,
      ),
    );
  }

  Widget _buildUserName() {
    return Text(
      userData?.name ?? currentUser?.displayName ?? 'User',
      style: AppTextStyles.heading2.copyWith(color: AppColors.white),
    );
  }

  Widget _buildUserEmail() {
    return Text(
      userData?.email ?? currentUser?.email ?? '',
      style: AppTextStyles.body2.copyWith(color: Colors.white70),
    );
  }
}
