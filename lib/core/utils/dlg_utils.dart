import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static Future<bool?> showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String content,
    String confirmText = AppStrings.onDuty,
    String cancelText = AppStrings.cancel,
    bool isDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: isDestructive
                ? ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    foregroundColor: AppColors.backgroundLight,
                  )
                : null,
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  static void showInfoDialog(
    BuildContext context, {
    required String title,
    required String content,
    String buttonText = 'OK',
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

  static void showLoadingDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 20),
            Text(message),
          ],
        ),
      ),
    );
  }

  static Future<T?> showFormDialog<T>(
    BuildContext context, {
    required String title,
    required Widget content,
    required String confirmText,
    String cancelText = AppStrings.cancel,
    VoidCallback? onConfirm,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: content,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: onConfirm ?? () => Navigator.pop(context),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }
}




class Validators {
  static String? required(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) return null;
    
    const emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regex = RegExp(emailPattern);
    
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) return null;
    
    const phonePattern = r'^\+?[1-9]\d{1,14}$';
    final regex = RegExp(phonePattern);
    
    if (!regex.hasMatch(value.replaceAll(RegExp(r'[\s\-\(\)]'), ''))) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? number(String? value, String fieldName) {
    if (value == null || value.isEmpty) return null;
    
    final number = double.tryParse(value);
    if (number == null) {
      return '$fieldName must be a valid number';
    }
    return null;
  }

  static String? positiveNumber(String? value, String fieldName) {
    final numberValidation = number(value, fieldName);
    if (numberValidation != null) return numberValidation;
    
    final numberValue = double.parse(value!);
    if (numberValue <= 0) {
      return '$fieldName must be greater than 0';
    }
    return null;
  }
}
