import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double? elevation;

  const BaseCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppDimensions.paddingMedium),
    this.margin = const EdgeInsets.only(bottom: AppDimensions.paddingSmall),
    this.onTap,
    this.backgroundColor = AppColors.cardBackground,
    this.elevation = AppDimensions.cardElevation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      elevation: elevation,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      ),
    );
  }
}
