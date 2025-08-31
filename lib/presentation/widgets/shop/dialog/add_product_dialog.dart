import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class AddProductDialog extends StatelessWidget {
  const AddProductDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Product', style: AppTextStyles.heading3),
      content: Text(
        'Feature comming soon‼️.\nThis would open a form to add new products to your catalog with pricing, description, and inventory details.',
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
          child: const Text('Add'),
        ),
      ],
    );
  }
}