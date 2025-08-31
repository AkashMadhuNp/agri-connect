import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/model/product_model.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:agri/presentation/widgets/service/custom_card.dart';
import 'package:agri/presentation/widgets/shop/action_button.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onEdit;
  final VoidCallback? onViewOrders;

  const ProductCard({
    super.key,
    required this.product,
    this.onEdit,
    this.onViewOrders,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: AppDimensions.paddingMedium),
          _buildStats(),
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
              Text(product.name, style: AppTextStyles.body1),
              Text(product.description, style: AppTextStyles.caption),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Rs. ${product.price}',
              style: AppTextStyles.body1.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.darkGreen,
              ),
            ),
            Text(product.unit, style: AppTextStyles.caption),
          ],
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Available: ${product.available}',
          style: AppTextStyles.caption.copyWith(color: AppColors.success),
        ),
        Text(
          'Sold: ${product.sold}',
          style: AppTextStyles.caption.copyWith(color: AppColors.info),
        ),
        Row(
          children: [
            const Icon(Icons.star, size: 12, color: AppColors.warning),
            Text(' ${product.rating}', style: AppTextStyles.caption),
          ],
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
            label: 'View Orders',
            icon: Icons.visibility,
            onPressed: onViewOrders ?? () {},
          ),
        ),
      ],
    );
  }
}