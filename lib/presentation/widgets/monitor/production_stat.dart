import 'package:flutter/material.dart';
import 'package:agri/core/model/production_batch_model.dart';
import 'package:agri/presentation/widgets/monitor/quick_stat.dart';

class ProductionStatsWidget extends StatelessWidget {
  final List<ProductionBatch> batches;
  final bool isLoading;

  const ProductionStatsWidget({
    Key? key,
    required this.batches,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: CircularProgressIndicator(color: Color(0xFF4CAF50)),
          ),
        ),
      );
    }

    final activeBatches = batches.where((batch) => batch.isActive).length;
    final readyToHarvest = batches.where((batch) => batch.isReady).length;
    final needAttention = batches.where((batch) => batch.needsAttention).length;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Production Overview',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                QuickStatWidget(
                  label: 'Active Batches',
                  value: '$activeBatches',
                  icon: Icons.agriculture,
                  color: Colors.green,
                ),
                QuickStatWidget(
                  label: 'Ready to Harvest',
                  value: '$readyToHarvest',
                  icon: Icons.eco,
                  color: Colors.blue,
                ),
                QuickStatWidget(
                  label: 'Need Attention',
                  value: '$needAttention',
                  icon: Icons.warning,
                  color: Colors.orange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}