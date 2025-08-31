import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class PriceUpdateDialog extends StatelessWidget {
  const PriceUpdateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update Product Prices', style: AppTextStyles.heading3),
      content: Text(
        'This would allow you to update selling prices for your products based on market conditions.',
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
          child: const Text('Update'),
        ),
      ],
    );
  }
}