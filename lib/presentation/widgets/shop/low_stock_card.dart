import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/model/inventory_item_model.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:agri/presentation/widgets/shop/action_button.dart';
import 'package:flutter/material.dart';

class LowStockCard extends StatelessWidget {
  final InventoryItem item;
  final VoidCallback? onReorder;

  const LowStockCard({
    super.key,
    required this.item,
    this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingSmall),
      color: AppColors.warning.withOpacity(0.1),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppColors.warning,
          child: Icon(Icons.warning, color: AppColors.white, size: 20),
        ),
        title: Text(item.name, style: AppTextStyles.body2),
        subtitle: Text(
          '${item.currentStock} ${item.unit} remaining (Min: ${item.minStock})',
          style: AppTextStyles.caption,
        ),
        trailing: SizedBox(
          width: 80,
          child: ActionButton(
            label: 'Reorder',
            onPressed: onReorder ?? () {},
          ),
        ),
      ),
    );
  }
}