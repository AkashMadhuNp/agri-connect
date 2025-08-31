

import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/extension/color_extension.dart';
import 'package:agri/core/model/inventory_item_model.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:agri/presentation/widgets/service/custom_card.dart';
import 'package:agri/presentation/widgets/shop/action_button.dart';
import 'package:agri/presentation/widgets/shop/custom_chip.dart';
import 'package:flutter/material.dart';

class InventoryCard extends StatelessWidget {
  final InventoryItem item;
  final VoidCallback? onEdit;
  final VoidCallback? onReorder;

  const InventoryCard({
    super.key,
    required this.item,
    this.onEdit,
    this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: AppDimensions.paddingMedium),
          _buildStockInfo(),
          const SizedBox(height: AppDimensions.paddingMedium),
          _buildPriceInfo(),
          if (item.hasExpiry) ...[
            const SizedBox(height: AppDimensions.paddingSmall),
            _buildExpiryInfo(),
          ],
          const SizedBox(height: AppDimensions.paddingMedium),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.name, style: AppTextStyles.body1),
              Text(
                '${item.category} • ${item.location}',
                style: AppTextStyles.caption.copyWith(color: AppColors.darkGreen),
              ),
              Text('ID: ${item.id}', style: AppTextStyles.caption),
            ],
          ),
        ),
        CustomChip(
          label: item.status,
          backgroundColor: item.status.getStockStatusColor(),
        ),
      ],
    );
  }

  Widget _buildStockInfo() {
    return Row(
      children: [
        Expanded(
          child: _buildStockInfoItem(
            'Current Stock',
            '${item.currentStock} ${item.unit}',
            item.status.getStockStatusColor(),
          ),
        ),
        Expanded(
          child: _buildStockInfoItem(
            'Min Stock',
            '${item.minStock} ${item.unit}',
            AppColors.grey,
          ),
        ),
        Expanded(
          child: _buildStockInfoItem(
            'Value',
            'Rs. ${item.totalValue.toStringAsFixed(0)}',
            AppColors.success,
          ),
        ),
      ],
    );
  }

  Widget _buildStockInfoItem(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.caption),
        Text(
          value,
          style: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Cost: Rs. ${item.costPrice} | Sell: Rs. ${item.sellingPrice}',
          style: AppTextStyles.caption,
        ),
        Flexible(
          child: Text(
            'Supplier: ${item.supplier}',
            style: AppTextStyles.caption,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildExpiryInfo() {
    return Row(
      children: [
        const Icon(Icons.schedule, size: 14, color: AppColors.warning),
        const SizedBox(width: AppDimensions.paddingTiny),
        Text(
          'Expires: ${item.expiryDate}',
          style: AppTextStyles.caption.copyWith(color: AppColors.warning),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          child: ActionButton(
            label: 'Edit',
            icon: Icons.edit,
            onPressed: onEdit ?? () {},
            isOutlined: true,
          ),
        ),
        const SizedBox(width: AppDimensions.paddingSmall),
        Expanded(
          child: ActionButton(
            label: 'Reorder',
            icon: Icons.add_shopping_cart,
            onPressed: onReorder ?? () {},
          ),
        ),
      ],
    );
  }
}