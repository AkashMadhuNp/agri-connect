import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/app_strings.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class InventoryAlertsBottomSheet extends StatelessWidget {
  final List<Map<String, dynamic>> alerts;
  final Function(Map<String, dynamic>) onReorderPressed;

  const InventoryAlertsBottomSheet({
    super.key,
    required this.alerts,
    required this.onReorderPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.borderRadius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          
          Text(AppStrings.inventoryAlerts, style: AppTextStyles.heading3),
          const SizedBox(height: AppDimensions.paddingMedium),
          
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: alerts.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final alert = alerts[index];
                return _buildAlertItem(alert);
              },
            ),
          ),
          
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildAlertItem(Map<String, dynamic> alert) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingTiny),
      leading: Icon(
        Icons.inventory_2,
        color: _getUrgencyColor(alert['urgency']),
        size: AppDimensions.iconSize,
      ),
      title: Text(alert['item'], style: AppTextStyles.body1),
      subtitle: Text(
        '${alert['currentStock']} ${alert['unit']} remaining',
        style: AppTextStyles.body2,
      ),
      trailing: SizedBox(
        width: 80,
        height: 32,
        child: ElevatedButton(
          onPressed: () => onReorderPressed(alert),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryGreen,
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingSmall),
          ),
          child: const Text(
            AppStrings.reorder,
            style: TextStyle(fontSize: 12, color: AppColors.white),
          ),
        ),
      ),
    );
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency.toLowerCase()) {
      case 'high':
        return AppColors.error;
      case 'medium':
        return AppColors.warning;
      case 'low':
        return AppColors.info;
      default:
        return AppColors.grey;
    }
  }
}
