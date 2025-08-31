import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/model/production_batch_model.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/app_strings.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:agri/presentation/widgets/monitor/app_error.dart';
import 'package:agri/presentation/widgets/monitor/empty_state.dart';
import 'package:agri/presentation/widgets/monitor/loading_widget.dart';
import 'package:agri/presentation/widgets/monitor/primary_button.dart';
import 'package:agri/presentation/widgets/monitor/production_card.dart';
import 'package:agri/presentation/widgets/monitor/production_stat.dart';
import 'package:flutter/material.dart';
class ProductionTab extends StatelessWidget {
  final List<ProductionBatch> batches;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback onRefresh;
  final VoidCallback onAddBatch;

  const ProductionTab({
    super.key,
    required this.batches,
    required this.isLoading,
    this.errorMessage,
    required this.onRefresh,
    required this.onAddBatch,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const LoadingWidget(message: AppStrings.loadingProductionData);
    }

    if (errorMessage != null) {
      return AppErrorWidget(
        message: AppStrings.errorLoadingData,
        description: errorMessage,
        onRetry: onRefresh,
      );
    }

    final activeBatches = batches.where((batch) => batch.isActive).toList();
    final completedBatches = batches.where((batch) => batch.isCompleted).toList();

    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Production Stats
            ProductionStatsWidget(
              batches: batches,
              isLoading: isLoading,
            ),

            const SizedBox(height: AppDimensions.paddingLarge),

            // Active Production Section
            _buildSectionHeader(
              title: AppStrings.activeBatches,
              subtitle: '${activeBatches.length} batches',
            ),
            const SizedBox(height: AppDimensions.paddingSmall),

            if (activeBatches.isEmpty)
              EmptyStateWidget(
                title: AppStrings.noActiveBatches,
                icon: Icons.agriculture,
                action: PrimaryButton(
                  text: AppStrings.addFirstBatch,
                  icon: Icons.add,
                  onPressed: onAddBatch,
                ),
              )
            else
              ...activeBatches.map((batch) => ProductionCardWidget(
                    batch: batch,
                    onDetailsPressed: () => _showBatchDetails(context, batch),
                    onUpdatePressed: () => _updateBatch(context, batch),
                    onDeletePressed: () => _deleteBatch(context, batch),
                  )),

            // Recently Completed Section
            if (completedBatches.isNotEmpty) ...[
              const SizedBox(height: AppDimensions.paddingLarge),
              _buildSectionHeader(
                title: AppStrings.recentlyCompleted,
                subtitle: '${completedBatches.length} batches',
              ),
              const SizedBox(height: AppDimensions.paddingSmall),

              ...completedBatches.take(2).map((batch) => ProductionCardWidget(
                    batch: batch,
                    onDetailsPressed: () => _showBatchDetails(context, batch),
                    onUpdatePressed: () => _updateBatch(context, batch),
                  )),

              if (completedBatches.length > 2)
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.history, color: AppColors.primaryGreen),
                    title: Text('View ${completedBatches.length - 2} more completed batches'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => _showAllCompletedBatches(context),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader({required String title, String? subtitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.heading3),
        if (subtitle != null)
          Text(subtitle, style: AppTextStyles.body2),
      ],
    );
  }

  void _showBatchDetails(BuildContext context, ProductionBatch batch) {
    // Navigate to batch details or show dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Show details for ${batch.crop}')),
    );
  }

  void _updateBatch(BuildContext context, ProductionBatch batch) {
    // Navigate to update batch screen or show dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Update ${batch.crop}')),
    );
  }

  void _deleteBatch(BuildContext context, ProductionBatch batch) {
    // Show confirmation dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Delete ${batch.crop}')),
    );
  }

  void _showAllCompletedBatches(BuildContext context) {
    // Navigate to all completed batches screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigate to completed batches screen')),
    );
  }
}
