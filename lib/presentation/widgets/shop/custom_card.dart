import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ?? const EdgeInsets.only(bottom: AppDimensions.paddingMedium),
      elevation: AppDimensions.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
      ),
      color: color ?? AppColors.cardBackground,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppDimensions.paddingMedium),
        child: child,
      ),
    );
  }
}