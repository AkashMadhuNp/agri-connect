import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.heading3.copyWith(color: AppColors.textWhite),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: AppTextStyles.caption.copyWith(color: AppColors.textWhite.withOpacity(0.8)),
            ),
        ],
      ),
      backgroundColor: AppColors.darkGreen,
      elevation: 0,
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (bottom?.preferredSize.height ?? 0.0)
  );
}