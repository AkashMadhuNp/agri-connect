import 'package:agri/core/colors/colors.dart';
import 'package:flutter/material.dart';

extension ColorExtensions on String {
  Color getStockStatusColor() {
    switch (toLowerCase()) {
      case 'in stock':
        return AppColors.success;
      case 'low stock':
        return AppColors.warning;
      case 'out of stock':
        return AppColors.error;
      default:
        return AppColors.grey;
    }
  }

  Color getOrderStatusColor() {
    switch (toLowerCase()) {
      case 'delivered':
        return AppColors.success;
      case 'processing':
        return AppColors.info;
      case 'pending':
        return AppColors.warning;
      case 'cancelled':
        return AppColors.error;
      default:
        return AppColors.grey;
    }
  }
}
