import 'package:flutter/material.dart';
import 'package:agri/core/colors/colors.dart';

class StatusUtils {
  static Color getConsultationStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed': 
        return AppColors.success;
      case 'pending': 
        return AppColors.warning;
      case 'completed': 
        return AppColors.info;
      case 'cancelled': 
        return AppColors.error;
      default: 
        return AppColors.grey;
    }
  }

  static Color getServiceStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed': 
        return AppColors.success;
      case 'report pending': 
        return AppColors.warning;
      case 'cancelled': 
        return AppColors.error;
      default: 
        return AppColors.grey;
    }
  }

  static IconData getServiceStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'completed': 
        return Icons.check_circle;
      case 'report pending': 
        return Icons.pending;
      case 'cancelled': 
        return Icons.cancel;
      default: 
        return Icons.help;
    }
  }
}
