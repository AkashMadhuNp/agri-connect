import 'package:agri/core/utils/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:agri/core/colors/colors.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppDimensions.cardElevation,
      color: AppColors.cardBackground,
      margin: margin,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppDimensions.paddingMedium),
        child: child,
      ),
    );
  }
}
