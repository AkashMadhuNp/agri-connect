import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/app_strings.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:agri/presentation/widgets/monitor/base_card.dart';
import 'package:agri/presentation/widgets/monitor/over_metric_widget.dart';
import 'package:agri/presentation/widgets/monitor/primary_button.dart';
import 'package:agri/presentation/widgets/monitor/secondary_button.dart';
import 'package:flutter/material.dart';
import '../../../../../core/model/production_batch_model.dart';
import '../../../../../core/model/staff_model.dart';

class OverviewTab extends StatelessWidget {
  final List<ProductionBatch> batches;
  final List<StaffMember> staffMembers;
  final List<Map<String, dynamic>> inventoryAlerts;
  final VoidCallback onRefresh;
  final VoidCallback onAddBatch;
  final VoidCallback onShowInventoryAlerts;

  const OverviewTab({
    super.key,
    required this.batches,
    required this.staffMembers,
    required this.inventoryAlerts,
    required this.onRefresh,
    required this.onAddBatch,
    required this.onShowInventoryAlerts,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Production Summary Card
            _buildProductionSummaryCard(),
            
            const SizedBox(height: AppDimensions.paddingLarge),

            // Inventory Alerts Section
            _buildInventoryAlertsSection(context),

            const SizedBox(height: AppDimensions.paddingLarge),

            // Quick Actions Section
            _buildQuickActionsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductionSummaryCard() {
    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.productionSummary, style: AppTextStyles.heading3),
          const SizedBox(height: AppDimensions.paddingMedium),
          
          if (batches.isNotEmpty) ...[
            Row(
              children: [
                Expanded(
                  child: OverviewMetricWidget(
                    label: 'Total Plants',
                    value: '${batches.map((b) => b.quantity).reduce((a, b) => a + b)}',
                    icon: Icons.eco,
                  ),
                ),
                Expanded(
                  child: OverviewMetricWidget(
                    label: 'Avg Health',
                    value: '${_calculateAverageHealth()}%',
                    icon: Icons.favorite,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            Row(
              children: [
                Expanded(
                  child: OverviewMetricWidget(
                    label: 'Est. Yield',
                    value: '${batches.map((b) => b.estimatedYield).reduce((a, b) => a + b)}',
                    icon: Icons.agriculture,
                  ),
                ),
                Expanded(
                  child: OverviewMetricWidget(
                    label: 'Locations',
                    value: '${batches.map((b) => b.location).toSet().length}',
                    icon: Icons.location_on,
                  ),
                ),
              ],
            ),
          ] else
            const Center(
              child: Padding(
                padding: EdgeInsets.all(AppDimensions.paddingMedium),
                child: Text('No production data available', style: AppTextStyles.body2),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInventoryAlertsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.inventoryAlerts, style: AppTextStyles.heading3),
        const SizedBox(height: AppDimensions.paddingSmall),
        
        ...inventoryAlerts.map((alert) => BaseCard(
              margin: const EdgeInsets.only(bottom: AppDimensions.paddingTiny),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: _getUrgencyColor(alert['urgency']).withOpacity(0.2),
                  child: Icon(
                    Icons.inventory_2,
                    color: _getUrgencyColor(alert['urgency']),
                  ),
                ),
                title: Text(alert['item'], style: AppTextStyles.body1),
                subtitle: Text(
                  '${alert['currentStock']} ${alert['unit']} remaining (Min: ${alert['minStock']})',
                  style: AppTextStyles.body2,
                ),
                trailing: Chip(
                  label: Text(
                    alert['urgency'],
                    style: const TextStyle(fontSize: 10),
                  ),
                  backgroundColor: _getUrgencyColor(alert['urgency']).withOpacity(0.2),
                ),
                onTap: () => _reorderItem(context, alert),
              ),
            )),
      ],
    );
  }

  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.quickActions, style: AppTextStyles.heading3),
        const SizedBox(height: AppDimensions.paddingSmall),
        
        Row(
          children: [
            Expanded(
              child: PrimaryButton(
                text: AppStrings.newBatch,
                icon: Icons.add,
                onPressed: onAddBatch,
              ),
            ),
            const SizedBox(width: AppDimensions.paddingSmall),
            Expanded(
              child: SecondaryButton(
                text: AppStrings.reorder,
                icon: Icons.inventory,
                onPressed: onShowInventoryAlerts,
              ),
            ),
          ],
        ),
      ],
    );
  }

  int _calculateAverageHealth() {
    if (batches.isEmpty) return 0;
    return (batches.map((b) => b.health).reduce((a, b) => a + b) / batches.length).round();
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

  void _reorderItem(BuildContext context, Map<String, dynamic> alert) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reorder ${alert['item']}'),
        content: Text(
          'Current stock: ${alert['currentStock']} ${alert['unit']}\n'
          'Minimum required: ${alert['minStock']} ${alert['unit']}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Reorder request sent for ${alert['item']}'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text(AppStrings.reorder),
          ),
        ],
      ),
    );
  }
}