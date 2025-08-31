import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class ReorderDialog extends StatelessWidget {
  const ReorderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Reorder Low Stock Items', style: AppTextStyles.heading3),
      content: Text(
        'Feature comming soon !!!.\nThis would show a form to reorder all low stock items with suggested quantities and suppliers.',
        style: AppTextStyles.body2,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.darkGreen),
          child: const Text('Reorder'),
        ),
      ],
    );
  }
}