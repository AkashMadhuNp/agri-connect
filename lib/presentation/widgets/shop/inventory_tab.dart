import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/model/inventory_item_model.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:agri/presentation/widgets/service/custom_card.dart';
import 'package:agri/presentation/widgets/shop/shop_stat_card.dart';
import 'package:flutter/material.dart';
import 'inventory_card.dart';
import 'order_card.dart';
import 'product_card.dart';
import 'low_stock_card.dart';

class InventoryTab extends StatelessWidget {
  final List<InventoryItem> inventory;
  final List<InventoryItem> lowStockItems;
  final double totalInventoryValue;
  final VoidCallback? onReorderAll;

  const InventoryTab({
    super.key,
    required this.inventory,
    required this.lowStockItems,
    required this.totalInventoryValue,
    this.onReorderAll,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInventoryOverview(),
          const SizedBox(height: AppDimensions.paddingLarge),
          if (lowStockItems.isNotEmpty) ...[
            _buildLowStockSection(),
            const SizedBox(height: AppDimensions.paddingLarge),
          ],
          _buildAllInventorySection(),
        ],
      ),
    );
  }

  Widget _buildInventoryOverview() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Inventory Overview', style: AppTextStyles.heading3),
          const SizedBox(height: AppDimensions.paddingMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StatCard(
                label: 'Total Items',
                value: '${inventory.length}',
                icon: Icons.inventory,
                color: AppColors.info,
              ),
              StatCard(
                label: 'Low Stock',
                value: '${lowStockItems.length}',
                icon: Icons.warning,
                color: AppColors.warning,
              ),
              StatCard(
                label: 'Value',
                value: 'Rs. ${(totalInventoryValue / 1000).toStringAsFixed(0)}K',
                icon: Icons.attach_money,
                color: AppColors.success,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLowStockSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Low Stock Alerts',
              style: AppTextStyles.heading3.copyWith(color: AppColors.warning),
            ),
            TextButton(
              onPressed: onReorderAll,
              child: const Text('Reorder All'),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.paddingMedium),
        ...lowStockItems.map((item) => LowStockCard(item: item)),
      ],
    );
  }

  Widget _buildAllInventorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('All Inventory', style: AppTextStyles.heading3),
        const SizedBox(height: AppDimensions.paddingMedium),
        ...inventory.map((item) => InventoryCard(item: item)),
      ],
    );
  }
}



