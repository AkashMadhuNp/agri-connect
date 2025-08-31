import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/model/order_item_model.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:agri/presentation/widgets/service/custom_card.dart';
import 'package:agri/presentation/widgets/shop/order_card.dart' show OrderCard;
import 'package:agri/presentation/widgets/shop/shop_stat_card.dart';
import 'package:flutter/material.dart';

class OrdersTab extends StatelessWidget {
  final List<Order> orders;
  final List<Order> pendingOrders;
  final double totalRevenue;

  const OrdersTab({
    super.key,
    required this.orders,
    required this.pendingOrders,
    required this.totalRevenue,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrdersSummary(),
          const SizedBox(height: AppDimensions.paddingLarge),
          if (pendingOrders.isNotEmpty) ...[
            _buildPendingOrdersSection(),
            const SizedBox(height: AppDimensions.paddingLarge),
          ],
          _buildRecentOrdersSection(),
        ],
      ),
    );
  }

  Widget _buildOrdersSummary() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Orders Summary', style: AppTextStyles.heading3),
          const SizedBox(height: AppDimensions.paddingMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StatCard(
                label: 'Total Orders',
                value: '${orders.length}',
                icon: Icons.shopping_bag,
                color: AppColors.info,
              ),
              StatCard(
                label: 'Pending',
                value: '${pendingOrders.length}',
                icon: Icons.pending,
                color: AppColors.warning,
              ),
              StatCard(
                label: 'Revenue',
                value: 'Rs. ${(totalRevenue / 1000).toStringAsFixed(0)}K',
                icon: Icons.currency_rupee,
                color: AppColors.success,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPendingOrdersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pending Orders', style: AppTextStyles.heading3),
        const SizedBox(height: AppDimensions.paddingMedium),
        ...pendingOrders.map((order) => OrderCard(order: order)),
      ],
    );
  }

  Widget _buildRecentOrdersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Orders', style: AppTextStyles.heading3),
        const SizedBox(height: AppDimensions.paddingMedium),
        ...orders.map((order) => OrderCard(order: order)),
      ],
    );
  }
}