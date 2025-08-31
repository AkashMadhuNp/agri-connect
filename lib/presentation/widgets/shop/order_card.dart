import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/extension/color_extension.dart';
import 'package:agri/core/model/order_item_model.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:agri/presentation/widgets/service/custom_card.dart';
import 'package:agri/presentation/widgets/shop/action_button.dart';
import 'package:agri/presentation/widgets/shop/custom_chip.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback? onCall;
  final VoidCallback? onUpdate;

  const OrderCard({
    super.key,
    required this.order,
    this.onCall,
    this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: AppDimensions.paddingMedium),
          _buildItems(),
          const SizedBox(height: AppDimensions.paddingMedium),
          _buildOrderInfo(),
          if (order.isPending) ...[
            const SizedBox(height: AppDimensions.paddingMedium),
            _buildActions(),
          ],
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
              Text(order.customerName, style: AppTextStyles.body1),
              Text(
                order.farmName,
                style: AppTextStyles.caption.copyWith(color: AppColors.darkGreen),
              ),
              Text('Order ID: ${order.orderId}', style: AppTextStyles.caption),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomChip(
              label: order.status,
              backgroundColor: order.status.getOrderStatusColor(),
            ),
            const SizedBox(height: AppDimensions.paddingTiny),
            Text(
              'Rs. ${order.totalAmount}',
              style: AppTextStyles.body2.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.darkGreen,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Items:', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: AppDimensions.paddingTiny),
        ...order.items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${item.name} x${item.quantity}', style: AppTextStyles.caption),
              Text('Rs. ${item.total}', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w500)),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildOrderInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order: ${order.orderDate}', style: AppTextStyles.caption),
            Text('Delivery: ${order.deliveryDate}', style: AppTextStyles.caption),
          ],
        ),
        Text(
          'Payment: ${order.paymentStatus}',
          style: AppTextStyles.caption.copyWith(
            color: order.isPaid ? AppColors.success : AppColors.warning,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          child: ActionButton(
            label: 'Call Customer',
            icon: Icons.call,
            onPressed: onCall ?? () {},
            isOutlined: true,
          ),
        ),
        const SizedBox(width: AppDimensions.paddingSmall),
        Expanded(
          child: ActionButton(
            label: order.status == 'Pending' ? 'Process' : 'Update',
            icon: Icons.update,
            onPressed: onUpdate ?? () {},
          ),
        ),
      ],
    );
  }
}