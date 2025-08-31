import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/model/product_model.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:agri/presentation/widgets/shop/action_button.dart';
import 'package:agri/presentation/widgets/shop/custom_card.dart';
import 'package:agri/presentation/widgets/shop/product_card.dart';
import 'package:agri/presentation/widgets/shop/shop_stat_card.dart';
import 'package:flutter/material.dart';

class ProductsTab extends StatelessWidget {
  final List<Product> products;
  final int totalAvailable;
  final int totalSold;
  final double averageRating;
  final VoidCallback? onAddProduct;
  final VoidCallback? onUpdatePrices;

  const ProductsTab({
    super.key,
    required this.products,
    required this.totalAvailable,
    required this.totalSold,
    required this.averageRating,
    this.onAddProduct,
    this.onUpdatePrices,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductsOverview(),
          const SizedBox(height: AppDimensions.paddingLarge),
          _buildAvailableProductsSection(),
          const SizedBox(height: AppDimensions.paddingLarge),
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildProductsOverview() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Live Plants Catalog', style: AppTextStyles.heading3),
          const SizedBox(height: AppDimensions.paddingMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StatCard(
                label: 'Available Plants',
                value: '$totalAvailable',
                icon: Icons.eco,
                color: AppColors.success,
              ),
              StatCard(
                label: 'Sold This Month',
                value: '$totalSold',
                icon: Icons.trending_up,
                color: AppColors.info,
              ),
              StatCard(
                label: 'Avg Rating',
                value: '${averageRating.toStringAsFixed(1)}⭐',
                icon: Icons.star,
                color: AppColors.warning,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableProductsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Available Products for Farmers', style: AppTextStyles.heading3),
        const SizedBox(height: AppDimensions.paddingMedium),
        ...products.map((product) => ProductCard(product: product)),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: ActionButton(
            label: 'Add Product',
            icon: Icons.add,
            onPressed: onAddProduct ?? () {},
          ),
        ),
        const SizedBox(width: AppDimensions.paddingMedium),
        Expanded(
          child: ActionButton(
            label: 'Update Prices',
            icon: Icons.price_change,
            onPressed: onUpdatePrices ?? () {},
            isOutlined: true,
          ),
        ),
      ],
    );
  }
}