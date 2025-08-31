import 'package:flutter/material.dart';
import 'package:agri/core/model/production_batch_model.dart';

class ProductionCardWidget extends StatelessWidget {
  final ProductionBatch batch;
  final VoidCallback? onDetailsPressed;
  final VoidCallback? onUpdatePressed;
  final VoidCallback? onDeletePressed;

  const ProductionCardWidget({
    Key? key,
    required this.batch,
    this.onDetailsPressed,
    this.onUpdatePressed,
    this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            _buildDetails(),
            const SizedBox(height: 12),
            _buildProgressSection(),
            if (batch.hasIssues) ...[
              const SizedBox(height: 12),
              _buildIssuesSection(),
            ],
            const SizedBox(height: 16),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          batch.image,
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${batch.crop} - ${batch.variety}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                batch.id,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        _buildStatusChip(),
      ],
    );
  }

  Widget _buildStatusChip() {
    Color chipColor;
    Color textColor;

    switch (batch.status.toLowerCase()) {
      case 'ready':
        chipColor = Colors.blue;
        textColor = Colors.white;
        break;
      case 'needs attention':
        chipColor = Colors.orange;
        textColor = Colors.white;
        break;
      case 'completed':
        chipColor = Colors.grey;
        textColor = Colors.white;
        break;
      case 'on track':
      default:
        chipColor = Colors.green;
        textColor = Colors.white;
        break;
    }

    return Chip(
      label: Text(
        batch.status,
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: chipColor,
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _buildDetails() {
    return Column(
      children: [
        _buildDetailRow('Location', batch.location, Icons.location_on),
        const SizedBox(height: 8),
        _buildDetailRow('Current Stage', batch.currentStage, Icons.eco),
        const SizedBox(height: 8),
        _buildDetailRow('Quantity', '${batch.quantity} plants', Icons.agriculture),
        const SizedBox(height: 8),
        _buildDetailRow(
          'Days Remaining',
          batch.daysRemaining > 0 ? '${batch.daysRemaining} days' : 
          batch.daysRemaining == 0 ? 'Ready now' : 'Overdue by ${batch.daysRemaining.abs()} days',
          Icons.schedule,
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Progress: ${batch.progress}%',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: batch.progress / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      batch.progress >= 100 ? Colors.green :
                      batch.progress >= 75 ? Colors.blue :
                      batch.progress >= 50 ? Colors.orange : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              children: [
                const Icon(Icons.favorite, color: Colors.red, size: 16),
                const SizedBox(height: 2),
                Text(
                  '${batch.health}%',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Health',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIssuesSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.warning, color: Colors.orange, size: 16),
              SizedBox(width: 8),
              Text(
                'Issues:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ...batch.issues.map((issue) => Padding(
                padding: const EdgeInsets.only(left: 24, top: 2),
                child: Text(
                  '• $issue',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        if (onDetailsPressed != null)
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onDetailsPressed,
              icon: const Icon(Icons.visibility, size: 16),
              label: const Text('Details'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF4CAF50),
                side: const BorderSide(color: Color(0xFF4CAF50)),
              ),
            ),
          ),
        if (onDetailsPressed != null && onUpdatePressed != null)
          const SizedBox(width: 8),
        if (onUpdatePressed != null)
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onUpdatePressed,
              icon: const Icon(Icons.edit, size: 16),
              label: const Text('Update'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                foregroundColor: Colors.white,
              ),
            ),
          ),
        if (onDeletePressed != null) ...[
          const SizedBox(width: 8),
          IconButton(
            onPressed: onDeletePressed,
            icon: const Icon(Icons.delete, color: Colors.red),
            tooltip: 'Delete Batch',
          ),
        ],
      ],
    );
  }
}